# In-app messages runbook: how Ink raises a message on its own

> Read this before adding an in-app message, changing who one is for or how often
> it comes back, switching one off from the server, or debugging "the message never
> shows" or "it keeps showing".

An **in-app message (IAM)** is a sheet Ink raises without being asked, such as
"a better way to update your lock screen". Every message goes through **one** catalog, **one**
scheduler and **one** sheet design. No message can pick its own moment or its own
layout.

## TL;DR

| I want to… | Do this |
|---|---|
| Add a message | [Adding a message](#adding-a-message): an id, a catalog row, its copy, translations, tests |
| Switch a shipped message off without a release | Remote Config `in_app_messages_v1` = `{"disabled": ["<id>"]}`, in **both** Firebase projects |
| Turn on the "update shortcut" messages | Nothing to set: this build serves V2, so anyone on the Lock-Screen-only shortcut is behind. See the [wallpaper runbook's V2 migration](wallpaper-shortcut-changes.md#the-v2-migration) |
| Nudge people whose old shortcut still runs | `shortcut_remove_old`, on by itself once the old shortcut renders after the move to V2 |
| See a message on the simulator | [QC](#qc-on-the-simulator) |

## The pieces

| Layer | File | Job |
|---|---|---|
| Domain | `Domain/InAppMessage/InkInAppMessage.swift` | The model: `id`, `priority`, `policy`, `action` and `isEligible(context)`, plus `InkInAppMessageContext`, the facts eligibility is judged on |
| Domain | `Domain/InAppMessage/InkInAppMessageCatalog.swift` | Every message, in one list |
| Domain | `Domain/InAppMessage/InkInAppMessageScheduler.swift` | Picks the one message due this foreground. It owns the app-wide rules |
| Domain | `Domain/InAppMessage/InkInAppMessageConfig.swift` | Remote Config kill switch |
| Data | `Data/InkInAppMessageStore.swift` | Shows per message and when (`ink.iam.*`) |
| Data | `Data/InkInAppMessageContext+Live.swift` | Builds the facts from local stores |
| UI | `UI/InAppMessage/InkInAppMessageContent.swift` | What each message SAYS (picture, copy, promises or steps) |
| UI | `UI/InAppMessage/InkInAppMessageSheet.swift` | The ONE way a message is drawn |
| UI | `UI/InAppMessage/InkInAppMessagePresenter.swift` | Show → answer → route, with analytics |
| UI | `UI/InAppMessage/InkInAppMessageHost.swift` | The sheet plus every destination its button leads to. Attached once, at `AppShellView`'s root |

### Who sees it: facts, not flags

`isEligible` is a pure function of `InkInAppMessageContext`: open count, OS
automation style, whether the shortcut is installed, which generation is installed,
and which generation is served. There is no "done" flag to set. A message
stops the moment its reason is gone. For example, a user who updates the shortcut
by any route (the message, Settings, re-adding by hand) never sees the update
message again.

If a new message needs a new fact, add a **field** to the context and a read in
`InkInAppMessageContext.live`. Never read a store inside a predicate: predicates
stay pure so tests can drive every row of the truth table.

### How often: the scheduler's rules come first

App-wide rules that no message can opt out of (`InkInAppMessageScheduler`):

- **Never on the first app open.** That session belongs to onboarding and the
  first lock screen (`minimumAppOpens = 2`).
- **At most one message per 24 h, across all messages** (`globalGap`). A second
  message must not turn a week into a queue of sheets.
- **A disabled id is skipped** (Remote Config).
- Highest `priority` wins. On a tie, catalog order wins.

Then each message's own `policy`. `.gentleNudge` = **3 shows at most, 3 days
apart**, for anything optional. A show is counted only when the sheet actually
goes up. If a message was picked and the screen was then blocked, it keeps its
chance.

### When: one slot in the shell's foreground chain

`AppShellView`'s foreground pass hands out at most one prompt per foreground:

```
automation proposal → push permission (2nd open only) → in-app message → rating prompt
```

The message waits one second for the UI coming back from Shortcuts to settle. It
then checks again that the root is free (`canPresentInAppMessage`): no launch
paywall, no Pro paywall, Settings not pushed, none of the shell's covers, no
coach tour, no setup flow, and nothing presented by a deeper screen
(`InkWindowPresentation.isRootCovered`). The last check exists because a sheet
raised from the root while the template editor's cover is up never appears. Its
binding just stays set.

### What it says: one sheet, one shape

`InkInAppMessageSheet` = a header picture (`.artwork`, cropped and faded at the foot;
or `.screenshot`, shown whole) with the title over its foot + an optional lead sentence
+ EITHER up to two promise rows (`highlights`) OR numbered `steps` + the primary
`AppButton(.large)` with an optional small caption under it. The detent is 700pt,
or 540pt for a `.short` message (`sheetHeight`). There is **no**
way-out button: a swipe is the dismiss. A new message supplies **copy and one
picture**, never a layout. Design rules are in
[`docs/design-system/popups.md`](../design-system/popups.md).

### Where the button goes: actions the shell routes

`InkInAppMessageAction` names a destination. `InkInAppMessageHost` routes it
**after** the sheet has finished leaving (`sheetDidDismiss`), because a cover
raised while a sheet is animating out never appears. Today there are three:
`.updateShortcut` → `SetupShortcutFlowView` in `.update` mode,
`.openShortcutsApp` → the Shortcuts app itself (the delete nudge carries its
two-tap guide in the sheet, so it needs no flow), and `.openCurrentWallpaper` →
Discover, where `HomeScreen` opens the collection's active wallpaper in its
editor (`InkDiscoverBrowseRouter.requestCurrentWallpaper`).

### Analytics

- `in_app_message_shown` {message_id}
- `in_app_message_action` {message_id, action: primary|dismiss}

A swipe is the `dismiss` — there is no way-out button. The update messages then continue
as the ordinary setup funnel under `source: in_app_message`,
`kind: setup_shortcut_update`, including
`setup_verify_result.reason = still_old_shortcut`. See
[analytics.md](analytics.md) for the parameter vocabulary.

## The two shortcut-update messages

The old shortcut **keeps working**, so both messages ask and never insist. The
copy says updating is optional and sells what the new shortcut adds.

The copy talks about the **lock screen**, not the shortcut. Users know Ink
updates their lock screen. Most of them set up the shortcut once and forgot it.
The word "shortcut" first appears in the update flow, which has to name it
because it sends the user to the Shortcuts app.

| id | Shown when |
|---|---|
| `shortcut_update_home_screen` | iOS ≤26 · shortcut installed · the installed one is **lock only** · the served one is **Home Screen** or newer |
| `shortcut_update_ios27` | iOS 27 · shortcut installed · the installed one is **lock only**. Not V2 set up on iOS 26: the iOS 27 link has the same name, so installing it would offer Replace, which leaves the working automation calling a hidden copy |
| `shortcut_remove_old` | On V2 by name · the OLD shortcut rendered after the move, within 7 days (`InkShortcutMigration.isOldShortcutStillRunning`). A guide in the sheet (screenshot of the menu, numbered steps 1 "press and hold" · 2 "tap Delete"); "Open Shortcuts" goes straight to the app |

A device can match at most one of the two update messages (pinned by a test).

### How Ink knows which shortcut someone has (`InkShortcutGeneration`)

| Generation | Raw | How Ink knows |
|---|---|---|
| `lockOnly` | 1 | The last render had no mode request beside it |
| `homeScreen` | 2 | `GetInkWallpaperModeIntent` stamped within 120 s of the last render |
| `builtInTriggers` | 3 | `homeScreen` **plus** `InkShortcutGenerationStore.recorded()` = 3. Triggers leave no stamp, so this rests on the record written when a setup flow opened the iOS 27 link and then proved a run |

**On V2 by name, the stamps stop deciding**: an install whose resolved name is today's
is at least `homeScreen`. A render with no mode request there is the old shortcut still
wired to an automation, not a downgrade — without this rule it would bring the update
message back to someone who already took it.

What the link on offer installs ("served") follows from the V2 link: `homeScreen` on
iOS ≤26, `builtInTriggers` on iOS 27. It is mirrored into `UserDefaults` at the splash
warm-up (`InkShortcutGenerationStore.served()`), for the same reason the name is
mirrored.

### The update flow (`SetupShortcutMode.update`)

- It runs **`InkShortcutNameStore.latest()`** (V2), and pins that name on proof
  (`markInstalledAsLatest`), remembering the old one for the delete step. V2 has a
  NEW name, so it lands next to the old shortcut; there is no Replace prompt.
- **Proof must be the NEW shortcut.** A run that never asks for the mode fails with
  `stillOldShortcut`.
- **Then the delete step (skippable), then the automation page — always.** The old
  automation keeps calling the old shortcut; deleting the shortcut deletes it.
  The Home Screen gate opens this same flow (see the
  [wallpaper runbook](wallpaper-shortcut-changes.md#the-v2-migration)).
- Closing the flow costs nothing (no exit confirmation): the old shortcut still
  works.

### Known limits

- **"Keep Both" on iOS 27, from a Home Screen shortcut:** the old copy still asks
  for the mode, so the proof passes and generation 3 is recorded, even though the
  old copy (without triggers) is what runs. The Automation tab also shows the new
  copy's triggers. Rare; re-adding with Replace fixes it.
- **Replace on iOS 27 keeps the old copy's triggers as separate automations** (see
  the wallpaper runbook). Harmless while they are off.
- A user who reaches `maxShows` without updating is not asked again. The update
  can still be done from Settings → the shortcut walkthrough (it installs the
  served link), and the shortcut-updated state is picked up from the stamps
  either way.

## The missing-photo message

`wallpaper_photo_missing` (priority 20, above the shortcut messages) asks the user
to pick their photo again when the wallpaper still names one of their own photos
that is gone from disk (`InkMissingWallpaperPhoto`): any background of the active
lock layout, or the Home Screen's own photo in `.custom` mode. Catalog pictures do
not count; they download again. Builds v1.2.14 to v1.2.19-rc6 deleted such photos
by mistake (the asset sweep compared `/var` with `/private/var`). The message stops
by itself once the photo is picked again.

Until then, the shortcut sets the Lock Screen only (`isOwnPhotoMissing` in
`GetInkWallpaperModeIntent`), so the photo iOS still shows on the Home Screen is not
overwritten with the lock backdrop.

QC: with the app terminated, point the active lock layout at a photo that is not
there, in the app's OWN preferences file (`simctl spawn … defaults` writes the
simulator's global domain, which the app never reads), then launch.

```bash
PLIST="$(xcrun simctl get_app_container booted $APP data)/Library/Preferences/$APP.plist"
python3 - "$PLIST" <<'PY'
import json, plistlib, sys
d = plistlib.load(open(sys.argv[1], "rb"))
style = json.loads(d["ink.wallpaper.lock_screen_style.v2"])
style["layouts"][style["activeLayoutKind"]]["backgrounds"] = [{"path": "wallpaper_backgrounds/gone.jpg"}]
d["ink.wallpaper.lock_screen_style.v2"] = json.dumps(style)
plistlib.dump(d, open(sys.argv[1], "wb"))
PY
xcrun simctl spawn booted killall -9 cfprefsd
```

The button opens the editor only when the collection has a current wallpaper; without one it stops on Discover.

## Adding a message

1. **Id.** Add a case to `InkInAppMessageId`, snake_case raw value. It is an
   analytics value, a `UserDefaults` key segment and a kill-switch entry, so never
   rename it.
2. **Catalog row.** Add it to `InkInAppMessageCatalog.all`: `priority`, `policy`
   (start from `.gentleNudge`) and `isEligible` over context facts. If a fact is
   missing, add it to the context first.
3. **Copy.** Add a case in `InkInAppMessageContent.content(for:)`: a picture
   (`.artwork` or `.screenshot` asset), a title, an optional lead, up to two
   highlights OR a list of steps, the caption under the button (or nil), the
   button's title and symbol, and `sheetHeight`. Put the strings in `InkInAppMessageStrings`.
4. **Translations.** Add every new key to `Localizable.xcstrings` for all 12
   languages ([localization runbook](localization.md)), then `git add` the catalog
   straight away (Xcode rewrites it from memory).
5. **Destination.** Only if the button goes somewhere new: add an
   `InkInAppMessageAction` case and route it in `InkInAppMessageHost`.
6. **Tests.** Cover the eligibility truth table in `InkInAppMessageTests`, and
   extend the "never overlap" test if the new message competes with an existing
   one.
7. **Preview.** Add a `#Preview` in `InkInAppMessageSheet.swift`.

## QC on the simulator

**Quickest: Settings → Debug → In-app messages** (any dev-bundle build,
including the Firebase one). The card shows the facts the shell judges on
(opens, installed and served generation), which message the next foreground
would raise (`Next foreground`), and how often each has been shown.

**Reset show history** clears `ink.iam.*`, so the real schedule starts over.
There is no button that forces a message up: seed the facts below and let the
real scheduler raise it.

To test the real path (the foreground chain and its rules), seed the facts
instead. They come from `UserDefaults`. Seed them on a booted simulator, then
foreground the app twice (never on the first open):

```bash
APP=com.silverai.calendar.lockscreen.dev
xcrun simctl spawn booted defaults write $APP ink.wallpaper.shortcut_installed.v1 -bool YES
# a render with no mode request = the lock-only shortcut
xcrun simctl spawn booted defaults write $APP ink.wallpaper.last_generated_at.v1 -float $(date +%s)
xcrun simctl spawn booted defaults delete $APP ink.wallpaper.mode_requested_at.v1
# what the link on offer installs: 2 (iOS ≤26) or 3 (iOS 27)
xcrun simctl spawn booted defaults write $APP ink.wallpaper.shortcut_generation.served.v1 -int 2
# start the message's history over
for k in $(xcrun simctl spawn booted defaults read $APP | grep -o '"ink\.iam[^"]*"' | tr -d '"'); do
  xcrun simctl spawn booted defaults delete $APP "$k"; done
```

The splash warm-up overwrites `…served.v1` on every launch, from the OS.

For `shortcut_remove_old`: record V2 as installed and stamp an old-shortcut run.

```bash
xcrun simctl spawn booted defaults write $APP ink.wallpaper.shortcut_name.v1 "Ink Refresh Lock Screen V2"
xcrun simctl spawn booted defaults write $APP ink.wallpaper.legacy_run_at.v1 -float $(date +%s)
```

Checklist:

- [ ] iOS ≤26, lock-only shortcut, served 2 → "A better way to update your lock screen" on the 2nd open
- [ ] iOS 27, served 3 → "Ink is ready for iOS 27"
- [ ] Swipe the sheet down → nothing for 24 h across all messages, and this message not for 3 days
- [ ] After 3 shows → never again
- [ ] "Get the new shortcut" → sheet leaves, then the update flow opens (title "Add the new shortcut.")
- [ ] Add V2 + run → success → "Delete your old shortcut." (Skip for now / Open Shortcuts) → the automation page
- [ ] On V2 with an old-shortcut run stamped → "Two Ink shortcuts are running" (menu screenshot, two steps) → "Open Shortcuts" opens the Shortcuts app
- [ ] `in_app_messages_v1` = `{"disabled":["shortcut_update_ios27"]}` → the iOS 27 message never shows
- [ ] Never over the launch paywall, a Pro paywall, Settings, the template editor or the coach tour

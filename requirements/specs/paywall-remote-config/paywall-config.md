# Runbook — Paywall remote config (`pro_paywall_config_v1`)

The paywall's **content** is remote; its **layout** is not. One RemoteConfig key
carries the copy, the benefit rows, the hero artwork and the plan rows, and
every one of them falls back to what the app ships with.

Read this before editing the key, adding a variant, or debugging "my experiment
never showed up".

> Setting the config up in the Firebase Console, or handing a test plan to QC?
> That is [`paywall-qc-vi.md`](paywall-qc-vi.md) — same key, written as steps
> rather than as a schema.
>
> Writing the payload itself? Open
> [`docs/tools/paywall-config-builder.html`](../tools/paywall-config-builder.html)
> in a browser — a form over this schema that renders the paywall as you type,
> flags every rule below, and hands you the JSON to paste into the Console or
> into an A/B test variant.

## Why the paywall is treated more carefully than the catalogs

`ProScreen` is the app's revenue surface **and** — through
`LaunchPaywallGateView` — the first screen a non-entitled user sees at launch.
A value that empties it does not look like a bug to the user; it looks like an
app with nothing to sell. So:

- The **envelope** is all-or-nothing (kill switch, `schema_version`,
  `min_app_version`): a payload aimed at another build is discarded whole, never
  half-applied.
- Each **field** falls back on its own: one malformed benefit row must not cost
  the experiment its headline.
- A config that produces **no buyable row** is retried against the bundled
  plans before the user is shown anything.

## Keys

| Key | Status | Who reads it |
|---|---|---|
| `pro_paywall_config_v1` | **live** | builds carrying `c711ceb4` or later |
| `pro_plan_config` | **frozen** | shipped builds, and new builds when v1 declares no `plans` |
| `pro_legal_urls` | live | terms / privacy links (unchanged) |

Which builds those are is checkable rather than a guess —
`git merge-base --is-ancestor c711ceb4 <ref>` answers it. Setting the v1 key for
an audience that has not got that commit yet is inert: nothing breaks, nothing
changes, and the paywall renders exactly as it would with no config at all,
which is indistinguishable on screen from a payload that was rejected.

`pro_plan_config` is frozen, not dead: builds already on phones read only that
key. A plan change that must reach them goes there. A build that understands v1
ignores the old key entirely **whenever v1 carries `plans`** — mixing the two
would let one variant's headline land over another variant's plans.

## Schema

```jsonc
{
  "schema_version": 1,            // > 1 ⇒ this build ignores the whole payload
  "min_app_version": "1.2.16",    // below it ⇒ ignored wholesale; omit if unsure
  "use_bundled_paywall": false,   // true ⇒ kill switch, ship the bundled screen
  "variant": "hero_b_vi",         // experiment label — see Analytics below

  "headline": { "en": "Unlock everything", "vi": "Mở khoá tất cả" },
  "subtitle": { "en": "…", "vi": "…" },

  "hero": { "image_url": "https://cdn.example.com/paywall-hero-b.png" },

  "benefits": [
    { "icon": "calendar", "tint": "accentPink",
      "title": { "en": "Unlimited calendars", "vi": "Không giới hạn lịch" } }
  ],

  "plans": [
    { "product_id": "com.silverai.calendar.lockscreen.pro.weekly",
      "period": "weekly", "type": "subscription",
      "show": true, "preselected": true, "badge": "popular",
      "title":    { "en": "Get {trial}", "vi": "Nhận {trial}" },
      "title_no_trial": { "en": "Weekly", "vi": "Hằng tuần" },
      "subtitle": { "en": "Billed weekly", "vi": "Tính theo tuần" } },

    { "product_id": "com.silverai.calendar.lockscreen.pro.annual",
      "period": "annual", "type": "subscription",
      "badge": "best_value", "discount": 0.6 }
  ]
}
```

Keys are **snake_case** here. The frozen `pro_plan_config` uses camelCase —
do not copy its field names across.

## Field rules

### Copy — `headline`, `subtitle`, and every `title`

Localized maps, resolved **current language → `en` → any value**. The language
is the device's language CODE, so a `zh-Hant` device reads the `zh` values.

- **Key absent → the bundled `Localizable.xcstrings` string.** The catalog keeps
  every string; the config only overrides.
- **Value `""` → hides** the subtitle (and a plan subtitle). The headline is the
  exception: blank falls back, because a paywall with no headline is broken and
  clearing a field must not be a way to ship one.
- Non-string values are dropped per locale; a map with nothing usable reads as
  absent.

The headline is 32pt and does not scale with Dynamic Type. It is capped at three
lines — keep it under ~30 characters per language or it will shrink.

### `hero.image_url`

**https only.** A remote hero is adopted **only once the file is already in the
image cache** — the first launch that sees a new URL still draws the bundled
art and warms the cache, and the swap happens on the *next* appearance. That is
deliberate: this is the first screen after the splash, and both an empty frame
and a picture that swaps mid-decision cost more than showing shipped art one
session longer.

Practical consequence: **a new hero reaches a given user one launch late.**
Publish it a day before the experiment starts.

The frame is fixed (172pt tall, `scaledToFit`), so artwork can only change what
is drawn, never where anything sits. Match the bundled banner's proportions.

### `benefits`

- Absent → the three bundled rows. `[]` → the block is hidden.
- Capped at **5** rows (`PaywallConfigDecoder.maxBenefits`); extras are dropped.
- A row without `icon` or `title` is skipped.
- `icon` is an SF Symbol name, validated **on the running OS** — a symbol added
  in a later iOS resolves on one device and not another, and an unresolved one
  draws the `sparkles` fallback rather than an empty tile.
- `tint` is a **token name**, never a hex string: `accentPink · accentMint ·
  accentCoral · accentAmber · accentCyan · accentBlue · accentGreen ·
  brandViolet`. An unknown name falls back to `brandViolet` and **keeps** the
  row — the words are the benefit. Hex is refused because every `InkColors`
  token carries a dark-mode half a console value cannot.
- Row text is capped at 2 lines. The block is deliberately indented 80pt each
  side, which leaves ~233pt on a phone — keep benefit text short.

### `plans`

- **Order is array order.** There is no `index` field; two rows sharing a number
  in the frozen key left the sort free to order them either way between runs.
- `product_id`, `period` (`weekly|annual|lifetime`) and `type`
  (`subscription|lifetime`) are required; a row missing any of them is skipped.
- `show` defaults to **true** (unlike the frozen key): a row you listed is a row
  you meant to offer.
- `preselected` picks the row that starts selected. It is split out of
  `recommended`, which also draws the badge — so preselecting weekly while
  badging annual is now expressible. Two `preselected` rows resolve to the
  earlier one.
- `badge` is `best_value` or `popular` — an enum, because the badge is a claim
  the app renders in its own voice, translated. A console-typed string would
  ship untranslated to ten locales.
- `discount` (0…1) drives the "-60%" pill and the struck-through price. It is
  **presentation only** — the struck price is computed as
  `price / (1 - discount)`, i.e. a claim, not a price the store ever charged.
  Treat it accordingly.

### `{trial}` — the one token, and why it exists

A `title` containing `{trial}` renders **only when StoreKit reports a free trial
this user can still claim**. The token expands to the app's own localized trial
phrase ("3-day free" / "3 ngày miễn phí"); the LENGTH never comes from this
file.

Without a claimable offer the row falls back to `title_no_trial`, then to the
bundled plan name. A `title` with no token is a plain title and is used either
way.

This replaced the old `introductoryOfferPeriod` field, which was a string typed
into the console that the screen printed straight into the row title and the
CTA. It said "Start 3-day free trial" whether or not App Store Connect carried
the offer, and whether or not the user had already spent their eligibility
(eligibility is per subscription **group** and is spent on first use). The field
is still decoded so the frozen key keeps its shape — **it no longer makes the
app say "free"**, and must not be reintroduced as a display source.

Note also that a paid introductory offer ("$0.99 for the first month") is an
introductory offer too. Only `paymentMode == .freeTrial` may be advertised as
free.

## Analytics

`variant` is reported two ways, and you need both:

- as a param on `pro_paywall_viewed`;
- as the **`paywall_variant` user property**, set at launch from
  `SplashGateView` — which is what makes `pro_plan_selected`,
  `pro_purchase_started` and `pro_purchase_succeeded` segmentable too. A funnel
  cut on the view event alone cannot tell you which variant converted.

The property is always written, `nil` included (as `"bundled"`): user properties
persist across sessions, so an install left on a finished experiment's label
would poison every later cut.

**Writing it is not enough — GA4 has to be told the property exists.** Register
`paywall_variant` under Admin → Custom definitions → Custom dimensions, scope
**User**, once per project (dev and prod separately). Until then the value is
collected but appears in no report, so the funnel cannot be cut by variant —
which is the whole reason the property exists. GA4 builds the dimension from the
registration date forward and does not backfill, so register it BEFORE starting
an experiment, not after the first confusing result.

## What is deliberately NOT configurable

- **Layout** — element order, positions, sizes, the hero's frame.
- **Colors, spacing, radii** beyond the tint allow-list. Those are design-system
  ladders; a hex typed into a console has no dark-mode half and no Dynamic Type
  review.
- **The auto-renew disclosure and the Terms / Privacy row.** Store requirements,
  not experiment surface. The URLs are configurable (`pro_legal_urls`); their
  presence is not.
- **The close-button delay and how often the launch paywall appears.** Both are
  still hardcoded — see `ProScreen` and `LaunchPaywallGateView`.

## Failure modes

| Symptom | Cause | Where to look |
|---|---|---|
| Experiment never appears | The build predates `pro_paywall_config_v1` and reads only `pro_plan_config` | `git merge-base --is-ancestor c711ceb4 <ref>` |
| Experiment never appears | `min_app_version` above the build, `schema_version` > 1, or `use_bundled_paywall: true` | Console log, category `paywall-config`: "using bundled paywall: …" |
| Published an hour ago, still not showing on prod | `minimumFetchInterval` is 3600 on prod (0 on dev), and only a COLD launch fetches | `InkFirebaseBootstrap`; reinstall to bypass |
| One plan row missing, the rest fine | `period` is not one of `weekly` / `annual` / `lifetime` — `yearly` is not a case — or `product_id` / `type` is wrong | the row is dropped on decode, silently |
| Paywall shows bundled plans, not mine | every row hidden, or `product_id`s the store does not carry | log: "paywall config yielded no buyable rows" |
| "Couldn't load Pro plans" | the store answered nothing for the bundled ids too — a real store/network problem, not the config | — |
| Hero still the old picture | the new URL was not cached yet; it swaps next launch | by design, see `hero.image_url` |
| A benefit shows a sparkle icon | the SF Symbol name does not resolve on that iOS | check the symbol's availability |
| Copy is English on a Vietnamese phone | that locale is missing from the map, and `en` is the fallback | add the `vi` key |
| A row says "Weekly" instead of my title | the title used `{trial}` and the store has no claimable offer | expected — set `title_no_trial` |

## Changing the schema

Adding an OPTIONAL field needs no version bump: older builds ignore what they
do not read, and every field falls back on its own. Bump `schema_version` (and
the app's `PaywallConfig.supportedSchemaVersion`) only when a payload would be
**misread** by a shipped build — then old builds fall back cleanly instead of
rendering half an offer.

# PRD: Shared calendars — live sharing inside Ink

**Document Version:** 1.9  
**Status:** Draft — product flow aligned, remaining open questions in §9  
**Product:** Ink (iOS / LockScreen Calendar)  
**Date:** 2026-09-14  
**Based on:** v1.1

> **1.7 (2026-09-14):** account sign-in now supports both Sign in and Sign in with Google. Account identity remains app-level and independent from calendar-provider connections.
>
> **1.6 (2026-09-14):** removed subscriber counting from v1. Subscriber/member tracking is deferred to the future invite/access-management phase so v1 does not introduce partial subscription infrastructure only to show a count.
>
> **1.5 (2026-09-14):** previously proposed anonymous subscriber counting for v1; superseded by v1.6.
>
> **1.4 (2026-09-14):** clarified access-control extensibility. v1 remains public-link sharing,
> but the product model treats a share as an owned resource with an access policy, so future
> invite-only or hybrid sharing can be added without redefining the core share object.
>
> **1.3 (2026-09-14):** clarified source-calendar ownership, share/source state separation,
> logout/re-login behavior, source-unavailable states, and self-share handling to prevent duplicate calendars.
>
> **1.2 (2026-09-14):** product direction simplified around an Ink-native sharing experience.
> Shared calendars are consumed inside Ink only. JSON remains the share payload and source of truth;
> ICS/webcal interoperability is removed from this version.
>
> Account is an Ink-level identity managed in Settings, not a separate “sharing account”.
> Login is required only when the user performs an action that needs ownership, such as creating
> or managing a share.
>
> Information architecture is calendar-first: sharing is managed from each calendar’s Manage screen.
> One calendar has one active share link in v1.

---

## 1. Context & problem

### 1.1 Current state

Ink already has “Share a calendar as a link”:

1. Sender chooses a calendar.
2. Ink exports a future window as JSON.
3. Backend stores the payload and returns an HTTPS link.
4. Receiver opens the link and imports a new calendar.

The current experience behaves like a snapshot rather than a live shared calendar.

### 1.2 Problems to solve

**P1 — Snapshot, not a living calendar.**  
If the sender changes the source calendar later, receivers do not automatically get the latest state.

**P2 — Sender loses control after creating the link.**  
There is no durable place in the product to return to a calendar and answer:

- Is this calendar currently shared?
- What can people see?
- What is the link?
- When was it last updated?
- When does it expire?
- How do I stop sharing?

**P3 — Current UX still carries an “import” mental model.**  
The new feature is not a one-time copy. The receiver is following a read-only calendar owned by someone else.

### 1.3 Product positioning

> **Share a live calendar with anyone on Ink.**

The sender shares once. The receiver adds the calendar to Ink. While sharing remains active, new and changed events are reflected when Ink gets an opportunity to refresh.

The receiver does not gain edit access to the sender’s calendar.

---

## 2. Product decisions

### 2.1 D1 — JSON is the single share format

**Decision:** Ink exports and consumes JSON for shared calendars.

```text
Sender calendar
      │
      │ export
      ▼
    JSON
      │
      ▼
   Backend
      │
      ▼
    JSON
      │
      ▼
Receiver in Ink
```

There is no ICS/webcal path in this version.

The public HTTPS link is a hand-off into the Ink experience, not a universal calendar subscription feed. The public page may show the owner’s Ink public display name (for example, “Shared by Alex”) and a limited preview of roughly 3–6 upcoming events, subject to sharing privacy rules.

### 2.2 D2 — Shared calendar is read-only for the receiver

A received calendar is treated as a remote shared source inside Ink.

Receiver can customize local presentation such as:

- display name;
- color;
- symbol.

Receiver cannot edit source events.

This avoids a two-way-sync mental model and keeps ownership clear:

> Sender owns event content. Receiver controls only how the shared calendar looks inside their Ink.

### 2.3 D3 — Account belongs to Ink, not to Sharing

Ink has one account concept.

Supported v1 sign-in methods:

- **Continue with Apple**
- **Continue with Google**

These are authentication methods for the same Ink account concept in the UI, but in v1 they create/resolve separate Ink accounts unless explicit account linking exists.

Do not auto-merge Apple and Google accounts based on matching email.

Ink account may also have an editable **public display name** used on public share surfaces such as:

> Shared by Alex

This display name is an Ink profile field. It is not treated as verified identity merely because it originated from Apple or Google account metadata.

A user’s Google Calendar connection and Google login identity are separate product concepts:

- connecting Google Calendar grants Ink access to calendar data;
- signing in with Google authenticates the Ink account.

The UI should not imply that connecting Google Calendar automatically signs the user into Ink, or vice versa.

Account lifecycle lives under:

```text
Settings
└── Account
    ├── Sign in
    ├── Sign out
    └── Delete account
```

There is no “sharing account”.

Signing in is **not required to browse or manage local calendars**.

Authentication is requested only when the user performs an action that requires identity/ownership, such as:

- creating a share;
- managing an existing share owned by the account.

Product rule:

> **Calendar management does not require login. Sharing ownership does.**

### 2.4 D4 — Calendar-first information architecture

The canonical path to sharing is through the calendar itself.

```text
Calendars
    │
    ▼
Manage Calendar
    │
    └── Sharing
         ├── Share calendar
         └── Manage sharing
```

A global “Sharing” overview is out of scope for v1. Calendar-first management is the only management path in this version.

Users should think:

> “I want to manage sharing for Work.”

not:

> “I need to find a share record.”

### 2.5 D5 — One calendar = one active share link in v1

A calendar can have at most one active share at a time.

State model:

```text
Not shared
   │
   │ Share calendar
   ▼
Shared
   │
   │ Stop sharing
   ▼
Not shared
```

This intentionally avoids the v1 complexity of:

- multiple audiences;
- multiple links;
- link labels;
- per-link privacy settings;
- per-link expiry.

A future multi-link model should be a separate product decision.

### 2.6 D6 — “Live” means automatic publishing when Ink has an opportunity

Creating a share should not create a manual maintenance burden.

Expected mental model:

> “I changed my calendar. People following it in Ink will get the latest version.”

Therefore:

- Ink should refresh/publish active shares automatically when it has a suitable opportunity;
- receiver pulls the latest shared state when Ink refreshes;
- **Refresh now** may exist as a manual fallback, but is not the normal publishing mechanism.

The product must not require the sender to remember to press “Update now” after every calendar change.


### 2.7 D7 — Source calendar content and Ink share state are separate

For calendars connected through Apple Calendar/EventKit or another supported provider:

> **The source calendar remains the source of truth for calendar content. Ink owns the sharing state.**

Ink does not create a second editable copy of the sender’s calendar.

Ink share state may contain:

- share ID / link;
- owner account;
- optional public owner display name for public share surfaces;
- source calendar reference;
- visibility settings;
- access policy (`anyone_with_link` in v1);
- expiry;
- last published state;
- current JSON snapshot used by receivers.

When the source calendar changes, Ink republishes the latest eligible state into the existing share.

Manage Sharing edits sharing settings only. It does not become a second place to edit event content.

### 2.8 D8 — Share eligibility is based on ownership, not provider

A calendar may be shared through Ink when the user controls the source calendar, regardless of whether it originates from iCloud, Google, Outlook, or another supported provider.

Examples:

| Source calendar | Share through Ink in v1 |
|---|---:|
| User-owned iCloud calendar | Yes |
| User-owned local calendar | Yes |
| User-owned Google calendar | Yes |
| User-owned Outlook calendar | Yes |
| Read-only calendar managed by someone else | No |
| Subscribed/public calendar | No |
| System-generated calendar such as holidays | No |
| Calendar received through Ink sharing | No re-share |

Product rule:

> **You can share calendars you control.**

A received Ink shared calendar cannot be re-shared in v1. This avoids share chains where the original owner loses control over distribution.

### 2.9 D9 — Share identity never relies on calendar name

Calendar names are presentation only.

Ink must not treat two calendars as the same merely because they have the same name, color, or provider label.

Product behavior must remain correct when:

- two calendars have the same name;
- a calendar is renamed;
- an account is disconnected and reconnected;
- the original source becomes temporarily unavailable;
- a calendar is deleted and another calendar with the same name is later created.

Where the original source cannot be confidently matched, the share remains a server-owned share record and is surfaced as **Source calendar unavailable** rather than silently attaching to another calendar.

### 2.10 D10 — The owner never follows their own share

If a user opens their own share link while signed out, Ink may initially treat the link like any receiver link.

After the user signs in, if Ink determines that the current account owns that share:

> **Do not add a receiver copy of the same calendar. Route the user to Manage Sharing.**

If a receiver copy was already added locally before login, Ink should reconcile it after ownership is known:

- preserve the original source calendar;
- remove/merge the self-following shared copy;
- keep receiver-local presentation only when it can be safely applied without ambiguity;
- route the user to Manage Sharing.

This prevents duplicate states such as:

```text
Work
Work · Shared
```

for the owner of the same share.


### 2.11 D11 — A share is an owned resource with an access policy

Do not model a share as merely “a public URL”.

The durable product object is:

```text
Share
├── owner
├── source calendar
├── published content
├── sharing settings
└── access policy
```

In v1, the only supported policy is:

```text
access = anyone_with_link
```

This means anyone who obtains a valid link can open the shared calendar in Ink.

Future versions may add policies such as:

```text
access = invited_people
access = hybrid
```

without changing the core mental model of the share itself.

v1 does **not** expose:

- invite-by-email;
- member lists;
- accepted/pending states;
- subscriber identities;
- per-person permissions.

This is intentional scope control, not a permanent product limitation.


### 2.12 D12 — Subscriber/member tracking is deferred

v1 does not track or display subscriber counts.

The owner can manage the share itself, but cannot see:

- how many receivers added it;
- who added it;
- active/inactive subscriber state;
- subscriber devices/installations.

Subscriber count should arrive together with a real subscriber/member model in a future access-management phase, potentially including:

- invite-by-email;
- identified members;
- accepted/pending states;
- remove access;
- subscriber count;
- per-person access controls.

This avoids building anonymous subscription infrastructure solely to support one informational number.


### 2.13 D13 — UX copy principles

User-facing copy should describe what the person can do, not internal system concepts.

Prefer:

- **Share calendar**
- **Manage Sharing**
- **Add to Ink**
- **Anyone with the link**
- **No longer shared**
- **Expired**
- **Can’t update this share**
- **Sign in to manage this link**

Avoid user-facing terms such as:

- owner;
- receiver;
- source calendar;
- active share;
- authority;
- subscription record.

Those terms may remain in product/engineering documentation where useful.


## 3. Information architecture & UI behavior

### 3.1 Calendars list

Each calendar row has two distinct behaviors:

```text
✓   ●  Work                                  ›
```

- left check: show/hide calendar in Ink;
- row body / chevron: open Manage Calendar.

This separates visibility from management.

### 3.2 Manage Calendar — not shared

Example structure:

```text
Work

CALENDAR
Name
Color
Symbol
...

SHARING
Share calendar  ›
Create a link people can open and add in Ink
```

Opening Manage Calendar never requires login.

### 3.3 Manage Calendar — already shared

The Sharing section becomes a state card:

```text
SHARING

● Shared
Anyone with the link can add this calendar in Ink.
Updated 5 min ago
Expires Dec 13                              ›

[ Copy link ]   [ Share… ]
```

Tapping the card opens **Manage Sharing**.

### 3.4 Manage Calendar — sharing unavailable

If the calendar is read-only, subscribed, system-generated, or received from another Ink user, the Sharing section does not expose a share action.

Example:

```text
SHARING

Sharing unavailable
You can view this calendar, but you can’t share it from Ink.
```

For calendars received through Ink, prefer a **Source** section instead of a Sharing section:

```text
SOURCE

Shared through Ink
Last updated 12 min ago

[ Remove from Ink ]
```

### 3.5 Manage Sharing

Core content:

- sharing status;
- share link;
- copy/share actions;
- visibility settings;
- access policy (`anyone_with_link` in v1);
- expiry;
- last updated;
- Refresh now;
- Stop sharing.

Account-level actions such as Sign out and Delete account do **not** belong on this screen.

---

## 4. User flows

### 4.1 Flow A — Create a share

```text
Calendars
   ↓
Manage Calendar
   ↓
Share calendar
   ↓
Is user signed in?
   ├── Yes ───────────────┐
   │                      │
   └── No                 │
        ↓                 │
   Sign in     │
        ↓ success         │
        └─────────────────┘
               ↓
          Share setup
               ↓
        Create share link
               ↓
          Success state
       Copy link / Share…
```

Important UX rule:

> Login happens because the user chose **Share calendar**, not because they opened Manage Calendar.

If the user cancels login, return to Manage Calendar without creating a share.

### 4.2 Share setup

The happy path should be short.

Recommended order:

1. preview what recipients will see;
2. visibility/privacy choices;
3. expiry shown with a default;
4. Create share link.

Avoid requiring unnecessary metadata before value is created.

Recommended default presentation:

```text
PEOPLE WITH THE LINK CAN SEE

Event names        ON
Locations          ON
Notes              OFF

Link expires in 90 days     Change ›

New events will be included automatically
while sharing is on.
```

Expiry is a default with an optional change action, not a mandatory decision that blocks the happy path.

### 4.3 Flow B — Share created

Success state focuses on distribution:

```text
✓ Calendar shared

Anyone with this link can add the calendar in Ink.

inkcalendar.app/s/...

[ Copy link ]
[ Share… ]

Done
```

The link remains retrievable later from Manage Calendar / Manage Sharing.

### 4.4 Flow C — Manage an existing share

```text
Calendars
   ↓
Manage Calendar
   ↓
Shared status card
   ↓
Manage Sharing
```

Available actions:

- Copy link;
- Share…;
- edit visibility;
- edit expiry;
- Refresh now;
- Stop sharing.

If ownership requires sign-in and the user is currently signed out:

```text
SHARING

This calendar is shared.
Sign in to manage the link.

[ Sign in to manage sharing ]
```

After successful sign-in, return to the same screen and load the share state.

### 4.5 Flow D — Stop sharing

Confirmation copy should describe the impact:

```text
Stop sharing “Work”?

People using this link will stop receiving updates.
The link will no longer be available for adding this calendar.

Cancel
Stop sharing
```

After stopping:

- sender’s Sharing section returns to **Share calendar**;
- receiver is not silently removed from Ink;
- receiver sees that the calendar is no longer shared and may remove it themselves.

### 4.6 Flow E — Receiver opens a share link

The public link may show a lightweight preview, but following the calendar requires Ink.

```text
Shared calendar

Work

[ preview ]

[ Open in Ink ]

Don’t have Ink?
Get Ink to add this calendar.
```

No “Subscribe in Calendar” action exists in this version.

### 4.7 Flow F — Receiver adds the calendar in Ink

Inside Ink:

```text
Shared calendar

Work

[ preview ]

This calendar is read-only. New changes will appear here when available.

Name in Ink
[ Work ]

[ Add to Ink ]
```

Use **Add shared calendar / Add to Ink**, not “Import”.

After adding, the calendar appears as a shared source.

### 4.8 Flow G — Receiver manages a shared calendar

Receiver can manage local presentation:

- Name in Ink;
- color;
- symbol;
- remove from Ink.

Receiver cannot edit source events.

Example:

```text
Work
Shared calendar · Read only

Name in Ink       Work  ›
Color               ●   ›
Symbol               💼  ›

SOURCE
Last updated 12 min ago

[ Remove from Ink ]
```

### 4.9 Flow H — Sender stops sharing

When Ink confirms that the share is no longer active, receiver sees a persistent state:

```text
⚠ No longer shared

This calendar is no longer being shared.

[ Remove calendar ]
```

Do not silently make the calendar disappear.

This gives the receiver a clear explanation and avoids the feeling that Ink lost data.

### 4.10 Flow I — Account management

Account lifecycle lives only in Settings:

```text
Settings
└── Account
    ├── Sign in / Signed in
    ├── Sign out
    └── Delete account
```

Deleting an Ink account stops/removes all active shares owned by that account.

The confirmation must explicitly explain that consequence.


### 4.11 Flow J — Logout and later manage an existing share

Signing out does not mean Ink should forget that a calendar on this device was previously associated with a share.

While signed out, local state may still allow Ink to show:

```text
SHARING

Shared
Sign in to manage this share.
```

However, local state is only a UX hint. Ownership and active share state come from the account/server after login.

After the user signs back in:

1. Ink loads the account’s active shares.
2. Ink reconciles them with source calendars currently available on the device.
3. Matching shares return to normal Manage Sharing.
4. Shares whose source cannot be found become **Source calendar unavailable** rather than being deleted automatically.

### 4.12 Flow K — Owner opens their own share link while logged out

```text
Owner signed out
    ↓
Opens own Ink share link
    ↓
Preview appears like a receiver flow
    ↓
User signs in
    ↓
Ink detects current account owns this share
    ↓
Manage Sharing
```

The owner should not be allowed to create a second receiver-style copy of their own calendar after ownership is known.

If they already added the shared copy while logged out, reconciliation removes/merges that duplicate and returns them to the source calendar’s Manage Sharing state.

---

## 5. Product logic

### 5.1 Share states — sender

```text
not_shared
shared
```

`shared` should expose:

- link;
- visibility settings;
- access policy (`anyone_with_link` in v1);
- expiry;
- last updated;
- refresh action;
- stop-sharing action.

### 5.2 Share states — receiver

Receiver-facing product states should distinguish at least:

**Active**

> Shared calendar is available and up to date as of the last successful refresh.

**Temporarily unable to refresh**

> Keep showing the latest cached version with a clear stale/offline indication.

Example:

> Couldn’t refresh · Showing the version from Sep 12.

**No longer shared**

> The owner stopped sharing. Keep the calendar entry and the last successfully received events, clearly mark **No longer shared**, and stop future updates until the receiver removes it.

**Expired**

> The share has reached its expiry date. Keep the last successfully received events, clearly mark **Expired**, and stop future updates. If the owner renews the share, updates may resume on the same link.

Do not collapse ordinary connectivity failure into “No longer shared”.

### 5.3 Receiver local customization

Sender-owned and receiver-owned attributes are separate.

**Sender owns:**

- source calendar content;
- event names/details;
- sharing visibility rules;
- expiry;
- whether sharing is active.

**Receiver owns locally:**

- display name in Ink;
- color;
- symbol.

If the receiver renamed “Work” to “Alex’s Schedule”, future sender updates must not overwrite that local display name.

### 5.4 Access model — v1 public link, future-ready

v1 sharing is link-based:

> **Anyone with the link can add the shared calendar in Ink.**

The owner does not see who opened or added the calendar.

The owner can manage:

- whether the share is active;
- what information is visible;
- expiry;
- the share link;

The owner cannot manage individual viewers in v1 because there is no identified member model yet.

This distinction should be visible in product language. Avoid copy that implies Ink knows exactly who currently has access.

Recommended wording:

> Anyone with this link can preview this calendar and add it in Ink.

For the metric, use:

> 
Avoid:

> Shared with 12 people

because the count represents active subscriptions/installations, not verified unique humans.

#### Future invite/access extension

A future invite/access-management model may add identified membership:

```text
Members
├── user/email
├── invited
├── accepted
└── removed
```

Possible future UI:

```text
ACCESS

○ Anyone with the link
○ Only invited people

PEOPLE
Alex      Accepted
Jamie     Invited

[ Invite people ]
```

This future model may require the receiver to sign in before access can be granted.

No v1 flow should depend on this member layer.


### 5.5 Source calendar availability

A share can outlive the local availability of its source calendar.

Examples:

- the user logs out of a provider;
- an account is temporarily disconnected;
- the source calendar is temporarily not returned by the provider;
- the user changed device.

Ink should not immediately revoke the share in these cases.

Use a distinct sender-side state:

> **Source calendar unavailable**

Recommended behavior:

- existing share link remains manageable through the owner account;
- automatic publishing pauses because the source cannot currently be read;
- Ink does not silently bind the share to another calendar with the same name;
- when the source is confidently matched again, normal publishing resumes.

If the source calendar appears permanently deleted and cannot be restored, keep the share in **Source calendar unavailable**, prompt the owner to **Stop sharing**, do not auto-revoke immediately, and never rebind by same-name matching.

### 5.6 Duplicate prevention and reconciliation

The following must not create a second active share automatically:

- rename of the source calendar;
- reconnect of the same provider/account;
- login on a new device;
- opening the owner’s own share link;
- temporary disappearance and return of the source calendar.

If the same logical source calendar is exposed through more than one integration path, Ink should rely on its existing calendar deduplication layer before applying sharing logic.

Sharing must never deduplicate calendars by display name alone.

### 5.7 Logout semantics

Logging out removes the user’s ability to manage owner-only sharing actions until they sign back in.

It does **not** mean:

- stop all shares;
- delete local calendars;
- create new receiver copies of the owner’s own shares.

Local cache may preserve enough state to display that a calendar is/was shared, but the account/server is authoritative after login.

### 5.8 Privacy visibility

“Show details” is too vague for the UI.

The product must define exactly what people with the link can see.

At minimum the design should expose meaningful user-facing choices such as:

- event names;
- times;
- locations;
- notes.

If v1 uses a simpler binary mode, the copy must still explain the result.

Example:

**Show event details — On**

> People can see event names, times, locations and notes.

**Show event details — Off**

> People can see when you’re busy, but not private event details.

### 5.9 Future events

The creation flow must clearly disclose:

> New events added to this calendar will also be shared while sharing is on.

This is central to the difference between a snapshot and a live share.

### 5.10 Expiry

v1 default expiry is **90 days**.

User may change it to:

- 30 days;
- 90 days;
- 365 days.

If a share expires:

- receiver keeps the last successfully received events;
- receiver sees **Expired**;
- no further updates are received;
- owner may **Renew** the same share and keep the same link.

Renewing an expired share does not create a new share object or link.

By contrast, **Stop sharing** permanently revokes the current link. If the owner shares the calendar again later, Ink creates a new share and a new link.


### 5.11 Re-sharing the same calendar

Because v1 allows one active link per calendar:

If user taps **Share calendar** on an already-shared calendar, Ink should route them to **Manage Sharing**, not create another link.

If the owner chooses **Stop sharing**, the current link is permanently revoked and the calendar returns to **Not shared**. Sharing again later creates a new share and new link.

---

## 6. Acceptance criteria

### 6.1 Sender UX

- **AC-S1** A user can open Manage Calendar without signing in.
- **AC-S2** Tapping Share calendar while signed out presents login, and successful login returns to the share flow.
- **AC-S3** Cancelling login creates no share and returns the user to the previous calendar context.
- **AC-S4** A calendar with no active share shows **Share calendar**.
- **AC-S5** A calendar with an active share shows a clear **Shared** status plus Copy link / Share actions.
- **AC-S6** The share link can always be retrieved again from Manage Sharing.
- **AC-S7** One calendar cannot accidentally create multiple active links in v1.
- **AC-S8** Shared calendar updates are published automatically when Ink gets an opportunity; Refresh now is optional fallback behavior.
- **AC-S9** Stop sharing requires a confirmation describing receiver impact.
- **AC-S10** After Stop sharing succeeds, sender UI returns to the not-shared state.
- **AC-S11** Expiry has a default and does not require a decision during the shortest happy path.
- **AC-S12** Creation UI explicitly says that new future events will be included while sharing is active.
- **AC-S13** Renaming a source calendar does not create a new share or break the existing one.
- **AC-S14** If a source calendar temporarily becomes unavailable, the share is not automatically revoked; sender sees **Source calendar unavailable**.
- **AC-S15** Ink never rebinds an existing share to another calendar solely because the calendar has the same name.
- **AC-S16** After logout and login again, active shares are restored from the account and reconciled with calendars available on the device.
- **AC-S17** A read-only/subscribed/received Ink calendar cannot be re-shared in v1.

### 6.2 Receiver UX

- **AC-R1** Opening a valid share link clearly presents it as an Ink shared calendar.
- **AC-R2** The primary action is **Open in Ink / Add to Ink**; there is no Calendar/webcal subscription CTA.
- **AC-R3** Adding the shared calendar does not grant edit access to source events.
- **AC-R4** Receiver can rename/recolor/change symbol locally.
- **AC-R5** Receiver local customization survives subsequent source updates.
- **AC-R6** Temporary refresh failure does not masquerade as revocation; cached content may remain visible with a stale state.
- **AC-R7** When the sender stops sharing, the receiver sees **No longer shared** rather than the calendar silently disappearing.
- **AC-R8** Receiver can explicitly remove a no-longer-shared calendar.
- **AC-R9** Product copy uses Add/follow/shared calendar language rather than import language.
- **AC-R10** If the signed-in user owns the opened share, Ink routes to Manage Sharing rather than adding a receiver copy.
- **AC-R11** If the owner added their own share while signed out, signing in reconciles/removes the duplicate receiver copy.

### 6.3 Account UX

- **AC-A1** Account management lives in Settings → Account.
- **AC-A2** Share screens do not contain app-level Sign out or Delete account actions.
- **AC-A3** User can use local calendar features without signing in.
- **AC-A4** Deleting the account clearly warns that all active shares owned by the account will stop.


### 6.4 Access policy

- **AC-P1** v1 UI clearly communicates that access is **Anyone with the link**.
- **AC-P2** v1 owner UI does not imply subscriber identity or subscriber count is known.
- **AC-P3** Share state stores an explicit access policy rather than assuming every share is permanently public-link based.
- **AC-P4** v1 does not create anonymous subscription/member infrastructure solely for analytics or count display.


## 7. Backend / data requirements at product-contract level

This section intentionally stays at product-contract level rather than implementation detail.

### 7.1 Share record

The share record is not a second editable calendar. It stores publishing/sharing state plus the latest receiver-facing snapshot.

An active share must support the product state required by the UI:

- stable share ID/link;
- owner account;
- optional public owner display name for public share surfaces;
- source calendar reference on sender side;
- source availability / reconciliation state;
- latest JSON payload;
- visibility settings;
- access policy (`anyone_with_link` in v1);
- created time;
- updated time;
- expiry;
- active/revoked status.


### 7.2 Required product operations

The product needs operations equivalent to:

- create share;
- fetch share;
- fetch/manage owner’s share state;
- update share content/settings;
- stop sharing;
- refresh receiver state.

The core share model should keep access policy distinct from the share link itself so future invite-only access can be layered on without redefining the share resource.

Exact transport/API design is implementation-owned.

### 7.3 JSON payload

JSON remains the wire format between Ink and the backend.

The payload must carry enough stable identity for receiver-side updates and local customization to survive refreshes.

Illustrative shape:

```jsonc
{
  "kind": "ink.calendar.share",
  "calendar": {
    "name": "…",
    "color": "#AARRGGBB",
    "symbol": "…"
  },
  "window": {
    "start": "2026-09-10",
    "end": "2027-03-10"
  },
  "time_zone": "Asia/Ho_Chi_Minh",
  "events": [{
    "uid": "stable-event-id",
    "event_name": "…",
    "start_time": "…",
    "end_time": "…",
    "all_day": false,
    "color": "#AARRGGBB",
    "symbol": "…",
    "location": "…",
    "notes": "…",
    "url": "…"
  }]
}
```

Ownership/account authority is server-side metadata and is not part of calendar content.

---

## 8. Not in this version

- ICS/webcal generation.
- Subscribe in Apple Calendar / Google Calendar / Outlook.
- ICS parser in Swift.
- Receiver editing sender events.
- Two-way sync.
- Multiple active share links for one calendar.
- Multiple calendars in one share link.
- App-wide mandatory login.
- Login requirement merely to open Manage Calendar.
- Separate “sharing account”.
- Re-sharing a calendar received from another Ink user.
- Automatic reassociation of a share based only on calendar name.
- Background-sync guarantees that promise instant real-time delivery.
- Invite-by-email / invite-only sharing.
- Subscriber identity or member management.
- Subscriber count or anonymous subscription tracking.
- Per-person permissions or access revocation.

---

## 9. Open questions to close before final design

| # | Question | Recommendation |
|---|---|---|
| 1 | Exact default expiry? | 90 days; allow 30 / 90 / 365 from Change |
| 2 | Visibility model: per-field toggles or one simplified privacy toggle? | Prefer explicit user-facing fields if design remains lightweight |
| 3 | Should the public link show full event preview before Ink is installed? | Show enough preview to establish trust/value, but following requires Ink |
| 4 | How long should a revoked/expired calendar remain visible on receiver before cleanup? | Keep until user removes it; clearly mark state |
| 5 | Should there be a global Sharing overview in v1? | Optional secondary shortcut; do not block v1 |
| 6 | Which sender app opportunities trigger automatic publishing? | Product requirement is automatic when reasonably possible; exact trigger is implementation-owned |
| 7 | What copy distinguishes Expired vs No longer shared vs Couldn’t refresh? | Design three distinct states |
| 8 | What should happen when a source calendar is permanently deleted? | Keep share manageable but paused; prompt owner to stop sharing rather than silently rebinding |
| 9 | When owner self-added their share while logged out, should receiver-local color/name be preserved after reconciliation? | Preserve only when matching is unambiguous; otherwise prioritize source calendar and avoid duplicate state |
| 10 | When invite-only sharing is added later, should link access and invited access coexist? | Treat as a separate v2 product decision; v1 stores explicit `anyone_with_link` policy so either path remains open |
| 11 | When subscriber/member management is added, should count be shown on Manage Sharing only or also on the calendar card? | Start in Manage Sharing; decide later based on value |

---

## 10. Core product story

The v1 mental model should remain explainable in four sentences:

> **A source calendar remains owned and edited at its original source.**  
> **Ink stores the sharing state and publishes one live, read-only version of that calendar.**  
> **A receiver adds that shared calendar to Ink and may customize how it looks locally.**  
> **The owner can always return to the original calendar to copy the link, change sharing settings, or stop sharing.**  
> **The owner never follows their own share, and Ink never matches calendars by name alone.**  
> **In v1, access is anyone-with-link; future invite access can extend the same share object rather than replace it.**  
> **v1 does not track subscriber counts; subscriber/member visibility belongs to a later access-management phase.**

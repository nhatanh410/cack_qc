# Spec: Ink Share Link — In-App UI/UX Flow

**Document Version:** 1.4  
**Status:** Draft  
**Product:** Ink  
**Scope:** In-app UI/UX for creating, managing, and receiving Shared Calendar links  
**Related docs:** Shared Calendars v1.8, Shared Calendar Web View v1.2, Ink Account Login & Management v1.3

---

## 1. Goal

This document defines how Shared Calendar links behave **inside the Ink app**.

The experience should feel calendar-first:

> **Users manage sharing from the calendar they already know.**

Sharing is not a separate account area and not a separate “share object” users need to learn.

Core model:

```text
Calendars
   ↓
Manage Calendar
   ↓
Sharing
```

For a sender:

```text
Not shared
   ↓
Share calendar
   ↓
Shared
   ↓
Manage Sharing
```

For a receiver:

```text
Open shared link
   ↓
Preview in Ink
   ↓
Add to Ink
   ↓
Shared calendar · Read-only
```

---

## 2. Product principles

### 2.1 Calendar-first information architecture

The calendar is the primary object.

Users should think:

> “I want to share Work.”

not:

> “I need to find my share record.”

The canonical path is therefore:

```text
Calendars → Work → Sharing
```

### 2.2 Sharing should not interfere with normal calendar management

Opening a calendar’s Manage screen should never require login.

Login is requested only when the user chooses an account-dependent sharing action.

### 2.3 One calendar = one active share link in v1

A calendar may have:

```text
No active share
```

or:

```text
One active share
```

If a calendar is already shared, trying to share it again routes to **Manage Sharing** instead of creating another link.

### 2.4 Share settings and calendar content are different

The source calendar remains where event content is edited.

Manage Sharing controls:

- access;
- visibility;
- expiry;
- link;
- sharing status.

It does not become another place to edit events.

### 2.5 Receiver calendars are read-only

A receiver can customize:

- display name in Ink;
- color;
- symbol.

They cannot modify source event content.

---

# 3. Calendars list

## 3.1 Recommended row model

Move visibility control to the left and management/navigation to the right.

```text
┌──────────────────────────────────────┐
│              Calendars          ＋   │
│                                      │
│ ICLOUD                               │
│ ┌──────────────────────────────────┐ │
│ │ ✓   ●  Lịch                   › │ │
│ ├──────────────────────────────────┤ │
│ │ ✓   ●  IDE Courses Calendar    › │ │
│ ├──────────────────────────────────┤ │
│ │ ✓   ●  Work                   › │ │
│ ├──────────────────────────────────┤ │
│ │ ✓   ●  Home                   › │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

Interactions:

```text
tap ✓
→ show / hide calendar

tap row
→ Manage Calendar

tap ›
→ Manage Calendar
```

Avoid making the same row tap both toggle visibility and navigate.

---

# 4. Manage Calendar — shareable calendar, not yet shared

```text
┌──────────────────────────────────────┐
│ ‹            Work                   │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ ●  Work                         │ │
│ │    iCloud                       │ │
│ └──────────────────────────────────┘ │
│                                      │
│ CALENDAR                             │
│ ┌──────────────────────────────────┐ │
│ │ Name                      Work › │ │
│ ├──────────────────────────────────┤ │
│ │ Color                       ●  › │ │
│ ├──────────────────────────────────┤ │
│ │ Symbol                     💼  › │ │
│ └──────────────────────────────────┘ │
│                                      │
│ SHARING                              │
│ ┌──────────────────────────────────┐ │
│ │ Share calendar                › │ │
│ │ Create a link people can add     │ │
│ │ in Ink                           │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

No login is required just to open this screen.

---

# 5. Manage Calendar — calendar cannot be shared

Sharing eligibility is based on ownership/control, not provider.

Examples that cannot be shared in v1:

- read-only calendar managed by someone else;
- subscribed/public calendar;
- system-generated calendar;
- calendar received through Ink sharing.

Example:

```text
┌──────────────────────────────────────┐
│ ‹        Team Schedule              │
│                                      │
│ Team Schedule                        │
│ Google · Read only                   │
│                                      │
│ CALENDAR                             │
│ Name in Ink                    ›     │
│ Color                         ● ›    │
│                                      │
│ SHARING                              │
│ ┌──────────────────────────────────┐ │
│ │ Sharing unavailable             │ │
│ │ This calendar is managed by     │ │
│ │ another owner.                  │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

For an Ink-received shared calendar, prefer **Source** rather than a disabled Sharing section.

---

# 6. Tap “Share calendar” while signed out

Present a contextual login sheet.

```text
╭────────────────────────────────────╮
│                                    │
│          Sign in to share          │
│                                    │
│ Sign in to create a share link     │
│ and manage it later from your      │
│ Ink account.                       │
│                                    │
│ ┌────────────────────────────────┐ │
│ │    Continue with Apple       │ │
│ ├────────────────────────────────┤ │
│ │ G   Continue with Google      │ │
│ └────────────────────────────────┘ │
│                                    │
│ Not now                            │
│                                    │
╰────────────────────────────────────╯
```

On success:

```text
Sign in
  ↓
Return to share flow
```

Apple and Google are alternative authentication methods for the same Ink account concept. Google login must not be confused with connecting a Google Calendar source.

On cancel:

```text
Return to Manage Calendar
```

No share is created.

---

# 7. Share Setup

The setup should be short and value-first.

Recommended structure:

```text
┌──────────────────────────────────────┐
│ ‹          Share Work               │
│                                      │
│ PREVIEW                              │
│ ┌──────────────────────────────────┐ │
│ │ Work                             │ │
│ │                                  │ │
│ │ MON 14                           │ │
│ │ 09:00  Team standup             │ │
│ │ 14:30  Design review            │ │
│ │                                  │ │
│ │ TUE 15                           │ │
│ │ 10:00  Planning                 │ │
│ └──────────────────────────────────┘ │
│                                      │
│ WHAT PEOPLE WITH THE LINK CAN SEE         │
│ ┌──────────────────────────────────┐ │
│ │ Event names                  ON │ │
│ ├──────────────────────────────────┤ │
│ │ Locations                    ON │ │
│ ├──────────────────────────────────┤ │
│ │ Notes                        OFF│ │
│ └──────────────────────────────────┘ │
│                                      │
│ LINK EXPIRY                          │
│ ┌──────────────────────────────────┐ │
│ │ 90 days                       › │ │
│ └──────────────────────────────────┘ │
│                                      │
│ New events will be included          │
│ automatically while sharing is on.   │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │       Create share link         │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

Key UX rules:

- preview before creation;
- clearly explain what recipients can see;
- expiry has a default;
- future events disclosure is visible before creation.

---

# 8. Privacy visibility

Avoid a vague setting such as only:

> Show details

Prefer explicit controls where possible:

```text
WHAT PEOPLE WITH THE LINK CAN SEE

Event names           ON
Locations             ON
Notes                 OFF
```

If the product uses a simplified binary mode:

```text
Show event details    OFF
```

the explanation must be clear:

> People can see when you’re busy, but not event names, locations, or notes.

The preview should update to reflect the selected privacy mode.

---

# 9. Create share — loading state

```text
┌──────────────────────────────────────┐
│            Share Work               │
│                                      │
│                                      │
│              ◌                       │
│                                      │
│        Creating share link…          │
│                                      │
│                                      │
└──────────────────────────────────────┘
```

Avoid allowing repeated taps that could appear to create multiple links.

Because v1 supports one active link per calendar, creation should resolve into that single shared state.

---

# 10. Share created

Focus on the next user goal: distribute the link.

```text
┌──────────────────────────────────────┐
│                                      │
│                ✓                     │
│                                      │
│          Your calendar is shared             │
│                                      │
│ Anyone with this link can add        │
│ this calendar in Ink.                │
│                                      │
│ inkcalendar.app/s/8DF...             │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │            Copy link            │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │             Share…              │ │
│ └──────────────────────────────────┘ │
│                                      │
│               Done                   │
└──────────────────────────────────────┘
```

Do not overload this screen with all management settings.

Those remain available later from Manage Sharing.

---

# 11. Manage Calendar — shared state

After sharing, the Sharing section changes.

```text
┌──────────────────────────────────────┐
│ ‹            Work                   │
│                                      │
│ CALENDAR                             │
│ ┌──────────────────────────────────┐ │
│ │ Name                      Work › │ │
│ │ Color                       ●  › │ │
│ └──────────────────────────────────┘ │
│                                      │
│ SHARING                              │
│ ┌──────────────────────────────────┐ │
│ │ ● Shared                        │ │
│ │                                  │ │
│ │ Anyone with the link can add     │ │
│ │ this calendar in Ink.            │ │
│ │                                  │ │
│ │ Updated 5 min ago                │ │
│ │ Expires Dec 13               ›  │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌───────────────┐ ┌────────────────┐ │
│ │   Copy link   │ │     Share…     │ │
│ └───────────────┘ └────────────────┘ │
└──────────────────────────────────────┘
```

The subscriber number is an anonymous active-subscription count.

Use:

> 12 subscribers

Avoid:

> 12 people

---

# 12. Manage Sharing

```text
┌──────────────────────────────────────┐
│ ‹        Sharing: Work              │
│                                      │
│ STATUS                               │
│ ┌──────────────────────────────────┐ │
│ │ ● Shared                 │ │
│ │ Updated 5 min ago                │ │
│ └──────────────────────────────────┘ │
│                                      │
│ LINK                                 │
│ ┌──────────────────────────────────┐ │
│ │ inkcalendar.app/s/8DF...        │ │
│ │                                  │ │
│ │ Copy link              Share…   │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ACCESS                               │
│ ┌──────────────────────────────────┐ │
│ │ Anyone with the link             │ │
│ └──────────────────────────────────┘ │
│                                      │
│ VISIBILITY                           │
│ ┌──────────────────────────────────┐ │
│ │ Event names                  ON │ │
│ │ Locations                    ON │ │
│ │ Notes                        OFF│ │
│ └──────────────────────────────────┘ │
│                                      │
│ SETTINGS                             │
│ ┌──────────────────────────────────┐ │
│ │ Expires                 Dec 13 ›│ │
│ ├──────────────────────────────────┤ │
│ │ Check for updates                     │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │          Stop sharing           │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

`Check for updates` is a secondary fallback.

The normal product promise is that Ink republishes when it gets an opportunity.

---

# 13. Copy link

Copy should be immediate.

Recommended feedback:

```text
Copied
```

or lightweight toast:

```text
Share link copied
```

Do not open an extra screen just to copy.

---

# 14. Share…

Use the system share sheet.

Product distinction:

```text
Copy link
→ fast repeated action

Share…
→ send through Messages, Mail, apps, etc.
```

Both distribute the same active link.

---

# 15. Edit sharing

Editing visibility or expiry should update the same active share.

It must not create a new link.

State model:

```text
Share
   ↓
Edit visibility / expiry
   ↓
Same share link
```

Unless the product explicitly introduces a future “Rotate link” action.

---

# 16. Expiry

v1 default:

> **90 days**

Options:

```text
Expires

○ 30 days
● 90 days
○ 365 days
```

If the share expires, receiver keeps the last successfully received events, sees **Expired**, and stops receiving new updates. Owner can **Renew** and keep the same link.

If the owner chooses **Stop sharing**, the old link is permanently revoked, the calendar returns to **Not shared**, and sharing again later creates a new link.


# 17. Subscriber/member management — deferred

v1 does not display subscriber count and does not build anonymous subscriber tracking.

Manage Sharing contains only share-level controls.

Subscriber count should be added later together with the full subscriber/access-management model, potentially including:

- invite people;
- accepted/pending states;
- identified members;
- remove access;
- per-person permissions;
- subscriber count.

This keeps v1 focused on creating, distributing, editing, and revoking a share link.


# 18. Stop Sharing

Use a destructive confirmation.

```text
╭────────────────────────────────────╮
│ Stop sharing “Work”?               │
│                                    │
│ People following this calendar     │
│ will stop receiving updates.       │
│                                    │
│ This share link will no longer     │
│ be available for adding the        │
│ calendar.                          │
│                                    │
│ Cancel                             │
│ Stop sharing                       │
╰────────────────────────────────────╯
```

Avoid:

> Are you sure?

The consequence should be explicit.

---

# 19. After Stop Sharing

Sender returns to the not-shared state:

```text
SHARING

Share calendar  ›
Create a link people can open and add in Ink
```

Receiver does not disappear silently.

The old link is permanently revoked. If the owner shares again later, Ink creates a new link.

Receiver keeps the last received events and eventually sees:

> No longer shared

---

# 20. Signed-out owner with an existing share

Local state may remember that this calendar has sharing metadata, but it cannot grant owner actions.

```text
SHARING

Shared

Sign in to manage this share.

[ Sign in ]
```

After sign-in:

```text
Sign in
   ↓
Load account share
   ↓
Reconcile source calendar
   ↓
Manage Sharing
```

---

# 21. Can’t update this share

This state is different from Stop Sharing.

Possible causes:

- source account disconnected;
- source temporarily unavailable;
- user changed device;
- provider no longer returns the calendar.

UI:

```text
┌──────────────────────────────────────┐
│ ‹            Work                   │
│                                      │
│ SHARING                              │
│ ┌──────────────────────────────────┐ │
│ │ ⚠ Can’t update this share  │ │
│ │                                  │ │
│ │ This share is still active, but  │ │
│ │ Ink can’t currently refresh it   │ │
│ │ from the original calendar.      │ │
│ └──────────────────────────────────┘ │
│                                      │
│ [ Copy link ]                         │
│                                      │
│ [ Stop sharing ]                      │
└──────────────────────────────────────┘
```

Do not silently bind this share to another calendar with the same name.

---

# 22. Source calendar renamed

A rename is not a new calendar.

Expected behavior:

```text
Work
→ renamed to
Studio
```

Existing share remains the same share.

The sharing UI should update to the new source-calendar title where appropriate without generating a new link.

---

# 23. Source calendar deleted

If the source can no longer be found confidently:

```text
Can’t update this share
```

Do not immediately repoint the share.

Recommended user path:

```text
Source unavailable
   ↓
Owner opens Manage Sharing
   ↓
Explain source cannot refresh
   ↓
Prompt Stop sharing
```

Automatic reassociation based only on display name is not allowed.

---

# 24. Owner opens their own share link

Flow:

```text
Owner signed out
   ↓
Opens their share link
   ↓
Receiver-style preview
   ↓
Open in Ink
   ↓
Sign in
   ↓
Ink detects owner
   ↓
Manage Sharing
```

Do not show:

> Add to Ink

after ownership is known.

---

# 25. Owner already added their own share while signed out

Possible temporary duplicate:

```text
Work
Work · Shared
```

After sign-in:

```text
Detect same owner/share
   ↓
Keep source Work
   ↓
Remove/merge shared receiver copy
   ↓
Manage Sharing
```

The owner should not remain subscribed to their own published copy.

---

# 26. Receiver preview in Ink

After the Web View opens Ink:

```text
┌──────────────────────────────────────┐
│           Shared calendar           │
│                                      │
│ Work                                 │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ MON 14                           │ │
│ │ 09:00  Team standup             │ │
│ │ 14:30  Design review            │ │
│ │                                  │ │
│ │ TUE 15                           │ │
│ │ 10:00  Planning                 │ │
│ └──────────────────────────────────┘ │
│                                      │
│ This calendar is read-only and       │
│ stays updated by its owner.          │
│                                      │
│ NAME IN INK                          │
│ ┌──────────────────────────────────┐ │
│ │ Work                            │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │          Add to Ink             │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

Do not use “Import”.

---

# 27. Add to Ink — success

```text
┌──────────────────────────────────────┐
│                                      │
│                ✓                     │
│                                      │
│        Added to Ink       │
│                                      │
│ Work will update when new changes are available. │
│                                      │
│               Done                   │
└──────────────────────────────────────┘
```

v1 does not create subscriber/member tracking when Add to Ink succeeds.

---

# 28. Receiver calendar in Calendars list

Recommended grouping:

```text
SHARED

✓   ●  Work                                ›
        Shared
```

The source label should make it clear this is not an owned source calendar.

---

# 29. Receiver Manage Calendar

```text
┌──────────────────────────────────────┐
│ ‹             Work                  │
│                                      │
│ ● Work                               │
│ Shared calendar · Read-only          │
│                                      │
│ CALENDAR                             │
│ ┌──────────────────────────────────┐ │
│ │ Name in Ink               Work ›│ │
│ ├──────────────────────────────────┤ │
│ │ Color                       ●  ›│ │
│ ├──────────────────────────────────┤ │
│ │ Symbol                     💼  ›│ │
│ └──────────────────────────────────┘ │
│                                      │
│ SOURCE                               │
│ ┌──────────────────────────────────┐ │
│ │ Shared through Ink               │ │
│ │ Last updated 12 minutes ago          │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │       Remove from Ink           │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

No Share action appears.

A received shared calendar cannot be re-shared in v1.

---

# 30. Receiver local customization

Receiver-owned:

- Name in Ink;
- color;
- symbol.

Sender-owned:

- event content;
- visibility settings;
- whether sharing remains active.

Example:

```text
Sender name:
Work

Receiver local name:
Alex’s Schedule
```

Future sender updates must not overwrite `Alex’s Schedule`.

---

# 31. Receiver — temporarily unable to refresh

Do not confuse network/provider failure with revocation.

```text
Work
Shared calendar

⚠ Couldn’t refresh
Showing the version from Sep 12.
```

Cached content may remain visible.

---

# 32. Receiver — No longer shared

When sender stops sharing:

```text
┌──────────────────────────────────────┐
│ ‹             Work                  │
│                                      │
│                 ⚠                    │
│                                      │
│          No longer shared            │
│                                      │
│ The owner has stopped sharing        │
│ this calendar.                       │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │        Remove calendar          │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

Do not silently remove it.

---

# 33. Receiver — expired

```text
┌──────────────────────────────────────┐
│ ‹             Work                  │
│                                      │
│                 ⚠                    │
│                                      │
│       This share has expired        │
│                                      │
│ This share has expired.   │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │        Remove calendar          │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

Expired and No longer shared are distinct product states.

---

# 34. State map — sender

```text
                 ┌─────────────────┐
                 │   Not shared    │
                 └────────┬────────┘
                          │
                    Share calendar
                          │
                          ▼
                 ┌─────────────────┐
                 │     Shared      │
                 └─────┬─────┬─────┘
                       │     │
               source lost  Stop
                       │     │
                       ▼     ▼
              ┌────────────┐ ┌────────────┐
              │ Source     │ │ Not shared │
              │ unavailable│ └────────────┘
              └──────┬─────┘
                     │
              source returns
                     │
                     ▼
                  Shared
```

---

# 35. State map — receiver

```text
Share link
   ↓
Preview
   ↓
Add to Ink
   ↓
Active
 ┌─┼───────────────┐
 │ │               │
 │ refresh fails   │ owner stops
 │ │               │
 │ ▼               ▼
 │ Stale       No longer shared
 │ │
 │ refresh works
 │ │
 └─┘

Active
  │
  └── expiry reached
         ↓
      Expired
```

Receiver may explicitly Remove from Ink from any locally stored state where removal is applicable.

---

# 36. Copy guidelines

### Friendly copy rules

Use plain language and describe the user-visible outcome.

Prefer:

- “Can’t update this share”
- “This link will stop working”
- “People who added this calendar will stop getting updates”
- “Sign in to manage this link”

Avoid user-facing:

- source calendar unavailable
- revoked
- receiver
- owner
- active share
- subscription

Use consistently:

- Share calendar
- Shared
- Manage Sharing
- Anyone with the link
- subscribers
- Copy link
- Share…
- Check for updates
- Stop sharing
- Can’t update this share
- Shared calendar
- Add to Ink
- Read only
- No longer shared
- Remove from Ink

Avoid:

- Import
- Publish feed
- Sync link
- Shared with X people
- Subscriber list
- Sharing account
- Re-share

---

# 37. Accessibility

- Show/hide check and Manage Calendar navigation must have distinct accessibility labels.
- “Shared” must not rely only on a green dot.
- Subscriber count should read naturally, e.g. “12 subscribers”.
- Destructive Stop sharing requires explicit text.
- Dynamic Type should not hide visibility/privacy explanations.
- Read-only state must be conveyed in text.
- Status icons must have text equivalents.
- Full-width CTAs should remain reachable without precise tapping.

---

# 38. Analytics/product events

Useful events:

- calendar_manage_opened;
- share_calendar_tapped;
- share_setup_opened;
- share_created;
- share_link_copied;
- share_sheet_opened;
- share_settings_changed;
- share_refresh_requested;
- share_stopped;
- share_source_unavailable_seen;
- shared_calendar_preview_opened;
- shared_calendar_added;
- shared_calendar_removed;
- shared_calendar_no_longer_shared_seen.

Analytics events must not be used as a substitute for future subscriber/member state.

---

# 39. Acceptance criteria

## 39.1 Calendar management

- **AC-I1** Calendars list separates visibility toggle from Manage Calendar navigation.
- **AC-I2** Manage Calendar opens without requiring login.
- **AC-I3** Shareable calendars expose Share calendar when no active share exists.
- **AC-I4** Non-shareable calendars do not expose an active Share action.

## 39.2 Share creation

- **AC-I5** Signed-out user is asked to sign in only after choosing Share calendar.
- **AC-I5a** Login gate offers both Continue with Apple and Continue with Google.
- **AC-I6** Successful login returns to the share flow.
- **AC-I7** Share setup previews recipient-visible information.
- **AC-I8** Future-event sharing is disclosed before creation.
- **AC-I9** Expiry has a default and does not block the shortest happy path.
- **AC-I10** One calendar cannot create multiple active v1 share links.

## 39.3 Manage Sharing

- **AC-I11** Existing link can always be copied again.
- **AC-I12** Manage Sharing does not display subscriber count or member UI in v1.
- **AC-I13** Editing share settings retains the same active link.
- **AC-I14** Check for updates is a secondary fallback.
- **AC-I15** Stop sharing requires consequence-focused confirmation.

## 39.4 Source state

- **AC-I16** Rename does not create a new share.
- **AC-I17** Temporary source loss shows Can’t update this share.
- **AC-I18** Source loss does not automatically bind the share to a same-name calendar.
- **AC-I19** Signing back in reconciles owner share state with source calendars.

## 39.5 Owner self-share

- **AC-I20** Owner opening their own share and signing in is routed to Manage Sharing.
- **AC-I21** Owner is not left with a receiver copy of their own share after reconciliation.
- **AC-I22** Owner self-share reconciliation does not create subscriber/member tracking in v1.

## 39.6 Receiver

- **AC-I23** Receiver flow uses Add to Ink, not Import.
- **AC-I24** Received shared calendar is read-only.
- **AC-I25** Receiver can customize local name/color/symbol.
- **AC-I26** Receiver customization survives sender updates.
- **AC-I27** Received Ink calendar cannot be re-shared in v1.
- **AC-I28** Temporary refresh failure remains distinct from No longer shared.
- **AC-I29** Stopped share remains visible as No longer shared until receiver removes it.
- **AC-I30** Expired state is distinct from stopped/revoked state.

---

# 40. Open questions

| # | Question | Recommendation |
|---|---|---|
| 1 | When subscriber/member management is added later, where should subscriber count appear? | Start in Manage Sharing; keep it out of the calendar card initially |
| 2 | Should visibility use per-field controls or one simplified privacy setting? | Prefer explicit fields if screen remains simple |
| 3 | Should owner be able to rotate/regenerate the public link? | Not required in v1; add later only for a clear privacy need |
| 6 | Should Can’t update this share show last published timestamp? | Yes, useful context |

---

# 41. Core UX story

> **The user finds sharing where they expect it: inside the calendar they are managing.**  
> **Creating a share is short, privacy-aware, and asks for login only when necessary.**  
> **Once shared, the same calendar becomes the place to copy the link, adjust settings, refresh, or stop sharing.**  
> **Receivers add a read-only shared calendar to Ink and control only its local presentation.**  
> **Source problems, logout, revocation, and self-share are explicit states rather than silent duplication or data loss.**

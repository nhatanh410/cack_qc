# Spec: Ink Account — Login & Account Management

**Document Version:** 1.4  
**Status:** Draft  
**Product:** Ink  
**Scope:** Account entry points, authentication UX, account management, and account-dependent sharing flows  
**Related docs:** Shared Calendars v1.8, Shared Calendar Web View v1.2

---

## 1. Goal

Ink should have one clear account concept for the whole app.

Users do **not** need to sign in to use normal local calendar features.

Sign-in appears only when the user performs an action that requires identity or ownership, such as:

- creating a shared calendar link;
- managing an existing share that belongs to the account;
- future account-dependent features.

Core product rule:

> **Ink works without an account. Sign in only when an action needs an account.**

Account lifecycle belongs in:

```text
Settings
└── Account
```

There is no separate “sharing account”.

---

## 2. Product principles

### 2.1 Account is app-level, not feature-level

The account belongs to Ink.

Sharing may be the first feature that requires login, but the user should not learn a special account concept just for Sharing.

Use:

> Sign in to Ink

Supported options:

- **Continue with Apple**
- **Continue with Google**

or contextual copy such as:

> Sign in to share this calendar and manage this calendar.

Avoid:

> Create sharing account

or:

> Sign in to Sharing

### 2.2 Login is contextual

Do not block the user at app launch.

Do not require login to:

- browse calendar;
- open Manage Calendar;
- rename/color calendars;
- add a received shared calendar when anonymous access is allowed;
- use unrelated Ink features.

Ask for login only at the action that requires ownership.

### 2.3 Return users to the action they started

Authentication should behave like a prerequisite, not a destination.

Example:

```text
Share calendar
    ↓
Sign in required
    ↓
Sign in
    ↓
Return directly to Share setup
```

Do not send the user to Settings after successful login unless they explicitly opened Settings.

### 2.4 Account and share state are separate

Signing out does not:

- stop active shares;
- delete shared links;
- remove local calendars;
- remove received shared calendars.

It only removes the current device’s authenticated ability to perform owner-only account actions until the user signs in again.

---

## 2.5 Authentication provider vs calendar provider

Ink should keep these concepts separate in the user experience.

Example:

```text
Google Calendar connected
≠
Signed in to Ink with Google
```

A user may:

- connect Google Calendar but remain signed out of Ink;
- sign in to Ink with Google without using Google Calendar as a source;
- use Apple Calendar/iCloud sources while signing in to Ink with Google.

Do not reuse calendar-connection status as account-authentication status.

### Account identity continuity

Supporting two sign-in methods introduces one important product question:

> What happens if the same person uses Apple on one device and Google on another?

In v1, Apple and Google sign-ins remain separate Ink accounts unless an explicit account-linking feature is introduced later. Ink must not silently merge them because email addresses appear to match.

The UI should help returning users use the same sign-in method they originally used.

## 3. Account states

The app should reason about three product states:

### 3.1 Signed out

User can use normal Ink features.

Account-dependent actions show a login gate.

```text
ACCOUNT

Signed out

[ Continue with Apple ]
[ Continue with Google ]
```

### 3.2 Signed in

The account is active on the device.

```text
ACCOUNT

Signed in with Apple

[ Sign out ]

Delete account
```

If Ink has no user-facing profile fields, do not invent a fake profile page.

### 3.3 Session no longer valid

If the account session becomes invalid or revoked, Ink should move back to the signed-out state without implying the user’s calendars or shares were deleted.

Recommended product message if user encounters an owner-only action:

> Sign in again to continue managing this share.

---

## 4. Primary entry point — Settings → Account

### 4.1 Settings

```text
┌──────────────────────────────────────┐
│ ‹            Settings              │
│                                      │
│ ACCOUNT                              │
│ ┌──────────────────────────────────┐ │
│ │ Account                       › │ │
│ └──────────────────────────────────┘ │
│                                      │
│ CALENDAR                             │
│ ...                                  │
└──────────────────────────────────────┘
```

### 4.2 Account — signed out

```text
┌──────────────────────────────────────┐
│ ‹             Account              │
│                                      │
│              Ink                     │
│                                      │
│ Sign in to manage account-based      │
│ features across your devices.        │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │      Continue with Apple       │ │
│ ├──────────────────────────────────┤ │
│ │ G     Continue with Google      │ │
│ └──────────────────────────────────┘ │
│                                      │
│ You can keep using Ink without       │
│ signing in.                           │
└──────────────────────────────────────┘
```

The last line is important because account is optional for normal app usage.

### 4.3 Account — signed in

```text
┌──────────────────────────────────────┐
│ ‹             Account              │
│                                      │
│ Signed in                            │
│ Signed in with Apple / Google      │
│                                      │
│ Your account is used for features    │
│ that need ownership, such as         │
│ managing shared calendars.           │
│                                      │
│ ┌──────────────────────────────────┐ │
│ │ Sign out                        │ │
│ └──────────────────────────────────┘ │
│                                      │
│ ACCOUNT DATA                         │
│ ┌──────────────────────────────────┐ │
│ │ Delete account                 › │ │
│ └──────────────────────────────────┘ │
└──────────────────────────────────────┘
```

If Ink does not need/display email or name, do not show them just to make the page feel fuller.

---

### 4.4 Public name

The Ink account may have an editable **public display name**.

Purpose in v1:

> Used on public share surfaces such as “Shared by Alex”.

Rules:

- user can edit it from Settings → Account;
- do not treat it as verified legal identity;
- do not auto-expose private email;
- do not assume Apple/Google account name should always be public;
- if no public display name exists, public share UI may omit “Shared by X”.

## 5. Contextual login gate — Share Calendar

When a signed-out user chooses:

> Share calendar

show a contextual sheet.

```text
╭────────────────────────────────────╮
│                                    │
│          Sign in to share this calendar          │
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
│ Cancel                            │
│                                    │
╰────────────────────────────────────╯
```

On success:

```text
Sign in
   ↓
Return to Share Calendar
   ↓
Continue Share setup
```

On cancel:

```text
Sign in
   ↓ cancel
Return to Manage Calendar
```

No share is created.

---

## 6. Contextual login gate — Manage Sharing

A calendar may still have local metadata indicating that it was previously shared while the current device is signed out.

Example:

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
Load account share state
   ↓
Reconcile with source calendar
   ↓
Manage Sharing
```

The server/account becomes authoritative after login.

Do not let signed-out local cache grant owner permissions.

---

## 7. Login from owner’s own shared link

Important edge case:

```text
Owner signed out
    ↓
Opens own share link
    ↓
Web / receiver preview
    ↓
Open in Ink
    ↓
User signs in
    ↓
Ink detects account owns share
    ↓
Manage Sharing
```

Do not continue into:

> Add to Ink

once ownership is known.

If the owner already added their own shared calendar while signed out, login triggers reconciliation:

- keep the original source calendar;
- remove/merge the receiver-style duplicate;
- route to Manage Sharing.

---

## 8. Sign out

Sign out is an **account action**, not a share action.

It belongs only in:

```text
Settings → Account
```

Do not place Sign out inside:

- Manage Calendar;
- Manage Sharing;
- receiver shared-calendar settings.

### 8.1 Confirmation

A confirmation is optional if sign-out has low destructive impact, but the result must be clear.

Recommended sheet:

```text
╭────────────────────────────────────╮
│ Sign out of Ink?                   │
│                                    │
│ Your calendars and active share    │
│ links will remain. You’ll need to  │
│ sign in again to manage them.      │
│                                    │
│ Cancel                             │
│ Sign out                           │
╰────────────────────────────────────╯
```

### 8.2 What sign out does

- removes authenticated account state from this device;
- disables owner-only management actions until next login.

### 8.3 What sign out does not do

- does not stop active shares;
- does not delete the account;
- does not remove source calendars;
- does not remove received shared calendars;
- does not reset subscriber counts.

---

## 9. Sign back in

After sign-in, Ink should restore account-owned product state.

Expected product flow:

```text
Sign in
   ↓
Load account-owned shares
   ↓
Match available source calendars
   ↓
┌──────────────────────────────┐
│ Source found                 │
│ → normal Manage Sharing      │
│                              │
│ Source unavailable           │
│ → Source calendar unavailable│
└──────────────────────────────┘
```

Do not rebuild ownership state from calendar name.

---

## 10. Delete account

Delete account is intentionally separate from Sign out.

It is destructive and affects all account-owned shares.

### 10.1 Entry

```text
Settings
  ↓
Account
  ↓
Delete account
```

### 10.2 Confirmation

Recommended structure:

```text
┌──────────────────────────────────────┐
│          Delete account?             │
│                                      │
│ This will permanently delete your    │
│ Ink account.                         │
│                                      │
│ Your active shared calendar links    │
│ will stop working.                   │
│                                      │
│ Calendars stored in Apple Calendar,  │
│ Google, Outlook, or other source     │
│ providers are not deleted.           │
│                                      │
│ [ Cancel ]                           │
│                                      │
│ [ Delete account ]                   │
└──────────────────────────────────────┘
```

The exact list of other Ink-owned cloud data must be updated if the broader account model later stores more than sharing state.

### 10.3 After successful deletion

Expected result:

```text
Delete account
    ↓
All account-owned shares stop
    ↓
Account session ends
    ↓
Return to signed-out Ink
```

The app itself remains usable.

---

## 11. Account deletion vs source calendars

Deleting the Ink account must not imply deleting source calendars owned by external providers.

Product distinction:

```text
Ink account data
→ deleted

Ink share links
→ stopped

Apple / Google / Outlook calendar
→ unchanged
```

This needs explicit copy because “Delete account” is otherwise easy to interpret as “delete my calendars”.

---

## 12. Account deletion vs receivers

When the owner deletes their Ink account:

- active shares owned by that account stop;
- receivers eventually see **No longer shared**;
- receiver calendars are not silently deleted;
- receivers may remove them manually.

This should behave the same as a share being stopped, from the receiver’s perspective.

---

## 13. Account management and future subscriber/member access

v1 does not track subscriber counts or subscriber identities.

Account management therefore contains no:

- subscriber count;
- member list;
- invite list;
- per-person access controls.

These belong to a future subscriber/access-management phase together with invite-only or hybrid access.


## 14. Login copy guidelines

### Good

> Continue with Apple

> Continue with Google

> Sign in to share this calendar this calendar.

> Sign in to manage your shared calendar.

> You can keep using Ink without signing in.

> Sign in again to continue.

### Avoid

> You must create an account to use Ink.

> Sign in to access your calendar.

> Create a sharing account.

> Login required.

The copy should explain **why this action needs identity**.

---

## 15. Settings information architecture

Recommended v1:

```text
SETTINGS

ACCOUNT
Account  ›

CALENDAR
...

APPEARANCE
...

ABOUT
...
```

Do not duplicate account controls inside individual feature settings.

If future features require account identity, they should reuse this same account.

---

## 16. Cross-device mental model

Signing in on another Ink device should restore account-owned share management.

Receiver-local calendars and source availability may differ per device.

Example:

```text
Device A
Work source calendar available
→ Manage Sharing normally

Device B
Same Ink account
Work source calendar unavailable
→ Can see/manage share metadata
→ Source calendar unavailable
```

The account identifies ownership of the share.

The local device determines whether the original source calendar is currently available for publishing updates.

---

## 17. Empty / first-time account state

If the user signs in from Settings before ever using an account-dependent feature:

```text
┌──────────────────────────────────────┐
│              Account                 │
│                                      │
│ Signed in                            │
│                                      │
│ You’re signed in to Ink.           │
│                                      │
│ You’ll use it when a feature needs   │
│ account ownership, such as sharing   │
│ calendars.                           │
│                                      │
│ [ Sign out ]                         │
└──────────────────────────────────────┘
```

Avoid adding empty dashboards or account home screens that have no user value.

---

## 18. Error states

### 18.1 Sign-in cancelled

No error banner required.

Return the user to the previous context.

### 18.2 Sign-in failed

```text
Couldn’t sign in

Try again in a moment.

[ Try again ]
[ Cancel ]
```

### 18.3 Session expired / invalid

When an account-dependent action is attempted:

```text
Sign in again

Please sign in again to continue.

[ Continue with Apple ]
[ Continue with Google ]
```

Avoid scary security wording unless there is a known security event.

### 18.4 Account deletion failed

Do not log the user out or pretend deletion succeeded.

```text
Couldn’t delete account

Nothing was deleted. Try again in a moment.

[ Try again ]
```

---

## 19. Accessibility

- Sign in with Apple control must have an accessible label.
- Do not communicate signed-in state using icon/color alone.
- Destructive account deletion must have explicit text.
- Confirmation copy should be screen-reader friendly and concise.
- Dynamic Type should not hide destructive action consequences.
- Account state should remain understandable without profile imagery.

---

## 20. Analytics/product events

Useful high-level events:

- account_sign_in_started;
- account_sign_in_completed;
- account_sign_in_cancelled;
- account_sign_out;
- account_delete_started;
- account_delete_completed;
- share_login_gate_shown;
- share_manage_login_gate_shown.

Do not put authentication credentials or private calendar content into analytics.

---

## 21. Acceptance criteria

### Login behavior

- **AC-A1** Ink remains usable without an account.
- **AC-A1a** Contextual and Settings login surfaces offer both Continue with Apple and Continue with Google.
- **AC-A1b** Google Calendar connection state does not count as Ink account login state.
- **AC-A2** Opening Manage Calendar does not require login.
- **AC-A3** Share Calendar asks for login only when the user starts the share action.
- **AC-A4** Successful contextual login returns the user to the action they were performing.
- **AC-A5** Cancelling login returns to the previous context without creating/changing a share.
- **AC-A6** Manage Sharing while signed out offers Sign in to manage rather than granting owner actions from local cache.

### Account management

- **AC-A7** Account controls live in Settings → Account.
- **AC-A8** Sign out does not stop active shares.
- **AC-A9** Sign out does not remove source calendars or receiver shared calendars.
- **AC-A10** Signing back in restores account-owned share state.
- **AC-A11** Missing source calendars after re-login show Source calendar unavailable instead of being rebound by name.

### Owner self-share behavior

- **AC-A12** Owner opening their own share link and then signing in is routed to Manage Sharing.
- **AC-A13** The owner is not counted as a receiver subscriber after ownership is known.
- **AC-A14** A self-added receiver duplicate is reconciled after owner login.

### Delete account

- **AC-A15** Delete account is distinct from Sign out.
- **AC-A16** Delete confirmation explicitly says active share links will stop.
- **AC-A17** Delete confirmation does not imply external source calendars will be deleted.
- **AC-A18** After account deletion, Ink returns to a signed-out but usable state.
- **AC-A19** Receivers of deleted-account shares eventually see No longer shared.

---

## 22. Open questions

| # | Question | Recommendation |
|---|---|---|
| 1 | Should Settings allow proactive sign-in before any feature asks for it? | Yes; useful for account continuity, but never force it |
| 2 | Should Sign out require confirmation? | Light confirmation is useful because active shares remain running |
| 3 | Should Account show Apple email/name? | Only if Ink deliberately stores and uses them; otherwise omit |
| 4 | Should there be an account avatar/profile? | No need in v1 unless profile features exist |
| 5 | Should users see a list of all active shares in Account? | No; calendar-first sharing management remains canonical |
| 6 | Should account deletion show the number of active shares that will stop? | Nice improvement if readily available, e.g. “3 shared calendars will stop” |
| 7 | What other Ink cloud data will account deletion eventually cover? | Update this spec when account scope expands beyond sharing |
| 8 | Should receiver anonymous subscriptions ever require account login? | Not in v1; revisit only for invite/access-control phase |

---

## 23. Core UX story

> **Ink does not require an account for normal use.**  
> **When a user starts an action that needs ownership, Ink asks them to sign in and then returns them to that action.**  
> **Account settings live in one predictable place: Settings → Account.**  
> **Signing out pauses account management on that device; it does not stop sharing.**  
> **Deleting the account is the destructive action that stops account-owned shares.**

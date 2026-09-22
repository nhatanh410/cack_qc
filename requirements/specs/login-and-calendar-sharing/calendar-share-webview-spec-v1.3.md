# Spec: Shared Calendar Web View — Receiver Experience

**Document Version:** 1.3  
**Status:** Draft  
**Product:** Ink  
**Scope:** Public share-link web experience before opening Ink  
**Related PRD:** Shared Calendars v1.8

---

## 1. Goal

The Web View exists to help a receiver understand what was shared before entering Ink.

Its job is to:

1. confirm that the link represents a shared Ink calendar;
2. show a useful but privacy-safe preview;
3. explain that the calendar is read-only and stays updated by its owner;
4. move the receiver into Ink to actually follow the calendar.

The Web View is **not** a full calendar client and is **not** a webcal/ICS subscription surface.

Core product rule:

> **Preview on the web. Follow in Ink.**

---

## 2. Product principles

### 2.1 Content first, app promotion second

The page should first answer:

> “What did someone share with me?”

Only then should it ask the receiver to open or install Ink.

Avoid turning the page into an app-install wall.

### 2.2 Ink-only following

The receiver can preview the shared calendar on the web, but following it requires Ink.

There is no:

- Subscribe in Apple Calendar;
- Google Calendar subscription;
- Outlook subscription;
- ICS download.

### 2.3 Privacy settings must carry through

The Web View must never reveal more event detail than the sender allowed.

If the sender hides event details, the web preview must reflect that setting.

### 2.4 Preview does not equal subscription

Opening or viewing the Web View does **not** increment the share’s subscriber count.

A subscriber is counted only after the receiver successfully chooses **Add to Ink** inside the app.

---

## 3. Default page hierarchy

Recommended mobile-first hierarchy:

```text
Ink brand
↓
Shared calendar label
↓
Calendar name
↓
Optional owner/context copy
↓
Calendar preview
↓
Read-only/live explanation
↓
Primary CTA
↓
Install fallback / secondary action
↓
Last updated
```

Keep the page visually lightweight.

---

## 3.1 Shared-by identity

If the share exposes an Ink public display name, show:

> **Shared by Alex**

The name comes from the owner’s editable Ink **public display name**.

Do not present Apple/Google account metadata as verified identity. If no public display name is available, omit the line.

## 4. Default Web View

```text
┌────────────────────────────────────────┐
│                 Ink                    │
│                                        │
│            Shared calendar             │
│                                        │
│  Work                                  │
│  Shared by Alex                        │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │ MON 14                           │  │
│  │                                  │  │
│  │ 09:00  Team standup              │  │
│  │ 14:30  Design review             │  │
│  │                                  │  │
│  │ TUE 15                           │  │
│  │                                  │  │
│  │ 10:00  Planning                  │  │
│  │ 16:00  Focus time                │  │
│  └──────────────────────────────────┘  │
│                                        │
│  This calendar is read-only and stays  │
│  updated by its owner.                 │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │           Open in Ink            │  │
│  └──────────────────────────────────┘  │
│                                        │
│  Don’t have Ink?                       │
│  Get Ink to add this calendar       │
│                                        │
│  Updated 12 minutes ago                    │
└────────────────────────────────────────┘
```

---

## 5. Primary CTA behavior

### 5.1 If Ink is installed

Primary CTA:

> **Open in Ink**

Expected flow:

```text
Web View
   ↓
Open in Ink
   ↓
Ink handles share link
   ↓
Owner?
 ┌─┴─────────────┐
 yes             no
 ↓               ↓
Manage Sharing   Receiver preview
                 ↓
              Add to Ink
```

### 5.2 If Ink is not installed

Recommended fallback:

```text
┌────────────────────────────────────────┐
│                                        │
│  Follow this calendar in Ink to keep   │
│  receiving updates.                    │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │             Get Ink              │  │
│  └──────────────────────────────────┘  │
│                                        │
│  Already have Ink?                     │
│  Open app                              │
└────────────────────────────────────────┘
```

Avoid showing two equally strong primary buttons at the same time.

Preferred behavior:

1. attempt/open Ink;
2. if unavailable, fall back to **Get Ink**.

---

## 6. Receiver flow after entering Ink

The Web View should not ask the user to “Import”.

Inside Ink, use:

> **Add to Ink**

or:

> **Add shared calendar**

Receiver-facing mental model:

> This is someone else’s live, read-only calendar that I can follow inside Ink.

---

## 7. Owner opens their own share link

The Web View itself does not need a separate owner-specific state before identity is known.

The same page can render normally.

When the user taps **Open in Ink**:

```text
Web View
   ↓
Open in Ink
   ↓
Ink checks current account
   ↓
Current account owns share
   ↓
Manage Sharing
```

The owner must **not** be allowed to subscribe to their own share after ownership is known.

If the owner previously added their own share while logged out, Ink reconciles that state after sign-in and removes/merges the duplicate receiver copy.

---

## 8. Privacy-aware preview

### 8.1 Event details visible

```text
┌──────────────────────────────────┐
│ MON 14                           │
│                                  │
│ 09:00  Team standup              │
│ 14:30  Design review             │
│                                  │
│ TUE 15                           │
│                                  │
│ 10:00  Planning                  │
└──────────────────────────────────┘
```

### 8.2 Event details hidden

```text
┌──────────────────────────────────┐
│ MON 14                           │
│                                  │
│ 09:00 – 10:00   Busy             │
│ 14:30 – 15:30   Busy             │
│                                  │
│ TUE 15                           │
│                                  │
│ 10:00 – 11:00   Busy             │
└──────────────────────────────────┘
```

Never reveal hidden:

- event titles;
- notes;
- locations;
- URLs;
- other private event fields.

The Web View preview and Ink receiver preview must follow the same sender visibility rules.

---

## 9. Valid share state

Recommended default copy:

**Label**

> Shared calendar

**Description**

> This calendar is read-only. Updates will appear here when available.

**Primary CTA**

> Open in Ink

**Install fallback**

> Get Ink to add this calendar

**Freshness**

> Updated 12 minutes ago

Avoid implying true real-time delivery.

---

## 10. Expired share

```text
┌────────────────────────────────────────┐
│                 Ink                    │
│                                        │
│            Shared calendar             │
│                                        │
│  Work                                  │
│                                        │
│                 ⚠                      │
│                                        │
│  This calendar link has expired.     │
│                                        │
│  Ask the person who shared it to renew or share it again.   │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │            Open Ink             │  │
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

When the share is expired, the Web View may continue to show the last published preview with a clear **Expired** state; it must not imply that updates are still arriving.

---

## 11. Owner stopped sharing

```text
┌────────────────────────────────────────┐
│                 Ink                    │
│                                        │
│            Shared calendar             │
│                                        │
│  Work                                  │
│                                        │
│                 ⚠                      │
│                                        │
│  This calendar is no longer being shared.    │
│                                        │
│  The owner has stopped sharing it.     │
└────────────────────────────────────────┘
```

Use **No longer shared** terminology consistently with the Ink receiver state.

Do not imply that the calendar was deleted.

---

## 12. Invalid or unavailable link

```text
┌────────────────────────────────────────┐
│                 Ink                    │
│                                        │
│          This calendar isn’t available          │
│                                        │
│  This share link is invalid or no      │
│  longer available.                     │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │            Open Ink             │  │
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

This is intentionally generic.

Do not reveal unnecessary details about whether a private share ID ever existed.

---

## 13. Temporary loading / connectivity issue

If the Web View cannot load the share because of temporary connectivity, do not present it as expired or revoked.

```text
┌────────────────────────────────────────┐
│                 Ink                    │
│                                        │
│        Can’t load this calendar          │
│                                        │
│  Check your connection and try again.  │
│                                        │
│  ┌──────────────────────────────────┐  │
│  │             Retry               │  │
│  └──────────────────────────────────┘  │
└────────────────────────────────────────┘
```

States must remain distinct:

- temporary load failure;
- expired;
- no longer shared;
- invalid/unavailable.

---

## 14. Subscription tracking scope

v1 does not track or display subscriber counts.

Web View behavior remains simple:

- opening the link does not create any subscriber/member record;
- previewing the calendar does not create any subscriber/member record;
- opening or installing Ink from the page does not create any subscriber/member record.

A future subscriber/access-management phase may introduce membership/subscription tracking together with invite/access controls.


## 15. Content hierarchy

Recommended order:

### Above the fold

1. Ink
2. Shared calendar
3. Calendar name
4. first preview events
5. Open in Ink

### Below

6. read-only/live explanation
7. install fallback
8. last updated
9. optional lightweight product/footer links

Avoid putting:

- account sign-in;
- marketing carousel;
- feature comparison;
- App Store screenshots;
- long product copy;

ahead of the shared content.

---

## 16. Calendar preview scope

The Web View is a preview, not a web calendar.

Recommended v1:

- show roughly **3–6 upcoming events**;
- enough rows to establish what the calendar contains;
- no complex month navigation;
- no editing;
- no search;
- no calendar settings;
- no subscription management.

Potential layout:

```text
Today
─────
09:00  Standup
14:30  Review

Tomorrow
────────
10:00  Planning

+ 4 upcoming events
```

The exact event count should be tuned for mobile screen size.

---

## 17. Mobile-first behavior

The share link will commonly arrive through:

- Messages;
- Mail;
- social/chat apps;
- QR/link copy.

Design for a narrow mobile viewport first.

Guidelines:

- single-column layout;
- no horizontal scrolling;
- CTA full width;
- calendar preview readable without zoom;
- avoid modal-on-modal behavior;
- keep primary CTA visible after the user understands the content.

Desktop can center the same content in a narrow card rather than becoming a separate experience.

---

## 18. Copy guidelines

### Tone

Keep copy short, calm, and action-oriented.

Prefer everyday language:

- “This calendar isn’t available”
- “Open in Ink”
- “Get Ink”
- “This calendar is no longer being shared”

Avoid technical language:

- invalid share ID
- revoked
- source unavailable
- subscription
- payload

Prefer direct product language.

### Use

- Shared calendar
- Open in Ink
- Get Ink
- Add to Ink
- Read-only
- Updated …
- No longer shared
- This shared calendar has expired

### Avoid

- Import calendar
- Sync this feed
- Subscribe via ICS
- Download calendar
- Live in real time
- Shared with X people

For counts, use:

> 12 subscribers

not:

> 12 people

---

## 19. Accessibility

Minimum expectations:

- semantic heading structure;
- sufficient contrast;
- event state must not rely on color alone;
- primary CTA has explicit text;
- readable dynamic type / text scaling;
- screen reader labels for event time and title;
- status icons accompanied by text;
- touch targets large enough for mobile interaction.

Example screen-reader event phrasing:

> Monday 14 September, 9 AM to 10 AM, Team standup.

---

## 20. Analytics/product events

Track Web View behavior only at aggregate/product level.

Useful events:

- share_web_opened;
- share_web_preview_rendered;
- open_in_ink_tapped;
- get_ink_tapped;
- share_web_expired_seen;
- share_web_unavailable_seen.

Do not count any of these as a subscription.

Subscription is created only after **Add to Ink** succeeds.

---

## 21. Acceptance criteria

### Valid page

- **AC-W1** A valid share link renders calendar name and a privacy-safe preview.
- **AC-W2** Primary action leads toward opening Ink.
- **AC-W3** A receiver can understand that the calendar is read-only and owner-updated.
- **AC-W4** Web View does not offer ICS/webcal or external calendar subscription.
- **AC-W5** Hidden event details never appear in the web preview.
- **AC-W6** Loading the Web View does not increment subscriber count.

### App hand-off

- **AC-W7** If Ink is available, Open in Ink hands the share into the app.
- **AC-W8** If Ink is unavailable, receiver has a clear Get Ink path.
- **AC-W9** Owner opening their own link is routed by Ink to Manage Sharing after ownership is known.
- **AC-W10** v1 creates no subscriber/member tracking from Web View or Add to Ink.

### Error/state handling

- **AC-W11** Expired share has a distinct expired state.
- **AC-W12** Stopped share displays No longer shared / owner stopped sharing.
- **AC-W13** Invalid/unavailable link has a generic unavailable state.
- **AC-W14** Temporary network failure is not shown as expired or revoked.

### Mobile UX

- **AC-W15** The main experience is usable on a narrow mobile viewport without horizontal scrolling.
- **AC-W16** Primary CTA is visually dominant over install fallback and secondary copy.
- **AC-W17** Shared content appears before promotional product content.

---

## 22. Open questions

| # | Question | Recommendation |
|---|---|---|
| 2 | Should web preview show events beyond the first viewport? | Yes, limited scrolling is fine; avoid becoming a full web calendar |
| 5 | Should Get Ink go directly to the store or use smart fallback? | Prefer smart Open-in-Ink first, store fallback second |
| 6 | Should desktop have a QR code to open on iPhone? | Potential enhancement, not required for v1 |
| 7 | Should the Web View ever show subscriber/member count? | No for v1; revisit only with future access-management work |
| 8 | Should users be able to preview without JavaScript/app detection? | Prefer yes for resilient shared-link behavior |

---

## 23. Core UX story

> **The receiver opens a link and immediately understands what calendar was shared.**  
> **They can preview only the information the owner allowed.**  
> **The page explains that following the calendar happens inside Ink.**  
> **Opening the page does not create subscriber/member tracking in v1.**

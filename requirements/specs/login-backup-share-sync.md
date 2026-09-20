# Login, backup, share & sync — system reference

One orientation document for the four things that move data off the device:
signing in, backing up an unshared `.ink` calendar, sharing a calendar with
someone else, and keeping any of those in sync afterward. Written for an
agent picking this up cold — it trades narrative for tables and file paths.
Verified against `main` on 2026-09-20.

**Companion docs, each a deeper dive on one slice:**

| Doc | Covers |
|---|---|
| [`identity-model.md`](identity-model.md) | Device-vs-account grant tiering, the general rule for any new networked data |
| [`../calendar-sync-model.md`](../calendar-sync-model.md) | Per-provider (Ink/Apple/Google/Outlook) read/write semantics, event identity, the ingest→diff→push pipeline |
| [`calendar-sharing.md`](calendar-sharing.md) | Share-specific operational detail: App Check, the public page, the EventKit projection. Dated 2026-09-17 — its D1 table list (`shares`, `shared_events`) predates the 0008/0009 migrations below; this doc has the current names. |
| `docs/superpowers/plans/2026-09-18-unified-calendar-store.md` §3b | Original design for calendar-content-on-the-server |
| `docs/superpowers/plans/2026-09-15-ink-shared-calendar-sync.md` | Original share-sync design |

---

## 1. Two repos

| | |
|---|---|
| **App** | `ios/Ink` — this repo |
| **Backend** | `worker-ink-lockscreen-calendar` — Cloudflare Worker + D1, deployed to `inkcalendar.app/api/*` |
| **Website** | `fe-ink-calendar` — Next.js on Vercel, not cloned locally; reads `GET /api/ink/share/:id/page` server-side |

D1 database `inkcalendar-worker`. Tables as of migration `0009_share_members.sql`:

| Table | Rows | Key |
|---|---|---|
| `calendars` | one per calendar that has ever synced (shared OR backed-up), owner-scoped | `id` (client-minted UUID) |
| `calendar_events` | event content for any calendar in `calendars` | `(id, calendar_id)` |
| `shares` | one per active share **link** (a calendar can have zero or one) | `id` = the share id, and for a shared calendar `id == calendars.id` |
| `share_members` | device/uid grants on a share, `(share_id, subject_type, subject_id)` | see `identity-model.md` |
| `rate_limits` | sliding-window counters | bucket string |
| `app_settings` | misc | key |

There is no `users` table — a signed-in identity lives in Firebase Auth and
only reaches D1 as `owner_uid` columns.

```bash
cd worker-ink-lockscreen-calendar && source ~/.cf-silverai-token && \
  npx wrangler d1 execute inkcalendar-worker --remote --json --command "SELECT …"
```
The ambient `wrangler login` is the wrong Cloudflare account — always source
the token file first, in the same shell invocation as the command (env vars
from `source` don't persist across separate tool calls).

---

## 2. Login (identity)

`InkAccountService` (`ios/Ink/Services/InkAccountService.swift`) wraps
Firebase Auth. Two providers only, **never merged by email** — an Apple
account and a Google account with the same address are two different Ink
accounts:

```swift
enum InkAccountSession {
  case signedOut
  case signedIn(provider: .apple | .google, uid: String, email: String?, name: String?, photoURL: URL?)
}
```

- **`signOut` means "no account"**, not "no Firebase session." An anonymous
  Firebase session (used only to satisfy the Worker's auth requirement for an
  otherwise-anonymous sharer/joiner) still reads as `.signedOut` here.
- Two token accessors, deliberately different:
  - **`idToken()`** → `nil` when there is no real account. Two call sites read
    this nil as "no account, show the sign-in gate."
  - **`syncIdToken()`** → always resolves, signing in anonymously if needed.
    Every sync/backup call uses this — sharing and backup have never required
    a real account.
- Sign-in is a **UI-only gate**. `POST /api/ink/share` and the backup push
  endpoints authenticate whoever calls (anonymous or real), they don't require
  a *particular kind* of caller. `owner_uid` on a `calendars`/`shares` row can
  be an anonymous Firebase uid.
- Google reuses **one** `GIDSignIn` session shared with Google Calendar
  connection; Ink's own login never adds the calendar scope to it
  (`InkGoogleIdentityClient`).
- No route here for login itself — Firebase Auth SDK talks to Firebase
  directly, not through the Worker. The Worker only ever **verifies** the ID
  token another route received (`verifyFirebaseIdToken`,
  `src/firebase-auth.ts`).

`DELETE /api/ink/account` — Bearer required. Stops every share this account
owns and removes this uid from every `share_members` row (both directions:
owner and joined-as-member), before the Firebase account itself is deleted
client-side. `src/ink-account.ts`.

---

## 3. The three ways calendar content reaches the server

| | Share sync | Backup sync | Public share page |
|---|---|---|---|
| Purpose | Live, two-way sync with a joiner | Off-device copy of a calendar nobody else can see | Read-only preview for someone who hasn't joined yet |
| Trigger | Any calendar with `shareId != nil` | An **unshared** `.ink` calendar (`provider == .ink && shareId == nil`) | Browser hitting the share link |
| Auth | Anonymous OR real (owner-device bypass; joiner needs an `editor` link) | **Real sign-in required** (`case .signedIn`) — an anonymous user has no other device to restore to, so backup is meaningless for them | None (public) |
| iOS entry point | `SharedCalendarSyncEngine.sync(shareId:)` | `SharedCalendarSyncEngine.syncBackup(calendarId:)` | n/a (browser only) |
| Worker file | `src/ink-share-sync.ts` | `src/ink-calendar-backup.ts` | `src/ink-share.ts` |
| Shared machinery | `src/ink-sync-shared.ts` — `applyEventMutations`, `pullEventsSince`, `MAX_*` caps | same file, same functions | n/a |
| Gated by | — | `InkBackupPreferenceStore.isEnabled` (UserDefaults `ink.backupEnabled`, default **true**) | — |

Both sync paths funnel through the **same** private `push`/`pull` bodies in
`SharedCalendarSyncEngine.swift` — only the transport (which URL, which
metadata) differs (`CalendarSyncTransport.share`/`.backup`). A fix to one
(chunking, error handling) is a fix to both for free.

---

## 4. API routes

Base: `https://inkcalendar.app/api/ink`. Every route below except `/help`
requires `X-Firebase-AppCheck` (App Check) — see `calendar-sharing.md` §5 for
the two deliberately-open exceptions (`/share/:id/page`, `/share/:id/unlock`).
"Bearer" = `Authorization: Bearer <Firebase ID token>`.

### Share

| Method | Path | Auth | Purpose | Source |
|---|---|---|---|---|
| POST | `/share` | optional Bearer (`owner_uid`), `X-Device-Id` (`owner_device_id`) | Create a share: snapshot + `shares`/`calendars` row | `src/ink-share.ts` |
| GET | `/share/:id` | none | Payload JSON for the app's join preview | `src/ink-share.ts` |
| POST | `/share/:id/unlock` | none, own rate limit | Password → unlock token | `src/ink-share.ts` |
| GET | `/share/:id/page` | none (public) | Public page data (Next.js server-side only) | `src/ink-share.ts` |
| PATCH | `/share/:id` | Bearer, must own | Change `link_role` (`viewer`\|`editor`) | `src/ink-share.ts` |
| DELETE | `/share/:id` | Bearer, must own | Stop sharing — deletes `shares`+`share_members`, **keeps** `calendars`/`calendar_events` | `src/ink-share.ts` |
| GET | `/share/:id/mine` | Bearer | Is this link mine? | `src/ink-share.ts` |
| POST | `/share/:id/join` | Bearer or anonymous | Enroll this device/uid as a member | `src/ink-share.ts` |
| GET | `/share/:id/members` | Bearer, must own | List members | `src/ink-share.ts` |
| PATCH | `/share/:id/members/:uid` | Bearer, must own | Grant/revoke a per-member role exception | `src/ink-share.ts` |
| DELETE | `/share/:id/members/:uid` | Bearer, must own | Revoke a member | `src/ink-share.ts` |
| GET | `/share/:id/sync?since=<cursor>` | anonymous OR Bearer (owner-device bypass via `X-Device-Id`) | Pull delta | `src/ink-share-sync.ts` |
| POST | `/share/:id/sync` | same | Push mutations | `src/ink-share-sync.ts` |

`POST /share` response: `{id, url, page_url, created_at}` —
`page_url = https://inkcalendar.app/share/<id>`.

### Backup (unshared `.ink` calendars)

| Method | Path | Auth | Purpose | Source |
|---|---|---|---|---|
| POST | `/calendars/:id/sync` | **Bearer required** | Upsert `calendars` metadata + push mutations | `src/ink-calendar-backup.ts` |
| GET | `/calendars/:id/sync?since=<cursor>` | **Bearer required** | Pull delta | `src/ink-calendar-backup.ts` |

`POST` body: `{"calendar": {name, color, symbol?, description?, owner_name?}, "mutations": [...]}`.
`calendar` is upserted on **every** call, not just the first — no
client-side "have I registered yet" flag needed. `provider` is never read
from the body; hardcoded `'ink'` server-side. Rate limit bucket
`calbackup:<id>:<uid>`, separate from share-sync's `sync:` bucket.

Both routes read `calendars.deleted_at`: a tombstoned calendar (deleted via
`DELETE /calendars/:id`, see below) 404s with `error_code: "calendar_deleted"`
on either route rather than being silently recreated by a stale device's
push — see §6.

### Calendar listing / lifecycle

| Method | Path | Auth | Purpose | Source |
|---|---|---|---|---|
| GET | `/calendars` | Bearer | Everything this uid can reach: `calendars` (owned, includes backup + shared) and `memberships` (joined) | `src/ink-calendars.ts` |
| DELETE | `/calendars/:id` | Bearer, must own | Delete a calendar: hard-deletes `share_members`/`calendar_events`/`shares`, **tombstones** `calendars` (`deleted_at`) | `src/ink-calendars.ts` |

### Account

| Method | Path | Auth | Purpose | Source |
|---|---|---|---|---|
| DELETE | `/account` | Bearer | Stop every owned share, remove this uid from every `share_members` row | `src/ink-account.ts` |

Not covered here (unrelated to this doc's scope): `POST /chat`, `POST /help`,
`GET /quota` — the Ink AI assistant endpoints.

---

## 5. Sync mechanics (shared by share-sync and backup)

**Cursor.** `syncCursor: Int64` on `CalendarEntity` — Unix epoch
**milliseconds**, `Int64((date.timeIntervalSince1970 * 1000).rounded())`. Per
**device**, never shared across devices or synced anywhere. The server never
stores it; it computes the answer fresh every pull:

```sql
SELECT ... FROM calendar_events
WHERE calendar_id = ? AND updated_at > ?
ORDER BY updated_at ASC LIMIT 500
-- cursor = last row's updated_at, or the input `since` if nothing came back
```
(`pullEventsSince`, `src/ink-sync-shared.ts`)

**Round shape**, `SharedCalendarSyncEngine.sync`/`syncBackup`:
```
1. push  — every locally-dirty row (isDirty == true), batched (§6)
2. pull  — GET .../sync?since=<pre-push cursor>
3. apply — pulled rows write into the local store; cursor + linkRole advance
```
Pull always uses the **pre-push** cursor, so a device naturally re-confirms
its own just-pushed rows in the same round (harmless — same `updated_at`,
idempotent apply).

**Conflict rule**: last-write-wins by `updated_at`, enforced in the upsert's
`WHERE` clause, not a read-then-compare:
```sql
ON CONFLICT (id, calendar_id) DO UPDATE SET ... WHERE excluded.updated_at > calendar_events.updated_at
```
A losing mutation is silently dropped; the caller gets back the row that's
actually stored (`applyEventMutations`'s per-mutation echo), so an out-of-date
push sees the winner immediately rather than waiting for the next pull.

**Limits** (`src/ink-sync-shared.ts`):

| Constant | Value | Enforced |
|---|---|---|
| `MAX_SYNC_BODY_BYTES` | 512 KB | per push request → `413` |
| `MAX_MUTATIONS_PER_REQUEST` | 500 | per push request → `400` |
| `MAX_PULL_ROWS` | 500 | per pull page (client re-pulls with the new cursor for more — no pagination loop exists client-side today; self-heals over multiple foreground passes) |

**Client-side batching** (`SharedCalendarSyncEngine.push`, `pushBatchSize =
500`, added 2026-09-20): dirty mutations above the request cap are split into
sequential requests instead of one oversized push. A failing batch stops the
loop — the untried rows stay dirty for the next foreground rather than being
sent out of order. This does **not** chunk by byte size — a batch of 500
small events is the assumed common case; a batch that's still >512 KB despite
being ≤500 mutations will still 413. Named, not fixed.

**Terminal vs. transient failure** — `SharedCalendarSyncEngine.record(terminal:calendarId:)`.
The engine never throws; every failure degrades silently *except* two, which
never fix themselves on retry:

| Error | Meaning | Action |
|---|---|---|
| `InkShareApiError.revoked` (403 `revoked`) | Owner downgraded this member's access | `updateAccessLoss(reason: .revoked)` — UI shows it, clears itself on next successful pull |
| `InkShareApiError.notFound` (404, any `error_code`) | The share/calendar is gone server-side | **`.joined` row** → delete calendar + events + EventKit projection. **Any other row (owner's own, including a backup calendar)** → `clearShare` only (unlink), calendar itself survives |
| anything else (`429`, `500`, `403 read_only`, oversized/malformed) | Transient or a state that self-corrects | no-op; row stays dirty, retried next trigger |

A 404 from the backup endpoints (never-registered **or** tombstoned — same
status either way) hits the same "not `.joined`" branch as a share losing its
link: `clearShare` runs, which is a no-op for an already-unshared calendar
(`shareId` is already nil). The calendar and its events are **not** deleted
locally in this case — only the push/pull loop stops making progress against
a dead server row (it keeps retrying every foreground, harmlessly).

---

## 6. Backup: what it is, what it isn't

Ships in full — Phases 1–5 of `docs/superpowers/plans/piped-munching-ocean.md`
merged (PRs #283–286 iOS, plus the Worker backup-endpoints PR). Toggle:
Settings → account-wide switch, `InkBackupPreferenceStore.isEnabled`, default
**on**. Turning it off never deletes the server copy — it just stops the three
call sites below from running; turning it back on resumes from wherever
`syncCursor` was left.

**Three call sites, one gate each on `isEnabled` (and real sign-in):**
1. `CalendarLiveSync.run()` — foreground pass, loops every unshared `.ink`
   calendar (`fetchBackupCalendarIds()`).
2. `SharedCalendarDetailViewModel`'s post-edit hook — immediate push right
   after a save, closing the "device lost before next foreground" gap.
3. `SharedCalendarReconcile.run()` — restore. `GET /calendars` lists this
   uid's own calendars; a `.ink`-provider one missing locally gets a fresh row
   + a full pull (`syncCursor` starts at 0).

**Delete-gate fix (Phase 2)**: `SharedCalendarDetailViewModel.confirmDelete()`
calls `DELETE /calendars/:id` whenever `isOwnCalendar && signedIn` — **not**
gated on `shareId != nil` any more. Before this fix, deleting an unshared own
calendar was 100% local and the server row (once backup started creating one)
would outlive the local delete.

**Soft-delete (2026-09-20)**: `DELETE /calendars/:id` tombstones `calendars`
(`deleted_at`) instead of hard-deleting it, specifically so a second,
offline-at-delete-time device can't resurrect the calendar on its next
backup push — see §5's terminal-failure table. `calendar_events`/`shares`/
`share_members` for that calendar are still hard-deleted in the same batch.

**What's explicitly *not* built**, named as accepted gaps:
- No real-time push for backup-only calendars (unlike shared calendars, which
  wake other devices via FCM on every push). Considered and declined
  2026-09-19 — foreground sync + the immediate-push-after-edit hook already
  close the realistic window; nobody is watching a second device live.
- Byte-size chunking (only mutation-count chunking exists, §5).
- No chunked pull loop client-side for a calendar with >500 rows of backlog —
  self-heals across multiple foreground passes instead.

---

## 7. File map

### iOS (`ios/Ink/`)

| File | Owns |
|---|---|
| `Services/InkAccountService.swift` | Login/session, `idToken`/`syncIdToken` |
| `Domain/InkAccountSession.swift` | `InkAccountSession`, `InkAccountProvider` enums |
| `Services/SharedCalendarSyncEngine.swift` | Push/pull orchestration for both share and backup sync, terminal-failure handling, batching |
| `Services/SharedCalendarLiveSync.swift` (aka `CalendarLiveSync`) | Foreground trigger loop for both shared and backup calendars |
| `Services/SharedCalendarReconcile.swift` | Restore: joined memberships + owned backup calendars |
| `Data/InkShareApi.swift` | All HTTP calls — `push/pullSharedCalendarSync`, `push/pullCalendarBackupSync`, `fetchReachableCalendars`, `joinShare`, `setLinkRole`, `deleteShare`, `deleteCalendar` |
| `Data/InkBackupPreferenceStore.swift` | The Settings backup toggle, `ink.backupEnabled` |
| `Data/CalendarStoreRepository.swift` | SwiftData: `CalendarEntity`/`CalendarEventEntity`, dirty-tracking, `fetchBackupCalendarIds`/`fetchSharedCalendarIds` |
| `UI/CalendarTab/Share/ShareCalendarViewModel.swift` | Creating a share link |
| `UI/CalendarTab/Share/ManageSharingViewModel.swift` | Owner's share list: role toggle, stop sharing |
| `UI/CalendarTab/Share/SharedCalendarDetailViewModel.swift` | One shared/backup calendar's screen; `backupStatus`, delete gate, post-edit sync hook |
| `Services/InkPushService.swift` | FCM silent push → `sync(shareId:)` for **shared** calendars only (no equivalent for backup) |
| `Services/SharedCalendarProjection.swift` | Joined calendars → EventKit (never backup calendars — nothing to project) |

### Worker (`src/`)

| File | Owns |
|---|---|
| `firebase-auth.ts` | `verifyFirebaseIdToken`, JWKS caching |
| `ink-account.ts` | `readBearerToken`, `DELETE /account` |
| `ink-share.ts` | Share CRUD, join, members, public page, unlock |
| `ink-share-sync.ts` | Share push/pull route handlers |
| `ink-calendar-backup.ts` | Backup push/pull route handlers, `readCalendarOwner` (owner + tombstone check) |
| `ink-calendars.ts` | `GET /calendars` (list), `DELETE /calendars/:id` (soft-delete) |
| `ink-sync-shared.ts` | `applyEventMutations`, `pullEventsSince`, the `MAX_*` caps — shared by share-sync and backup |
| `app-check.ts` | `checkAppCheck` gate |
| `rate-limit.ts` | `hitRateLimit` |

---

## 8. Deploy

Manual only — CI never deploys (`.github/workflows/ci.yml` runs tests, not
`wrangler deploy`). From `worker-ink-lockscreen-calendar`, on latest `main`:

```bash
source ~/.cf-silverai-token && npm run typecheck && npm test && npm run deploy
```

Post-deploy smoke check (`README.md`'s own "Deploy" section):
```bash
curl -s -X POST https://inkcalendar.app/api/ink/help -H 'Content-Type: application/json' \
  -d '{"sessionId":"11111111-2222-3333-4444-555555555555","message":"x","deviceId":"smoke-1"}'
# expect 401 app_check_failed — proves App Check is enforcing
npx wrangler d1 execute inkcalendar-worker --remote \
  --command "SELECT bucket, count FROM rate_limits ORDER BY window_start DESC LIMIT 5"
# expect rows — proves the deployed worker is serving live traffic
```
Rollback: `npx wrangler rollback`.

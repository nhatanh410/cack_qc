# Template sharing — API for mobile

Section numbers 3.1–3.5 match
[`template-sharing.md`](template-sharing.md) §3; 3.8–3.9 are the owner calls
requested in [`template-sharing-history.md`](template-sharing-history.md). The app
calls **3.1–3.4** and **3.8–3.9**; 3.5 is for the web page only.

The contract between the Ink app and the Worker for sharing a saved wallpaper
as a public link. **Live in production** (worker
sfunvn/worker-ink-lockscreen-calendar#38). Product behaviour and app internals:
[`runbooks/template-sharing.md`](../runbooks/template-sharing.md). Backend
rationale: [`template-sharing.md`](template-sharing.md).

## The model in one paragraph

Each saved wallpaper has **one** public link per account:
`https://inkcalendar.app/t/<id>`. The first share creates it. Sharing the same
wallpaper again (after an edit, or with a different photo choice) **replaces
what that link shows** and returns the same `id`; the old version's pictures are
deleted. Publishing needs a real Apple/Google account. Opening a link needs
nothing. Whoever taps "Add to my collection" gets their own copy, which never
changes afterwards.

## Basics

| | |
|---|---|
| Base URL | `https://inkcalendar.app/api/ink` |
| App Check | Header `X-Firebase-AppCheck: <token>` on every call the app makes, except the image download (3.4). Missing/invalid → `401 {"error_code":"app_check_failed"}`; refresh the token and retry **once**. |
| Identity | Upload (3.1), publish (3.2), list (3.8) and stop (3.9) need `Authorization: Bearer <Firebase ID token>` of an **Apple or Google** account. Send the current user's ID token only; never mint an anonymous session for this. |
| Content type | JSON everywhere except the upload body (raw image bytes). |
| Ids | Share ids and asset ids match `[A-Za-z0-9_-]{1,64}` (the server mints 12-character base62). Reject anything else from a response or a link. |

Every error body has the same shape; branch on `error_code` when present, never
on `error`:

```json
{ "success": false, "error": "Human-readable text, English", "error_code": "sign_in_required" }
```

| `error_code` | Meaning | What the app does |
|---|---|---|
| `app_check_failed` | App Check token missing/invalid | Force-refresh the token, retry once |
| `sign_in_required` | No token, bad/expired token, or an anonymous account | Show the sign-in sheet, resume the share after sign-in |
| `invalid_template` | Payload failed validation (3.2), or an image could not be attached | Generic "Couldn't create a share link. Try again." — it is a client bug, log the status |
| `rate_limited` | Per-account cap hit ([Limits](#limits)) | Same generic message |

## Flow

```text
Sender (signed in with Apple/Google)
  1. POST /template-share/assets?kind=photo     ─▶ 201 {asset_id}   one per own photo/sticker, ONLY if "Include my photos"
  2. POST /template-share/assets?kind=preview   ─▶ 201 {asset_id}   optional; skip if the preview render failed
  3. POST /template-share?lang=<tag>            ─▶ 201 {id}  first time for this wallpaper
                                                 ─▶ 200 {id}  same wallpaper again: same id, new content
  4. Build https://inkcalendar.app/t/<id> from the id → system share sheet

Recipient (no account needed)
  5. Opens /t/<id> (web page) → "Open in Ink" → ink://template?id=<id>
  6. GET /template-share/<id>                   ─▶ 200 {data, preview_url, assets}
  7. On "Add to my collection": GET each URL in `assets` ─▶ image bytes
```

Upload a **fresh** set of images on every publish. Asset ids are single-use: an
image already attached to a share cannot be attached again, and the server
deletes images the new version no longer lists.

---

## 3.1 Upload an image — `POST /template-share/assets?kind=`

`POST /template-share/assets?kind=preview|photo`

Headers: App Check, `Authorization: Bearer …`, `Content-Type: image/jpeg` or `image/png`.
Body: the **raw bytes** (not multipart).

| `kind` | What | App encodes as |
|---|---|---|
| `preview` | The design rendered over **sample** events, never the user's calendar | JPEG, ≤ 1080 px |
| `photo` | One of the user's own backgrounds or stickers, only after "Include my photos" | Background: JPEG ≤ 2048 px. Sticker: PNG ≤ 1536 px |

- Max **2 MB** per image; check before sending. The server rejects bytes that are
  not really a JPEG/PNG, or that don't match `Content-Type`.
- Re-encode before upload so EXIF/GPS is stripped.
- A new image is **unclaimed**: nobody can download it until a publish (3.2)
  lists it, and it is deleted after 24 hours if none does.

**`201`**

```json
{ "success": true, "asset_id": "a1B2c3D4e5F6", "url": "https://inkcalendar.app/api/ink/template-share/assets/a1B2c3D4e5F6" }
```

| Status | When |
|---|---|
| `400` | Bad `kind`, `Content-Type` not JPEG/PNG, or bytes don't match it |
| `401` | `app_check_failed` or `sign_in_required` |
| `413` | Over 2 MB |
| `429` | `rate_limited`: 100 uploads or 50 MB per account per day |
| `502` | Storage failed; retry later |

## 3.2 Publish (create or update) the wallpaper's link — `POST /template-share?lang=`

`POST /template-share?lang=<tag>`

Headers: App Check, `Authorization: Bearer …`, `Content-Type: application/json`.

- `lang`: the app's resolved language (`vi`, `en`, `zh-Hant`…) — the web page is
  rendered in it. Anything malformed falls back to `en`.
- Body ≤ **64 KB**; check before sending.

```json
{
  "source_id": "3F2A9C1E-7B4D-4E8A-9C0D-1A2B3C4D5E6F",
  "template": {
    "schema": 1,
    "name": "My week",
    "layout_kind": "weekAgenda",
    "settings": {
      "backgrounds": [
        { "path": "catalog:https://assets.homebod.ai/templates/background/sea.jpg", "sourcePath": null, "cropRect": null },
        { "path": "shared:a1B2c3D4e5F6", "sourcePath": null, "cropRect": null }
      ],
      "decorations": { "items": [ { "kind": "image", "path": "shared:s7T8u9V0w1X2", "…": "…" } ] },
      "backgroundImagePath": null,
      "backgroundSourcePath": null,
      "…": "the rest of InkWallpaperStyleStore.encodeLayout"
    },
    "template": "{\"id\":\"classic-week\",…}",
    "origin_template_id": "classic-week"
  },
  "preview_asset_id": "p9Q8r7S6t5U4",
  "asset_ids": ["a1B2c3D4e5F6", "s7T8u9V0w1X2"]
}
```

| Field | Rule |
|---|---|
| `source_id` | **Required.** The saved wallpaper's id (`InkSavedTemplate.id`), `[A-Za-z0-9_-]{1,128}`. The server keys the one link per wallpaper on it. |
| `template.schema` | `1` |
| `template.name` | String, ≤ 80 characters (trim first) |
| `template.layout_kind` | `monthGrid`, `lunarMonth`, `weekAgenda`, `weekAndTodayEvents`, `reminderMatrix` or `stack`. Never a `notes*` layout. |
| `template.settings` | Object. Every `backgrounds[].path` / `sourcePath` is `catalog:https://assets.homebod.ai/…` or `shared:<asset_id>`; every image sticker (`kind: "image"`) is `shared:<asset_id>`. **No file paths.** `backgroundImagePath` and `backgroundSourcePath` must be `null`. Strip device state first: selected calendars, note id, album id, rotation clock. |
| `template.template` | Optional. The design body as a **JSON string**, ≤ 48 KB. Every URL-like string inside it (`://`, `data:`, `file:`) must be https on `assets.homebod.ai`. |
| `template.origin_template_id` | Optional string |
| `asset_ids` | The `kind=photo` uploads from 3.1 for this publish; ≤ 20, no duplicates, and must include every `shared:<id>` in `settings`. `[]` when the user chose "Use Ink backgrounds". |
| `preview_asset_id` | Optional. The `kind=preview` upload from 3.1. |

Every uploaded id must belong to the caller, be the right `kind`, and not be
attached to any share yet. A failed publish never changes the existing link.

**`201`** (first publish for this wallpaper) or **`200`** (update, same `id`)

```json
{
  "success": true,
  "id": "Xk29fLq0ZaB1",
  "page_url": "https://inkcalendar.app/t/Xk29fLq0ZaB1",
  "created_at": "2026-09-29T09:30:00.000Z",
  "updated_at": "2026-09-30T02:10:00.000Z"
}
```

- Treat `200` and `201` the same.
- **Build the link yourself** as `https://inkcalendar.app/t/<id>` after validating
  `id`; ignore `page_url`. The link goes into a share sheet under the user's name.
- Caching the link per wallpaper is optional: it only saves a request when
  nothing changed. After a reinstall the server still returns the same link.

| Status | When |
|---|---|
| `400` | `invalid_template`: a rule above failed, or an image could not be attached |
| `401` | `app_check_failed` or `sign_in_required` |
| `413` | Body over 64 KB |
| `429` | `rate_limited`: 30 publishes per account per day, or 500 links per account |
| `502` | Storage failed, or two publishes of the same new wallpaper raced; retry — the retry becomes an update |

## 3.3 Read a share — `GET /template-share/:id`

`GET /template-share/<id>` — App Check only, **no** Bearer.

**`200`**

```json
{
  "success": true,
  "id": "Xk29fLq0ZaB1",
  "created_at": "2026-09-29T09:30:00.000Z",
  "data": { "schema": 1, "name": "My week", "layout_kind": "weekAgenda", "settings": { }, "template": "…", "origin_template_id": "classic-week" },
  "preview_url": "https://inkcalendar.app/api/ink/template-share/assets/p9Q8r7S6t5U4",
  "assets": { "a1B2c3D4e5F6": "https://inkcalendar.app/api/ink/template-share/assets/a1B2c3D4e5F6" }
}
```

- `data` is the `template` object from 3.2, re-serialized (key order not kept).
- `preview_url` is `null` when the share has no preview; fall back to the
  catalog artwork of `data.template`.
- `assets` maps every shared photo id to its download URL.

**Treat the whole response as untrusted** — anyone with an account can write a
share:

- Keep only URLs that are https on `inkcalendar.app` (`preview_url`, `assets`)
  or on `assets.homebod.ai` (inside `data`). Drop or reject everything else.
- Reject a `data.schema` above what the build supports, or an unknown
  `layout_kind`, as "Update Ink".
- Never trust a Pro flag from the share: decide Pro from the local catalog by
  template id, and treat an unknown template as Pro.

| Status | When | App shows |
|---|---|---|
| `400` | Malformed id | Template unavailable |
| `401` | `app_check_failed` | Retry once, then generic error |
| `404` | No such share, or its owner deleted their account | Template unavailable |
| `410` | Reserved for taken-down shares (moderation, not built yet) | Template unavailable |

## 3.4 Download an image — `GET /template-share/assets/:asset_id`

`GET /template-share/assets/<asset_id>` — **public**, no App Check, no Bearer.
`HEAD` works too.

- Returns the bytes with their `Content-Type` and
  `Cache-Control: public, max-age=31536000, immutable`.
- Re-check the host (https, `inkcalendar.app`) before every request — the URL
  came off the network.
- Keep a picture only if it decodes as PNG/JPEG and is ≤ 2 MB; save it into the
  app's own storage, never reference the URL from the saved wallpaper.

| Status | When |
|---|---|
| `400` | Malformed id |
| `404` | No such image, or not attached to any share |

## 3.5 Web page data (not for the app) — `GET /template-share/:id/page`

`GET /template-share/<id>/page` — public. Called by the fe-ink-calendar server
to render `/t/<id>`. Returns only display fields (`name`, `layout_kind`,
`preview_url`, `created_at`, `lang`), never `settings` or `template`. The app
has no reason to call it.

## 3.8 List my shares — `GET /template-share/mine`

`GET /template-share/mine?limit=<n>&cursor=<c>`

Headers: App Check, `Authorization: Bearer …`.

| Query | Rule |
|---|---|
| `limit` | Optional, 1–100, default 50 |
| `cursor` | Optional; the `next_cursor` of the previous page. Opaque: pass it back as is. |

Order: `updated_at` descending (the last published first), ties by `id`.

**`200`**

```json
{
  "success": true,
  "shares": [
    {
      "id": "Xk29fLq0ZaB1",
      "source_id": "3F2A9C1E-7B4D-4E8A-9C0D-1A2B3C4D5E6F",
      "name": "My week",
      "layout_kind": "weekAgenda",
      "preview_url": "https://inkcalendar.app/api/ink/template-share/assets/p9Q8r7S6t5U4",
      "has_photos": true,
      "created_at": "2026-09-29T09:30:00.000Z",
      "updated_at": "2026-09-30T02:10:00.000Z"
    }
  ],
  "next_cursor": null
}
```

| Field | Meaning |
|---|---|
| `id` | Build `https://inkcalendar.app/t/<id>` from it after validating, as after 3.2 |
| `source_id` | The `source_id` sent to 3.2; matches a row to a wallpaper still in the collection |
| `name`, `layout_kind` | Of the current version |
| `preview_url` | The current preview, or `null` |
| `has_photos` | Whether the current version carries any `kind=photo` asset |
| `created_at` / `updated_at` | First publish / last publish, ISO 8601 UTC. Every publish bumps `updated_at`, even one that changed nothing. |
| `next_cursor` | `null` on the last page |

- Only the caller's live shares. A stopped link (3.9) or a deleted account's links
  are gone, not marked; there is no taken-down state yet.
- Display fields only: no `settings`, `template` or `assets`. Apply the same host
  check to `preview_url` as in 3.3.

| Status | When |
|---|---|
| `400` | Bad `limit` or `cursor` |
| `401` | `app_check_failed` or `sign_in_required` |
| `429` | `rate_limited`: 60 calls per account per hour |

## 3.9 Stop sharing one link — `DELETE /template-share/:id`

`DELETE /template-share/<id>` — headers: App Check, `Authorization: Bearer …`. No body.

- Deletes the share and every image attached to it. Afterwards 3.3, 3.4 and the
  web page answer `404` ("Template unavailable"). Recipients' saved copies are
  unaffected.
- Publishing the same `source_id` again later creates a **new** id (`201`). Drop the
  device link cache entry for that wallpaper (`ink.template.share.links.v1`) after
  a successful delete, or the next Share hands out the dead link.
- A second delete of the same id is `404`.

**`200`**

```json
{ "success": true, "id": "Xk29fLq0ZaB1" }
```

| Status | When |
|---|---|
| `400` | Malformed id |
| `401` | `app_check_failed` or `sign_in_required` |
| `404` | No such share, or not the caller's (never `403`, so ids can't be probed) |
| `429` | `rate_limited`: 60 deletes per account per day, 404s included |

## Limits

| Limit | Value | Response |
|---|---|---|
| Image size | 2 MB each | `413` |
| Publish body | 64 KB | `413` |
| Design body (`template.template`) | 48 KB | `400 invalid_template` |
| Photos per share | 20 | `400 invalid_template` |
| Uploads | 100 per account per day, 50 MB per day | `429 rate_limited` |
| Publishes (create + update) | 30 per account per day | `429 rate_limited` |
| Links | 500 live links per account; stopping one (3.9) frees a slot | `429 rate_limited` |
| List (3.8) | 60 per account per hour | `429 rate_limited` |
| Stop sharing (3.9) | 60 per account per day | `429 rate_limited` |

Daily windows reset at 00:00 UTC.

## Links and deep links

| Form | Where it comes from | App handling |
|---|---|---|
| `https://inkcalendar.app/t/<id>` | What the sender shares | Opens the web page, not the app: there are no universal links. If the app is handed one, it parses it **before** calendar-share links, which also live on `inkcalendar.app`. |
| `ink://template?id=<id>` | The web page's "Open in Ink" button | Custom scheme, the only way into the app. Use it to test until the web page ships. |

## Account deletion

No new call. `DELETE /api/ink/v2/account` (existing) now also deletes every
template share of the account and its images. Their links return `404`.
Recipients' saved copies are unaffected.

## Not available yet

- Report a share, ban an account, admin takedown (backend spec §3.6–3.7).
- The `/t/<id>` web page (fe-ink-calendar): [template-sharing-web-page.md](template-sharing-web-page.md).

## Testing

```bash
# Open a share in the simulator without the web page
xcrun simctl openurl booted "ink://template?id=<id>"

# Anything the app calls, without App Check → 401 app_check_failed
curl -i -X POST "https://inkcalendar.app/api/ink/template-share?lang=en"
curl -i "https://inkcalendar.app/api/ink/template-share/mine"
curl -i -X DELETE "https://inkcalendar.app/api/ink/template-share/<id>"

# Public routes
curl -i "https://inkcalendar.app/api/ink/template-share/<id>/page"
curl -I "https://inkcalendar.app/api/ink/template-share/assets/<asset_id>"
```

Neither sending nor receiving is gated by a flag.

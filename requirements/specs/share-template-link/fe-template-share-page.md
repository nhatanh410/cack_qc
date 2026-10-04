# fe-ink-calendar: the `/t/<id>` template share page

**Status:** needed before the Ink app **1.2.19** goes to the App Store.
**Owner:** fe-ink-calendar (the Next.js site on `inkcalendar.app`).
**Backend:** done and live. Nothing on the Worker changes for this page.

## 1. Why

Ink 1.2.19 lets a user share a saved lock screen wallpaper as a link. The app always shares:

```
https://inkcalendar.app/t/<id>
```

Today that URL returns **404**, because the site has no `/t/` page. Every link a user sends
lands on an error page. This page fixes that: it shows the shared design and lets the
recipient open it in Ink.

A live example to build against: `https://inkcalendar.app/t/A4k373Bks0Wo`
(data: `https://inkcalendar.app/api/ink/template-share/A4k373Bks0Wo/page`).

## 2. Decisions already made

- **No universal links.** Don't add `/t/*` to an `apple-app-site-association` file, and don't
  create one for this. The page opens the app with the **custom scheme** deeplink:

  ```
  ink://template?id=<id>
  ```

  The app already handles this link: it shows a preview and an **Add to my collection** button.
- **App Store fallback:** `https://apps.apple.com/app/id6769250805`.
- **The page lives in the site, not the Worker.** Don't add a Worker route for `/t/*`. The
  Worker only owns `inkcalendar.app/api/*`.
- It works the same way as the calendar share page (`/share/<id>`, built in
  `src/app/[lang]/share/[id]`). Copy its structure, language handling and styling.

## 3. Route

| | |
|---|---|
| Path | `/t/[id]`, mirroring how `/share/[id]` is set up, including the `[lang]` segment if the site uses one |
| Valid id | `^[A-Za-z0-9_-]{1,64}$` (ids issued today are 12 characters) |
| Invalid id | Don't call the API. Render the "unavailable" state with HTTP **404** |
| Rendering | Server-side (SSR or ISR), so link-preview crawlers get the meta tags without running JS |

## 4. Data

One public call, made from the server:

```
GET https://inkcalendar.app/api/ink/template-share/<id>/page
```

No App Check, no token and no special headers.

**200**

```json
{
  "success": true,
  "data": {
    "id": "A4k373Bks0Wo",
    "name": "Today's omen",
    "layout_kind": "stack",
    "preview_url": "https://inkcalendar.app/api/ink/template-share/assets/SBsZw51iL7Ef",
    "created_at": "2026-09-30T01:51:22.068Z",
    "lang": "en"
  }
}
```

| Field | Notes |
|---|---|
| `name` | **Typed by the sender.** Up to 80 characters, any language, may contain emoji. Treat it as untrusted text (§8). |
| `layout_kind` | One of `monthGrid`, `lunarMonth`, `weekAgenda`, `weekAndTodayEvents`, `reminderMatrix`, `stack`. Optional to show; if you do, map it to a friendly label (§6), never the raw value. |
| `preview_url` | A portrait JPEG, longest side 1080 px, roughly a phone screen's shape (about 9 : 19.5). **Can be `null`**, so show a placeholder then. Served with `Cache-Control: public, max-age=31536000, immutable`. |
| `created_at` | ISO 8601 UTC. Not needed on the page. |
| `lang` | The sender's app language (`en`, `vi`, `zh-Hant`…). Use it only as a hint (§7). |

**Errors**

| HTTP | Body | Page to show |
|---|---|---|
| 400 | `{"success":false,"error":"Invalid share id."}` | Unavailable, HTTP 404 |
| 404 | `{"success":false,"error":"Share not found."}` | Unavailable, HTTP 404 |
| 500 or network error | `{"success":false,"error":"Failed to read share."}` | Temporary error, HTTP 503, with a "Try again" link to the same URL |

A share returns 404 when its id never existed or its owner deleted their Ink account.
There's no "deleted" status, and 410 isn't used today, but treat 410 like 404 if it ever comes.

**Don't** call `GET /api/ink/template-share/<id>` (without `/page`). That route needs Firebase
App Check and is only for the app. The page needs nothing beyond `/page` and the preview image.

## 5. Caching

The **same id can change content**: when the sender edits the wallpaper and shares it again,
the link keeps its id and shows the new design. The preview gets a **new** `preview_url`
each time, so images can be cached forever, but the page data can't.

- Page data: revalidate every **60 seconds** or less (ISR `revalidate: 60`, or no cache).
- 404 pages: at most 60 seconds, so a link isn't stuck as "unavailable" for long.
- Preview image: load it straight from `preview_url`. It's already immutable and on
  `inkcalendar.app`. If the site proxies images through `next/image`, allow the
  `inkcalendar.app` host and the path `/api/ink/template-share/assets/**`.

## 6. Page content

### Found (200)

Top to bottom, mobile first. Most visitors are on an iPhone who tapped the link in a chat.

1. **Ink logo or name**, same header as the `/share/` page.
2. **Preview image** in a phone-shaped frame with rounded corners, about 60–70 % of the
   viewport height on mobile. Alt text: `Preview of the "<name>" lock screen`.
3. **Name** as the page heading (`<h1>`).
4. One line, e.g. "A lock screen design shared with Ink".
5. **Open in Ink**: the primary button, `href="ink://template?id=<id>"`.
6. **Get Ink on the App Store**: a secondary button or link to `https://apps.apple.com/app/id6769250805`.
7. A small hint under the buttons: "Don't have Ink yet? Install it, then tap Open in Ink again."

Optional layout labels, if you show one:

| `layout_kind` | Label |
|---|---|
| `monthGrid` | Month calendar |
| `lunarMonth` | Lunar calendar |
| `weekAgenda` | Week agenda |
| `weekAndTodayEvents` | Week and today |
| `reminderMatrix` | Reminders |
| `stack` | Custom layout |

### Unavailable (404)

- Heading: **Template unavailable**
- Text: "This template was removed, or the link is incomplete."
- Button: **Get Ink on the App Store**
- No preview and no Open in Ink button.

### Temporary error (503)

- Heading: **Couldn't load this template**
- Text: "Check your connection and try again."
- Link: **Try again**, to the same URL.

### Device behaviour

| Visitor | Behaviour |
|---|---|
| iPhone or iPad with Ink | Open in Ink opens the app on the shared template |
| iPhone or iPad without Ink | Safari shows "cannot open page" for `ink://`. That's why the App Store button and the hint are there. **Don't** auto-redirect to `ink://` on load, because it triggers that error dialog. |
| Android or desktop | Show the preview and name. Replace Open in Ink with a note, "Open this link on your iPhone", and keep the App Store link. A QR code of the page URL is a nice extra, not required. |

## 7. Language

- Use the same language logic as the `/share/` page (URL segment, `Accept-Language`, or whatever
  the site already does).
- The site's language decides the page's own text. The design's `name` is shown as written,
  never translated.
- If the visitor's language can't be decided, you may fall back to the share's `lang` when the
  site supports it, then English.
- Strings to add: every English string in §6 plus the meta description in §9. Vietnamese is
  the minimum besides English; the app ships 18 languages if the site wants to match.

## 8. Security and privacy

- `name` is user input: render it as text only. No `dangerouslySetInnerHTML`, and escape it in
  `<title>` and meta tags.
- Build the deeplink from the **validated** id only: `ink://template?id=${id}` after the regex
  check in §3. Never pass other query parameters through.
- Only show images whose URL starts with `https://inkcalendar.app/api/ink/template-share/assets/`.
  Treat anything else as no preview.
- Don't send the id, name or URL to analytics. A page-view event with the result
  (`found` / `not_found` / `error`) is fine.
- Every share is public by design. The page adds nothing the link doesn't already expose.

## 9. Meta tags (link previews)

Chats unfurl the link (iMessage, Zalo, Messenger, Facebook, Telegram), so these tags decide
what the recipient sees before they tap.

```html
<title>{name} · Ink</title>
<meta name="description" content="A lock screen design shared with Ink. Open it in Ink to add it to your collection.">
<meta name="robots" content="noindex, nofollow">
<link rel="canonical" href="https://inkcalendar.app/t/{id}">

<meta property="og:type" content="website">
<meta property="og:site_name" content="Ink">
<meta property="og:title" content="{name}">
<meta property="og:description" content="A lock screen design shared with Ink.">
<meta property="og:url" content="https://inkcalendar.app/t/{id}">
<meta property="og:image" content="{preview_url}">
<meta property="og:image:type" content="image/jpeg">
<meta property="og:image:alt" content="Preview of the {name} lock screen">

<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="{name}">
<meta name="twitter:image" content="{preview_url}">
```

- When `preview_url` is null, use the site's default Ink share image.
- The 404 page keeps `noindex` and uses the default image with the title "Template unavailable · Ink".
- Optional: `<meta name="apple-itunes-app" content="app-id=6769250805">` shows Safari's
  smart banner. It's harmless and not a universal link.

## 10. Test checklist

- [ ] `/t/A4k373Bks0Wo` shows the preview, the name and both buttons.
- [ ] iPhone with Ink (1.2.19 or a TestFlight build): **Open in Ink** opens the app on the
      "Shared template" screen for that id.
- [ ] iPhone without Ink: tapping Open in Ink shows Safari's error, and the App Store button works.
- [ ] `/t/doesnotexist` and `/t/bad%20id` return HTTP **404** with the unavailable page.
- [ ] Simulate an API failure: HTTP 503 with the temporary error page.
- [ ] A share whose `preview_url` is null shows the placeholder, with no broken image.
- [ ] A name with `<script>`, quotes and emoji renders as plain text, in the page and in `<title>`.
- [ ] Sender re-shares after an edit: the same URL shows the new preview within a minute.
- [ ] Paste the link into iMessage, Zalo and Messenger: the card shows the name and the preview.
- [ ] View source: `robots` is `noindex, nofollow`.
- [ ] Desktop and Android show the "open on your iPhone" note instead of Open in Ink.
- [ ] Vietnamese page text is correct.
- [ ] `/share/<id>` calendar share pages still work.

To get a fresh id: in Ink 1.2.19 or TestFlight, long-press a saved wallpaper → **Share** → Copy.

## 11. Out of scope

- An `apple-app-site-association` file, or any universal-link setup.
- Rendering the design from its JSON. The preview image is enough.
- Report, delete or "my links" screens. There's no backend for them yet.
- Any Worker change.

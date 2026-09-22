# inkcalendar API — Tài liệu tích hợp FE

Base URL (production): **`https://inkcalendar.app`**
Tất cả request/response đều `application/json; charset=utf-8`. CORS mở cho mọi origin (`*`), method `GET, POST, OPTIONS`.

Mọi response có field `success` (boolean). Lỗi luôn có dạng:

```json
{ "success": false, "error": "mô tả lỗi", "error_code": "...(tuỳ endpoint)", "detail": "...(tuỳ lỗi)" }
```

---

## 1) `POST /api/suggest-event` — Tách event từ câu chữ

Nhận một câu ngôn ngữ tự nhiên, trả về **tất cả** event tìm được.

### Request body

| Field | Bắt buộc | Mô tả |
|---|---|---|
| `message` | ✅ | Câu người dùng nhập. Tối đa **500 ký tự**. |
| `language` | ✅ | Mã ngôn ngữ BCP-47 (`vi`, `en`, `ja`, …) — quyết định ngôn ngữ của `event_name`. |
| `timezone` | ✅ | IANA timezone (`Asia/Ho_Chi_Minh`, `America/New_York`, …) để giải giờ/ngày tương đối. |

```json
{
  "message": "Today 2:00 PM Tidy up the house. Tomorrow 11:00 AM Plan next week. Friday 4:00 PM Online meeting.",
  "language": "en",
  "timezone": "Asia/Ho_Chi_Minh"
}
```

### Response `200`

```json
{
  "success": true,
  "input": "Today 2:00 PM ...",
  "language": "en",
  "timezone": "Asia/Ho_Chi_Minh",
  "events": [
    { "event_name": "Tidy up the house", "start_time": "2026-09-07T14:00:00+07:00", "end_time": "2026-09-07T15:00:00+07:00" },
    { "event_name": "Plan next week",    "start_time": "2026-09-08T11:00:00+07:00", "end_time": "2026-09-08T12:00:00+07:00" },
    { "event_name": "Online meeting",    "start_time": "2026-09-11T16:00:00+07:00", "end_time": "2026-09-11T17:00:00+07:00" }
  ]
}
```

**Lưu ý cho FE:**
- `events` là **mảng** (0..n phần tử). Không có event nào → `events: []`.
- `start_time` / `end_time`: ISO 8601 **kèm offset** của timezone truyền vào.
- Không suy được giờ → `start_time` và `end_time` = `null`.
- Không có giờ kết thúc → `end_time = start_time + 1 giờ`.
- `event_name` có thể `null` nếu không có tiêu đề.
- Tối đa 20 event / message.

### Lỗi

| HTTP | Khi nào | `error_code` |
|---|---|---|
| `400` | Thiếu field / `message` quá dài / timezone không hợp lệ / AI trả sai chuẩn | `ai_invalid_format` (với lỗi AI) |
| `502` | GPT API lỗi/timeout | `ai_error` |

---

## 2) `POST /api/share` — Lưu payload, lấy link chia sẻ

Gửi **bất kỳ JSON hợp lệ, khác rỗng**. Server lưu vào DB và trả về link để đọc lại.

### Request body

Bất kỳ JSON hợp lệ. **Bị coi là rỗng (→ `400`)**: `null`, `""`, `[]`, `{}`.
Giới hạn kích thước: **256 KB**.

Ví dụ (thường là kết quả từ `/api/suggest-event`):

```json
{
  "events": [
    { "event_name": "Online meeting", "start_time": "2026-09-11T16:00:00+07:00", "end_time": "2026-09-11T17:00:00+07:00" }
  ]
}
```

### Response `201`

```json
{
  "success": true,
  "id": "9fK2aQ7bZ0xL4mNpR8sT1uVw",
  "url": "https://inkcalendar.app/api/share/9fK2aQ7bZ0xL4mNpR8sT1uVw",
  "created_at": "2026-09-07T09:00:00.000Z"
}
```

- `id`: 24 ký tự base62, URL-safe.
- `url`: dùng trực tiếp làm link chia sẻ / để gọi GET bên dưới.
- `created_at`: ISO 8601 UTC.

### Lỗi

| HTTP | Khi nào |
|---|---|
| `400` | Body rỗng / không phải JSON hợp lệ / JSON rỗng / quá 256 KB |
| `500` | Lỗi lưu DB |

---

## 3) `GET /api/share/:id` — Đọc lại payload đã share

```
GET https://inkcalendar.app/api/share/9fK2aQ7bZ0xL4mNpR8sT1uVw
```

### Response `200`

```json
{
  "success": true,
  "id": "9fK2aQ7bZ0xL4mNpR8sT1uVw",
  "data": {
    "events": [
      { "event_name": "Online meeting", "start_time": "2026-09-11T16:00:00+07:00", "end_time": "2026-09-11T17:00:00+07:00" }
    ]
  },
  "created_at": "2026-09-07T09:00:00.000Z"
}
```

- `data`: **đúng payload** bạn đã gửi ở bước POST (đã parse lại thành object/array).

### Lỗi

| HTTP | Khi nào |
|---|---|
| `404` | `id` không tồn tại |
| `500` | Lỗi đọc DB |

---

## Ví dụ tích hợp (JavaScript / fetch)

```js
const BASE = "https://inkcalendar.app";

// 1) Tách event từ câu chữ
async function suggestEvents(message, language, timezone) {
  const res = await fetch(`${BASE}/api/suggest-event`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ message, language, timezone }),
  });
  const json = await res.json();
  if (!json.success) throw new Error(json.error);
  return json.events; // Array<{ event_name, start_time, end_time }>
}

// 2) Tạo link chia sẻ
async function createShare(data) {
  const res = await fetch(`${BASE}/api/share`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data),
  });
  const json = await res.json();
  if (!json.success) throw new Error(json.error);
  return json; // { id, url, created_at }
}

// 3) Đọc lại theo id
async function getShare(id) {
  const res = await fetch(`${BASE}/api/share/${encodeURIComponent(id)}`);
  if (res.status === 404) return null;
  const json = await res.json();
  if (!json.success) throw new Error(json.error);
  return json.data;
}

// Luồng đầy đủ
const events = await suggestEvents(
  "9h họp team, 2h chiều gặp khách",
  "vi",
  "Asia/Ho_Chi_Minh",
);
const { url } = await createShare({ events });
console.log("Share link:", url);
```

## Ví dụ curl

```bash
# suggest
curl -X POST https://inkcalendar.app/api/suggest-event \
  -H 'Content-Type: application/json' \
  -d '{"message":"9h họp team, mai 8h đi khám","language":"vi","timezone":"Asia/Ho_Chi_Minh"}'

# share (tạo)
curl -X POST https://inkcalendar.app/api/share \
  -H 'Content-Type: application/json' \
  -d '{"events":[{"event_name":"Online meeting"}]}'

# share (đọc lại) — thay <id>
curl https://inkcalendar.app/api/share/<id>
```

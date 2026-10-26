# Thiết lập đẩy bug lên GitHub issue — dự án CACK

> Skill: [`github-issue-bug`](../../.claude/skills/github-issue-bug/SKILL.md) · Script: `scripts/create-bug-issue.sh`,
> `scripts/sync-bug-status.sh` · Cấu hình: [`scripts/bug-issue.conf`](../../scripts/bug-issue.conf) ·
> Issue form: [`.github/ISSUE_TEMPLATE/qc-bug.yml`](../../.github/ISSUE_TEMPLATE/qc-bug.yml).
> Hướng dẫn chi tiết đầy đủ (cơ chế script, xử lý lỗi) từ dự án cũ:
> `3ada18a:docs/guides/bug-issue-automation-setup.md` (`git show 3ada18a:docs/guides/bug-issue-automation-setup.md`) —
> phần cơ chế vẫn đúng, chỉ khác repo đích và tên field.

## 1. Repo nhận issue

Dự án CACK dùng luôn repo QC `nhatanh410/cack_qc` để nhận issue (chưa có repo source riêng của dev).

> ⚠️ **Repo đang PUBLIC (2026-10-26).** Hệ thống xử lý dữ liệu cá nhân và nghiệp vụ Công an — nên chuyển repo
> sang private **trước** khi push tài liệu hoặc tạo issue thật:
> GitHub → Settings → General → Danger Zone → Change repository visibility.

## 2. Việc cần làm một lần (do người có quyền admin repo thực hiện)

1. `gh auth login` (đã đăng nhập sẵn tài khoản `nhatanh410` trên máy này — kiểm tra bằng `gh auth status`).
2. Commit + push `.github/ISSUE_TEMPLATE/qc-bug.yml` lên nhánh `main` để form xuất hiện trên GitHub.
3. Tạo 2 label mà form và script dùng:
   ```bash
   gh label create qc-bug       -R nhatanh410/cack_qc --color d73a4a --description "Bug do QC báo"
   gh label create needs-triage -R nhatanh410/cack_qc --color fbca04 --description "Chờ dev phân loại"
   ```
4. Mời dev vào repo (Settings → Collaborators) để họ xem và nhận thông báo issue.

## 3. Dùng hằng ngày

1. Nói với Claude "log bug …" → skill soạn bản nháp → bạn duyệt → ghi vào `bugs/bug-log.md`.
2. Muốn đẩy lên GitHub: Claude hỏi 4 field (Phiên bản, Nền tảng, Thiết bị / Trình duyệt, Tần suất) → chạy dry-run:
   ```bash
   scripts/create-bug-issue.sh BUG-001 --build "<phiên bản>" --install "App mobile" \
     --device "iPhone 13, iOS 17.5" --frequency "Luôn luôn" [--lang "Cán bộ"]
   ```
3. Xem body → xác nhận rõ → chạy lại với `--submit`. Script ghi URL issue vào bug-log.
4. Đồng bộ trạng thái khi dev đóng issue: `scripts/sync-bug-status.sh` (xem đề xuất) → `--write`.

## 4. Thay đổi so với dự án Ink

| Field form | Ink | CACK |
|---|---|---|
| Build | Build | **Phiên bản** |
| Bản cài (TestFlight/App Store…) | Bản cài | **Nền tảng**: `App mobile` · `Web quản trị` |
| Thiết bị và iOS | Thiết bị và iOS | **Thiết bị / Trình duyệt** |
| Ngôn ngữ app (tuỳ chọn) | Ngôn ngữ app | **Vai trò tài khoản** (đọc dòng `Account role` trong bug-log) |
| Ngôn ngữ báo cáo | Tiếng Anh | **Tiếng Việt** |

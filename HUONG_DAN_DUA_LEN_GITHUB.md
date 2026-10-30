# Đưa bộ F01 lên GitHub

Repo đích: https://github.com/vietquang1672006/F01_Den_giao_thong_24101108

## Cách tải file bằng trình duyệt

1. Giải nén gói ZIP mới. Mở thư mục `F01_DUA_LEN_GITHUB`.
2. Mở repo, bấm **Upload files** hoặc **Add file → Upload files**.
3. Kéo toàn bộ nội dung bên trong `F01_DUA_LEN_GITHUB` vào vùng upload. `README.md`, `.github`, `04_IMPLEMENTATION`, `05_VERIFICATION`, `06_GDSII`, `07_TRACEABILITY`, `08_ORIGINAL_SOURCE`, `docs`, `Makefile`, `.gitignore` và file hướng dẫn này phải ở ngay cấp đầu của repo.
4. Ghi thông điệp commit đúng nội dung, ví dụ `Thêm mã nguồn và ảnh minh chứng F01`.
5. Bấm **Commit changes** và quay về tab **Code**. README sẽ có bảng mục lục và ảnh trực tiếp; mở `docs/minh_chung/README.md` để xem toàn bộ ảnh có giải thích.

Nếu repo đã có nội dung, tải bản cập nhật lên đúng đường dẫn để thay các file thay đổi; kiểm lại diff trước khi commit. Thư mục `.github` có dấu chấm đầu tên; trên trình quản lý file Linux dùng Ctrl+H nếu cần hiển thị.

## Bổ sung log mới từ máy Ubuntu của sinh viên

Gói này đã có ảnh sinh viên gửi và dữ liệu tham chiếu ngày 28/10. Để repo phản ánh lần chạy mới nhất của mình, trên Ubuntu ở `~/F01` chạy:

```bash
explorer.exe .
```

Copy các file kết quả mới từ `05_VERIFICATION/logs`, `waveforms`, `traces`, `06_GDSII/synthesis`, `06_GDSII/physical`, cùng thông tin `07_TRACEABILITY` và cấu hình mình đã dùng, rồi cập nhật chúng trên GitHub. Giữ các ảnh và mục lục của gói mới; không thay toàn bộ bằng README cũ.

Không đưa AppImage, PDK hoặc toàn bộ thư mục `04_IMPLEMENTATION/scripts/runs` lên bằng thao tác tải file thông thường. Chọn báo cáo/log/metrics và các sản phẩm bàn giao cần thiết từ run; giữ đầy đủ run tại máy để có thể kiểm tra khi cần.

## Chạy CI và lấy link cho báo cáo

- Workflow đặt đúng tại `.github/workflows/verify.yml`.
- Mở **Actions → F01 RTL and synthesis**. Workflow chạy khi push hoặc có thể bấm **Run workflow**.
- Mở một lần chạy cụ thể, kiểm từng bước và tải artifact **F01-evidence**.
- Workflow cơ bản kiểm RTL/SAT/tổng hợp và lưu chẩn đoán vật lý. Nó không tự cài bộ LibreLane/PDK và không chứng minh flow vật lý đã hoàn tất.
- Ghi URL repo và URL run cụ thể vào báo cáo và `07_TRACEABILITY/links.json`.

Bản báo cáo 14 trang đi kèm vẫn là bản ngày 28/10; cần cập nhật repo/CI và tiến độ CTS để chốt bản nộp. Trạng thái mới nhất hiện được ghi trong README và `docs/CHAN_DOAN_FLOW.md`.

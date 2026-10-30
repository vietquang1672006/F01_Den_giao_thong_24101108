# Nguồn và thời điểm của bằng chứng

[Quay lại trang chính](../README.md)

## Dữ liệu tham chiếu ngày 28 tháng 10 năm 2026

Các log, vector, VCD, CSV và netlist có sẵn trong gói được tạo ở lần chạy Ubuntu 24.04.3 LTS, Python 3.12.14, Icarus Verilog 12.0 và Yosys 0.33. Nguồn mã và bằng chứng thuộc commit `6dca91d1a0f2429bcc04390b00eeb04c6aa68f82`.

Kết quả: 6.296 vector thuộc sáu cấu hình PASS; SAT SUCCESS; tổng hợp 53 cell tổng quát và 6 FF, state 2 bit; thử vật lý dừng trước flow vì thiếu module LibreLane.

Bản Word/PDF 14 trang kèm theo phản ánh mốc này. Nó chưa cập nhật URL repo/CI và tiến độ CTS ngày 30/10; cần cập nhật trước khi dùng làm bản báo cáo cuối để nộp.

## Ảnh trên máy sinh viên ngày 30 tháng 10 năm 2026

Các ảnh trong `docs/minh_chung` được sinh viên cung cấp và giữ nguyên byte ảnh. Tên tệp gốc và SHA-256 nằm trong `evidence_manifest.json`.

Đã quan sát được: dự án được khôi phục trong Ubuntu; dạng sóng GTKWave; bảng có 6 FF; SAT SUCCESS; lỗi thiếu môi trường ban đầu; flow sau khi bổ sung môi trường đi tới CTS và lỗi DPL-0036.

Chưa nhận được các file raw mới trên máy sinh viên. Vì vậy, không gán các log ngày 28/10 thành log của lần chạy 30/10; chưa xác nhận tổng cell/diện tích/timing/power hoặc GDS của lần chạy mới.

## GitHub và cấu hình thử

Repo đã được sinh viên tạo: https://github.com/vietquang1672006/F01_Den_giao_thong_24101108

Chưa nhận được URL một GitHub Actions run cụ thể. Tab Actions trong README chỉ là đường dẫn điều hướng, không thay cho link CI run trong báo cáo.

Cấu hình giảm FP_CORE_UTIL xuống 20 và đặt PL_TARGET_DENSITY_PCT = 50 mới là phương án thử khắc phục CTS; chưa được xác nhận chạy đạt.

## Lịch sử Git

Các commit trong bundle gốc là các thay đổi thực của quá trình chuẩn bị mã/tài liệu bởi Codex Assistant. Chúng không được trình bày như lịch sử học tập trước đó của sinh viên. Khi tự chạy và chỉnh sửa trên máy, sinh viên cần commit kết quả thực tế của mình.

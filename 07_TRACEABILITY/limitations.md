# Phạm vi bằng chứng

- RTL `_explicit` của gói thầy được giữ nguyên hành vi. Wrapper, vector, kiểm thử, workflow và script chạy là phần bổ sung.
- Mốc nguồn mã và kết quả: commit `6dca91d1a0f2429bcc04390b00eeb04c6aa68f82`. Tài liệu và đường dẫn được bổ sung trong commit sau; SHA tài liệu không làm thay đổi nội dung bằng chứng được dẫn.
- Mô phỏng, SAT và tổng hợp đã chạy cục bộ; CI GitHub chưa chạy khi đóng gói.
- Số cell/FF là cell logic tổng quát của Yosys 0.33, không phải standard cell SKY130 hoặc số cell sau layout.
- Lỗi `No module named librelane` xảy ra trước khi đọc thiết kế. `environment.json` cũng cho thấy thiếu PDK và công cụ vật lý. Không có cơ sở kết luận RTL gây lỗi P&R.
- Bằng chứng an toàn chỉ cho logic ổn định; chưa kiểm glitch, metastability hoặc tủ đèn thực.
- `08_ORIGINAL_SOURCE` là bản tham chiếu, không chạy bằng các script mới. Log PASS gốc không được dùng thay log mới.
- Không giả tạo URL, run ID, PDK commit, số timing, power, DRC/LVS hoặc ảnh layout.
- Lịch sử các commit là hoạt động chuẩn bị trong phiên hiện tại, không phải bằng chứng quá trình học trước đó của sinh viên. Sinh viên cần đọc và hiểu các thay đổi trước khi trình bày.

## Cập nhật bằng chứng ngày 30 tháng 10 năm 2026

Ảnh sinh viên cung cấp xác nhận SAT SUCCESS, bảng có 6 FF và flow đi tới CTS rồi lỗi DPL-0036. Vì vậy, thông tin thiếu LibreLane ở các log tham chiếu 28/10 không phải trạng thái mới nhất của máy sinh viên. Xem `NGUON_KET_QUA.md`, `evidence_manifest.json` và `docs/CHAN_DOAN_FLOW.md`. Chưa nhận được file raw mới hoặc URL một CI run; chưa có kết quả chạy lại xác nhận cấu hình floorplan thử đã khắc phục được CTS.

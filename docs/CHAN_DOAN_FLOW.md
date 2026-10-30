# Chẩn đoán flow vật lý F01

[Trang chính](../README.md) · [Ảnh minh chứng](minh_chung/README.md)

## Các lần thử được quan sát

| Lần thử | Kết quả | Bằng chứng |
|---|---|---|
| Môi trường ban đầu | `/usr/bin/python3: No module named librelane`, mã thoát 1. | [Ảnh lỗi môi trường](minh_chung/05_loi_thieu_librelane.png) |
| Sau khi vào môi trường LibreLane | Đi tới CTS rồi lỗi `[DPL-0036] Detailed placement failed`. | [Ảnh CTS](minh_chung/06_flow_dung_o_cts_dpl0036.png) |
| Cấu hình thử giảm utilization | Đề xuất FP_CORE_UTIL = 20 và PL_TARGET_DENSITY_PCT = 50. | [Cấu hình thử](../04_IMPLEMENTATION/scripts/config_librelane_retry.json); chưa có kết quả xác nhận. |

## Lỗi CTS được ghi trong ảnh

Đoạn trích sau là chép lại phần nhìn thấy trong ảnh, không phải bản log gốc đầy đủ:

```text
[INFO DPL-0034] Detailed placement failed on the following 3 instances:
[INFO DPL-0035] _26_
[INFO DPL-0035] _26_
[INFO DPL-0035] _38_
[DPL-0036] Detailed placement failed.
Error: cts.tcl, 102 DPL-0036
OpenROAD.CTS failed
```

Ảnh cũng ghi cảnh báo mật độ `[GPL-0302]`, thư viện đã tồn tại `[STA-1140]` và 2 floating nets `[RSZ-0020]`. Nguyên nhân khiến flow dừng được ghi trực tiếp là legalization trong CTS thất bại. Không tự quy tất cả cảnh báo thành cùng một lỗi.

Đường dẫn run được nhìn thấy:

```text
/home/Quang/F01/04_IMPLEMENTATION/scripts/runs/RUN_2026-10-30_11-48-00/
```

PDK hash xuất hiện trong đường dẫn thư viện của ảnh:

```text
8afc8346a57fe1ab7934ba5a6056ea8b43078e71
```

Đây là thông tin đọc từ ảnh. Chưa nhận được toàn bộ thư mục run, cấu hình đã resolve, metrics hoặc bản log đầy đủ trên máy sinh viên để đối chiếu.

## Hướng thử khắc phục

Một khả năng là floorplan của lõi nhỏ không đủ thuận lợi cho legalization sau khi chèn cell CTS. Giảm utilization trong chế độ relative giúp tăng diện tích core; cần chạy lại mới kiểm tra được giả thuyết này.

Cấu hình gốc vẫn ở `config_librelane.json`; cấu hình thử ở `config_librelane_retry.json`. Nếu chạy thử trong môi trường LibreLane từ thư mục gốc repo:

```bash
librelane 04_IMPLEMENTATION/scripts/config_librelane_retry.json
```

Chưa có bằng chứng lần chạy với cấu hình thử đã qua CTS hoặc tạo GDS. Giữ nguyên các kiểm tra DRC/LVS trong flow; không bỏ kiểm tra để tạo kết quả đạt giả.

## Sản phẩm còn cần bổ sung từ máy sinh viên

- Log đầy đủ của run mới nhất và cấu hình đã resolve.
- Báo cáo tổng hợp ánh xạ SKY130, STA và metrics ở bước đã chạy tới.
- Thống kê CTS, buffer, skew khi có kết quả hợp lệ.
- Kết quả routing, DRC/LVS và layout/GDS nếu flow hoàn tất.

Các log tại `06_GDSII/physical/flow.log` và `environment.json` có sẵn trong gói là dữ liệu tham chiếu 28/10, khi môi trường soạn gói chưa có LibreLane. Ảnh ngày 30/10 thể hiện tiến độ mới hơn trên máy sinh viên; không ghi đè log tham chiếu bằng văn bản chép từ ảnh.

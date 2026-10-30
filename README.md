# F01 FSM đèn giao thông hai chiều có đèn vàng

**Đặng Việt Quang · MSSV 24101108 · Lớp N01**  
EEE703128 · Nhập môn Thiết kế Vi mạch Tích hợp · GVHD Đinh Văn Nam

Thiết kế điều khiển hai hướng giao thông theo bốn pha và chuyển sang nhấp nháy vàng ban đêm. Trang này tập hợp mã nguồn, kiểm thử, ảnh minh chứng, netlist và hướng dẫn chạy trên Ubuntu.

## Mục lục xem nhanh

| Phần | Bấm để mở |
|---|---|
| Toàn bộ ảnh minh chứng và giải thích | [Mở trang minh chứng](docs/minh_chung/README.md) |
| Code lõi FSM | [f01_traffic_fsm_explicit.sv](04_IMPLEMENTATION/rtl/f01_traffic_fsm_explicit.sv) |
| Wrapper ánh xạ chân | [tt_um_f01.sv](04_IMPLEMENTATION/rtl/tt_um_f01.sv) |
| Testbench | [f01_tb.sv](05_VERIFICATION/testbench/f01_tb.sv) |
| Mô hình chuẩn và sinh vector | [check_model.py](05_VERIFICATION/golden_model/check_model.py) |
| Log kiểm thử và SAT | [Mở thư mục logs](05_VERIFICATION/logs/) |
| Dạng sóng và trace | [VCD](05_VERIFICATION/waveforms/) · [CSV](05_VERIFICATION/traces/) |
| Thống kê FF và netlist tham chiếu | [synth_stat.txt](06_GDSII/synthesis/synth_stat.txt) · [summary.json](06_GDSII/synthesis/summary.json) · [netlist.v](06_GDSII/synthesis/netlist.v) |
| Flow vật lý và chẩn đoán lỗi CTS | [Mở chẩn đoán](docs/CHAN_DOAN_FLOW.md) |
| Sơ đồ khối và FSM | [Sơ đồ khối](docs/figures/block.png) · [Sơ đồ trạng thái](docs/figures/fsm.png) |
| Báo cáo 14 trang bản ngày 28 tháng 10 | [PDF](docs/Bao_cao_F01_14_trang.pdf) · [Word](docs/Bao_cao_F01_14_trang.docx) |
| Yêu cầu của giảng viên | [Charter F01](docs/charter_F01.html) |
| Thông tin tái lập và nguồn bằng chứng | [Nguồn kết quả](07_TRACEABILITY/NGUON_KET_QUA.md) |
| Đưa file lên GitHub | [Hướng dẫn](HUONG_DAN_DUA_LEN_GITHUB.md) |

## Trạng thái cập nhật ngày 30 tháng 10 năm 2026

| Hạng mục | Bằng chứng đang có | Giới hạn |
|---|---|---|
| Mô phỏng trên Ubuntu của sinh viên | [Ảnh GTKWave 0-700 ns](docs/minh_chung/02_waveform_gtkwave_0_700ns.png) | Ảnh quan sát không thay thế log của toàn bộ ca kiểm thử. |
| Flip-flop | [Ảnh thống kê có 6 FF](docs/minh_chung/04_sat_success_va_6_ff.png) | Tổng số cell của lần chạy mới chưa được xác nhận từ báo cáo đầy đủ gửi lại. |
| Tính chất không cùng xanh | [SAT SUCCESS](docs/minh_chung/04_sat_success_va_6_ff.png) | Áp dụng mô hình logic ổn định; không đánh giá glitch vật lý. |
| Flow vật lý | [Đã đi tới CTS, lỗi DPL-0036](docs/minh_chung/06_flow_dung_o_cts_dpl0036.png) | Chưa xác nhận hoàn tất routing, GDS hoặc các kiểm tra cuối. |
| GitHub Actions | [Workflow](.github/workflows/verify.yml) · [Tab Actions](https://github.com/vietquang1672006/F01_Den_giao_thong_24101108/actions) | Chưa nhận URL một lần chạy cụ thể để dẫn trong báo cáo. |

**Phân biệt nguồn dữ liệu:** log/VCD/netlist có sẵn trong gói thuộc lần chạy tham chiếu 28/10/2026; ảnh trong `docs/minh_chung` do sinh viên cung cấp ngày 30/10/2026. Cần cập nhật các file kết quả bằng bản trên máy sinh viên sau khi chạy; không coi các log tham chiếu là log mới ngày 30/10. Báo cáo PDF/Word hiện là bản 14 trang ngày 28/10, còn cần cập nhật repo/CI và tiến độ CTS; thông tin mới nhất ở trang này và trang chẩn đoán.

## Hai ảnh minh chứng chính

### Dạng sóng trên Ubuntu

![Dạng sóng thực tế 0-700 ns trên GTKWave](docs/minh_chung/02_waveform_gtkwave_0_700ns.png)

### SAT đạt và bảng có 6 flip-flop

![SAT SUCCESS và 6 flip-flop](docs/minh_chung/04_sat_success_va_6_ff.png)

## Chạy trên Ubuntu hoặc WSL Ubuntu

```bash
sudo apt update
sudo apt install -y iverilog yosys python3 git gtkwave
bash 04_IMPLEMENTATION/scripts/run_all.sh
```

Từ thư mục gốc repo, xem dạng sóng:

```bash
gtkwave 05_VERIFICATION/waveforms/p4_n2.vcd
```

Các lệnh riêng: `make sim`, `make synth`, `make physical`. Mô hình và testbench không cần Python package bên ngoài. Hai hình minh họa trong `docs/figures` đã được tạo từ trace RTL, không cần cài matplotlib để chạy kiểm thử.

## Kết quả chạy tham chiếu ngày 28 tháng 10 năm 2026

| Bước | Kết quả | Bằng chứng |
|---|---|---|
| RTL và wrapper | 6.296 vector, 6 cấu hình PASS | `05_VERIFICATION/logs/` |
| Cấu hình mặc định | 2.862 vector; bao phủ 28 trạng thái mở rộng và 224 cạnh | `vectors/summary.json` |
| SAT an toàn | SUCCESS cho hai hướng không cùng xanh ở logic ổn định | `logs/safety_sat.log` |
| Tổng hợp Yosys 0.33 | 53 cell tổng quát; 6 FF; state giữ 2 bit; không latch | `06_GDSII/synthesis/` |
| LibreLane | Chưa khởi động flow: thiếu module và môi trường PDK | `06_GDSII/physical/` |
| GitHub CI | Chưa nhận được URL một run cụ thể | `.github/workflows/verify.yml` đã chuẩn bị |

Không dùng số cell tổng quát để suy ra diện tích SKY130. Chưa có STA/power/CTS/DRC/LVS/GDS từ lần chạy này. Script giữ nguyên log và mã thoát của lần thử vật lý; workflow xanh xác nhận RTL/SAT/tổng hợp và việc lưu chẩn đoán, không chứng nhận physical flow đạt.

## Các file mã nguồn và kết quả tham chiếu

- Mã lõi: `04_IMPLEMENTATION/rtl/f01_traffic_fsm_explicit.sv`.
- Wrapper Tiny Tapeout: `04_IMPLEMENTATION/rtl/tt_um_f01.sv`; `uio_in[0]` là chế độ đêm, `uio_oe = 0`.
- Mô hình: `05_VERIFICATION/golden_model/check_model.py`.
- Testbench: `05_VERIFICATION/testbench/f01_tb.sv`.
- Sản phẩm mô phỏng: `05_VERIFICATION/waveforms`, `traces`, `logs`.
- Netlist: `06_GDSII/synthesis/netlist.v`, `netlist.json`.
- Kết quả FF: `synth_stat.txt`, `summary.json`; tìm `FSM_DETECT` trong `yosys.log`.
- Báo cáo: `docs/Bao_cao_F01_14_trang.pdf`, `.docx` và bản Markdown.
- Hướng dẫn thầy: `docs/charter_F01.html`; nguồn gốc được giữ tại `08_ORIGINAL_SOURCE`.

![FSM](docs/figures/fsm.png)

![Dạng sóng RTL](docs/figures/wave_night.png)


## Nội dung kiểm thử

- Hai vòng đủ bốn pha; vào đêm giữa chừng; trở lại pha cũ.
- Kiểm loại trừ hai đèn xanh.
- Sáu cấu hình (P,N): (1,1), (2,2), (3,3), (4,2), (5,3), (8,4).
- Ca biên P = N = 1; P không là lũy thừa 2; enable; reset đồng bộ và reset khi enable = 0.
- 600 vector giả ngẫu nhiên mỗi cấu hình với seed cố định.
- Cấu hình mặc định phát lại mọi cạnh reachable của (state, pc, nc, night_phase).
- Wrapper Tiny Tapeout được đối chiếu cùng lõi.

## Cách hiểu kết quả vật lý

Lỗi mới nhất được quan sát là `DPL-0036` tại CTS. Một cấu hình giảm utilization xuống 20% đã được đề xuất; chưa nhận được kết quả chạy lại. [config_librelane_retry.json](04_IMPLEMENTATION/scripts/config_librelane_retry.json) chỉ là cấu hình thử, không phải cấu hình đã chạy đạt.

Số 53 cell/6 FF trong log tham chiếu là ánh xạ logic tổng quát của Yosys 0.33, không phải standard cell SKY130 hay số cell sau layout. Không dùng số đó để suy ra diện tích, timing hoặc công suất vật lý.

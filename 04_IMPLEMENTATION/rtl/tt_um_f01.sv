module tt_um_f01 #(parameter integer PHASE_TICKS=4, NIGHT_TICKS=2)(
 input wire [7:0] ui_in, output wire [7:0] uo_out,
 input wire [7:0] uio_in, output wire [7:0] uio_out, uio_oe,
 input wire ena, clk, rst_n
);
 assign uio_out=8'b0;
 assign uio_oe=8'b0;
 f01_traffic_fsm_explicit #(.PHASE_TICKS(PHASE_TICKS),.NIGHT_TICKS(NIGHT_TICKS)) core(
 .clk(clk),.rst_n(rst_n),.ena(ena),.night_mode(uio_in[0]),.uo_out(uo_out));
endmodule

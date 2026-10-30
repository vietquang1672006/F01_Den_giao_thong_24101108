module f01_safety(input clk,rst_n,ena,night_mode,output safe);
 wire [7:0] lamps;
 f01_traffic_fsm_explicit dut(.clk(clk),.rst_n(rst_n),.ena(ena),.night_mode(night_mode),.uo_out(lamps));
 assign safe=!(lamps[0] && lamps[3]);
endmodule

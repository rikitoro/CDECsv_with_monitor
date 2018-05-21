
module monitor (
	clk_clk,
	reset_reset_n,
	prg_rd_export,
	prg_wd_export,
	prg_ma_export,
	prg_clock_export,
	prg_we_export,
	uart_0_rxd,
	uart_0_txd);	

	input		clk_clk;
	input		reset_reset_n;
	input	[7:0]	prg_rd_export;
	output	[7:0]	prg_wd_export;
	output	[7:0]	prg_ma_export;
	output		prg_clock_export;
	output		prg_we_export;
	input		uart_0_rxd;
	output		uart_0_txd;
endmodule

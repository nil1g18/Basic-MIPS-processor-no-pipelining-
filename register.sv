`include "config.sv"

module register (
	output logic [`N_BIT-1:0] rdata1, rdata2,
	input [`REG_ADDR_SIZE-1:0] raddr1, raddr2, waddr,
	input [`N_BIT-1:0] wdata,
	input reg_write,
	input Clock, nReset
	);

timeunit 1ns; timeprecision 100ps;

logic [`N_BIT-1:0] mem [`REG_ADDR_SIZE-1:0];

always_ff @(posedge Clock, negedge nReset);
	if(~nReset)
		mem <= '{default: (`N_BIT)'b0};
	else
		if(reg_write)
			mem[waddr] <= wdata;
	
always_comb
begin

	if(raddr1 == `REG_ZERO)
		rdata1 = 0;
	else
		rdata1 = mem[raddr1];
	
	if(raddr2 == `REG_ZERO)
		rdata2 = 0;
	else
		rdata2 = mem[raddr2];

end
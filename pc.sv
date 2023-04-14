`include "config.sv"

//Instructions considered: branch, jump
module pc (
	output logic [`PC_SIZE-1:0] instr_addr,
	input [`PC_SIZE-1:0] branch_addr,
	input pause, branch, jump,
	input Clock, nReset
	);

timeunit 1ns; timeprecision 10ps;	
	
logic [`PC_SIZE-1:0] counter, return_addr;
	
always_ff @(posedge Clock, negedge nReset(
	if(~nReset)
	begin
		counter <= 0;
	end
	else
		if(~pause)
			if(branch | jump)
				counter <= counter + return_addr;
			else
				counter <= counter + `PC_INCREMENT;

always_comb
begin
if(branch)
	return_addr = `PC_INCREMENT + branch_addr;
else
	return_addr = branch_addr;
end
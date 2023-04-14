`include "config.sv"

//operations
/*
add, sub: 

beq,bne:sub  and zero

greater, less than,: sub and negative


*/

module alu (
	output logic signed [`N_BIT:0] out,
	output logic alu_flag [3],
	input logic signed [`N_BIT-1:0] A, B,
	input [`ALU_FUNC_SIZE-1:0] alu_func
	);
	
timeunit 1ns; timeprecision 10ps;

logic signed [`N_BIT-1:0] B2s;

//2's complement
always_comb
begin
	if(`ALU_SUB)
		B2s = ~B + 1'b1;
	else
		B2s = B;
end
	
//functions		
always_comb
begin
	case(alu_func)
	`ALU_ADD, `ALU_SUB: out = A + B2s;
	
	`ALU_OP1 : out = A;
	`ALU_OP2: out = B;
	
	default: out = 0;
	endcase
end

//flags
always_comb
begin
//Zero
	alu_flag[0] = (out == 0);
	
//Negative (Cout?)
	alu_flag[1] = out[`N_BIT];

//Overflow
	// A + B
	// When A and B are positive but out is negative
	// When A and B are negative but out is positive
	alu_flag[2] = (A[`N_BIT-1] & B[`N_BIT-1] & ~out[`N_BIT-1]) | (~A[`N_BIT-1] & ~B[`N_BIT-1] & out[`N_BIT-1]);

end

endmodule
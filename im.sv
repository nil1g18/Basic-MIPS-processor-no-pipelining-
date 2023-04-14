`include "config.sv"

/*
Instruction format
R: add,sub,mul
	[OPCODE][$r1][$r2][$r3][shamt][func]
	6 5 5 5 5 6 
		
I: addi,lw,sw,beq,bne
	[OPCODE][$r1][$r2][Immediate N_bit(16)]

	6 5 5 16

J: j
	[OPCODE][ADDRESS]
	6 26
	
*/

//Making this program memory module ROM, cuz im lazy

module im (
	output logic [`INSTR_SIZE-1:0] instr_out,
	input [`PC_SIZE-1:0] addr,
	);
	
timeunit 1ns; timeprecision 10ps;		
	
logic [`INSTR_SIZE-1:0] prog_mem [(1<<`PC_SIZE)-1:0];
	
initial
	$readmemh("im.hex", prog_mem);
	
always_comb
	instr_out = prog_mem[addr];
	
endmodule
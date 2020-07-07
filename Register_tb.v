`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/06 20:42:50
// Design Name: 
// Module Name: Register_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Register_tb;

reg clock;
reg reset;
reg regWriteE;
reg regWriteM;
reg [3:0] readRegA;
reg [3:0] readRegB;
reg [3:0] writeRegE;
reg [3:0] writeRegM;
reg [63:0] writeDataE;
reg [63:0] writeDataM;
wire [63:0] readDataA;
wire [63:0] readDataB;

Register Reg(
    .clock(clock),
    .reset(reset),
    .regWriteE(regWriteE),
    .regWriteM(regWriteM),
    .readRegA(readRegA),
    .readRegB(readRegB),
    .writeRegE(writeRegE),
    .writeRegM(writeRegM),
    .writeDataE(writeDataE),
    .writeDataM(writeDataM),
    .readDataA(readDataA),
    .readDataB(readDataB)
    );

always #50 clock=~clock;

initial begin
	 reset=1;
     clock=1;
     readRegA=0;
     readRegB=0;
     writeRegE=0;
     writeRegM=0;
     writeDataE=0;
     writeDataM=0;
	#100;
	assign reset=0;
	#100
    assign writeRegE=1;
    assign regWriteE=1;
    assign writeDataE=64'h8c0f000b;
    #200
    assign readRegA=1;
    assign readRegB=1;
end


endmodule
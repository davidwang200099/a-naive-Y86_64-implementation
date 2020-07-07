`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/06 20:39:37
// Design Name: 
// Module Name: Register
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


module Register(
    input clock,
    input reset,
    input regWriteE,
    input regWriteM,
    input [3:0] readRegA,
    input [3:0] readRegB,
    input [3:0] writeRegE,
    input [3:0] writeRegM,
    input [63:0] writeDataE,
    input [63:0] writeDataM,
    output reg [63:0] readDataA,
    output reg [63:0] readDataB
    );

reg [63:0] regFile[0:14];
integer i;

always @ (readRegA or readRegB)
begin
    readDataA=regFile[readRegA];
    readDataB=regFile[readRegB];
end

always @ (posedge clock)
begin
    if(regWriteE)
    begin
        regFile[writeRegE]=writeDataE;
    end
    if(regWriteM)
    begin
        regFile[writeDataM]=writeDataM;
    end
end

always @(reset)
begin
    if(reset)
        for(i=0;i<=14;i=i+1) regFile[i]=0;
end
endmodule

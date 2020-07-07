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
    if(readRegA==4'hf) readDataA=0;
    else readDataA=regFile[readRegA];
    if(readRegB==4'hf) readDataB=0;
    else readDataB=regFile[readRegB];
end

always @ (posedge clock)
begin
    if(writeRegE!=4'hf) regFile[writeRegE]=writeDataE;
    if(writeRegM!=4'hf) regFile[writeRegM]=writeDataM; 
end

always @(reset)
begin
    if(reset)
        for(i=0;i<=14;i=i+1) regFile[i]=24;
end
endmodule

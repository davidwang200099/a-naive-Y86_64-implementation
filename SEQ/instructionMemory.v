`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/08 09:20:56
// Design Name: 
// Module Name: instructionMemory
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


module instructionMemory(
    input clock,
    input reset,
    input [63:0] address,
    output reg [79:0] readData
    );
    reg [7:0] memFile [0:127];  
    always @ (address)
    begin
        readData={memFile[address+9],memFile[address+8],memFile[address+7],memFile[address+6],memFile[address+5],memFile[address+4],memFile[address+3],memFile[address+2],memFile[address+1],memFile[address]};
    end
    
endmodule
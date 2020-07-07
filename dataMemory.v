`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/07 10:42:10
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input clock,
    input reset,
    input [63:0] address,
    input [63:0] writeData,
    input memWrite,
    input memRead,
    output reg [63:0] readData
    );
    reg [7:0] memFile [0:31];
    integer i;
    always @ (reset)
    begin
        for(i=0;i<32;i=i+1) memFile[i]=5;
    end
    
    always @ (address or memRead)
    begin
        if(memRead)
        readData={memFile[address+7],memFile[address+6],memFile[address+5],memFile[address+4],memFile[address+3],memFile[address+2],memFile[address+1],memFile[address]};
    end
    always @ (posedge clock)
    begin
        if(memWrite==1) 
        begin
            memFile[address]=writeData[7:0];
            memFile[address+1]=writeData[15:8];
            memFile[address+2]=writeData[23:16];
            memFile[address+3]=writeData[31:24];
            memFile[address+4]=writeData[39:32];
            memFile[address+5]=writeData[47:40];
            memFile[address+6]=writeData[55:48];
            memFile[address+7]=writeData[63:56];
        end
    end
    
endmodule

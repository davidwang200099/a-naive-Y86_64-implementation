`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/07 10:51:03
// Design Name: 
// Module Name: dataMemory_tb
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


module dataMemory_tb();
    reg clock;
    reg [63:0] address;
    reg [63:0] writeData;
    reg memRead;
    reg memWrite;
    wire [63:0] readData;
    
    dataMemory dm(
        .clock(clock),
        .address(address),
        .writeData(writeData),
        .memRead(memRead),
        .memWrite(memWrite),
        .readData(readData)
    );
    
    always #50 clock=~clock;
    initial begin
        address=0;
        writeData=64'h1234567891bcdef;
        memWrite=1;
        clock=1;
        #100 
        memWrite=0;
        memRead=1;
    end
    
endmodule

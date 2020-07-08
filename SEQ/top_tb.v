`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/07 19:54:01
// Design Name: 
// Module Name: top_tb
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


module top_tb();
    reg clock;
    reg reset;
    reg [79:0] instr;
    top tp(.clock(clock),.reset(reset));
    
    always #50 clock=~clock;
    initial begin
        $readmemh("data.txt",tp.datamemory.memFile);
        $readmemh("instruction.txt",tp.instructionmemory.memFile);
        clock=1;
        reset=1;
        #25 reset=0;
    end
endmodule

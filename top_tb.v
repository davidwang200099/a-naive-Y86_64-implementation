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
    top tp(.clock(clock),.reset(reset),.instr(instr));
    
    always #50 clock=~clock;
    initial begin
        clock=1;
        reset=1;
        instr=80'hb09f0807060504030201;
        #25 reset=0;
        #100;
        
    end
endmodule

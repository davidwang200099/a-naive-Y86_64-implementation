`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/06 22:51:01
// Design Name: 
// Module Name: Ctr_tb
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


module Ctr_tb();
    reg [0:79] instruction;
    reg imem_error;
    reg clock;
    wire [3:0] icode;
    wire [3:0] ifun;
    wire [3:0] rA;
    wire [3:0] rB;
    wire [63:0] valC;
    wire instructionValid;
    wire needRegids;
    wire needvalC;
    Ctr ctr(
        .instruction(instruction),
        .imem_error(imem_error),
        .icode(icode),
        .ifun(ifun),
        .rA(rA),
        .rB(rB),
        .valC(valC),
        .instructionValid(instructionValid),
        .needRegids(needRegids),
        .needValC(needvalC)
    );
    always #100 clock=~clock;
    initial begin
        clock=1;
        imem_error=0;
        instruction=80'h00f10102030405060708;
        #100
        instruction=80'h10f12102030405060708;
        #100
        instruction=80'h20233102030405060708;
        #100
        instruction=80'h30f34102030405060709;
        #100
        instruction=80'h40245102030405060708;
        #100
        instruction=80'h50ac6102030405060708;
        #100
        instruction=80'h62db7102030405060708;
        #100
        instruction=80'h71018203040506070809;
        #100
        instruction=80'h80ac9102030405060708;
        #100
        instruction=80'h90c3a102030405060708;
        #100
        instruction=80'ha02fb102030405060708;
        #100
        instruction=80'hb03ec102030405060708;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/06 21:07:56
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [79:0] instruction,
    input imem_error,
    output reg [3:0] icode,
    output reg [3:0] ifun,
    output reg [3:0] rA,
    output reg [3:0] rB,
    output reg [63:0] valC,
    output reg instructionValid,
    output reg needRegids,
    output reg needValC,
    output reg setCC,
    output reg [3:0] alufun
    );
   
   always @ (instruction or imem_error)
   begin
       if(imem_error==0)
       begin
           setCC=0;
           icode=instruction[7:4];
           ifun=instruction[3:0];
           alufun=(instruction[7:4]==4'h6)?ifun:0;
           casex({icode,ifun})
               8'h00://halt
               begin
                   instructionValid=1;
                   needRegids=0;
                   needValC=0;
               end
               8'h10://nop
               begin
                   instructionValid=1;
                   needRegids=0;
                   needValC=0;
               end
               8'h2x://cmov
               begin
                   if(ifun>=0 && ifun<=6) instructionValid=1;
                   else instructionValid=0;
                   needRegids=1;
                   needValC=0;
                   rB=instruction[11:8];
                   rA=instruction[15:12];
               end
               8'h30://irmovq
               begin
                   instructionValid=1;
                   needRegids=1;
                   needValC=1;
                   rB=instruction[11:8];
                   rA=instruction[15:12];
                   valC={instruction[79:72],instruction[71:64],instruction[63:56],instruction[55:48],instruction[47:40],instruction[39:32],instruction[31:24],instruction[23:16]};
               end
               8'h40://rmmovq
               begin
                   instructionValid=1;
                   needRegids=1;
                   needValC=1;
                   rB=instruction[11:8];
                   rA=instruction[15:12];
                   valC={instruction[79:72],instruction[71:64],instruction[63:56],instruction[55:48],instruction[47:40],instruction[39:32],instruction[31:24],instruction[23:16]};
               end
               8'h50://mrmovq
               begin
                   instructionValid=1;
                   needRegids=1;
                   needValC=1;
                   rB=instruction[11:8];
                   rA=instruction[15:12];
                   valC={instruction[79:72],instruction[71:64],instruction[63:56],instruction[55:48],instruction[47:40],instruction[39:32],instruction[31:24],instruction[23:16]};
               end
               8'h6x://OPq 
               begin
                   if(ifun>=0 && ifun<=3) instructionValid=1;
                   else instructionValid=0;
                   needRegids=1;
                   needValC=0;
                   setCC=1;
                   rB=instruction[11:8];
                   rA=instruction[15:12];
               end
               8'h7x://jmp
               begin
                   if(ifun>=0 && ifun<=6) instructionValid=1;
                   else instructionValid=0;
                   needRegids=0;
                   needValC=1;
                   valC={instruction[71:64],instruction[63:56],instruction[55:48],instruction[47:40],instruction[39:32],instruction[31:24],instruction[23:16],instruction[15:8]};
               end
               8'h80://call
               begin
                   instructionValid=1;
                   needRegids=0;
                   needValC=1;
                   valC={instruction[71:64],instruction[63:56],instruction[55:48],instruction[47:40],instruction[39:32],instruction[31:24],instruction[23:16],instruction[15:8]};
               end
               8'h90://ret
               begin
                   instructionValid=1;
                   needRegids=0;
                   needValC=0;
               end
               8'ha0://pushq
               begin
                   instructionValid=1;
                   needRegids=1;
                   needValC=0;
                   rB=instruction[11:8];
                   rA=instruction[15:12];
               end
               8'hb0://popq
               begin
                   instructionValid=1;
                   needRegids=0;
                   needValC=0;
                   rB=instruction[11:8];
                   rA=instruction[15:12];
               end
               default:
               begin
                   icode=1;
                   ifun=0;
                   rA=0;
                   rB=0;
                   valC=0;
                   instructionValid=0;
                   needRegids=0;
                   needValC=0;
               end
           endcase
       end
       else
       begin
           icode=0;
           ifun=0;
           rA=0;
           rB=0;
           valC=0;
           instructionValid=0;
           needRegids=0;
           needValC=0;
       end
   end
endmodule

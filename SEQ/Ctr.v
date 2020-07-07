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
    input [0:79] instruction,
    input imem_error,
    output reg [3:0] icode,
    output reg [3:0] ifun,
    output reg [3:0] rA,
    output reg [3:0] rB,
    output reg [63:0] valC,
    output reg instructionValid,
    output reg needRegids,
    output reg needValC,
    output reg [3:0] alufun
    );
   
   always @ (instruction or imem_error)
   begin
       if(imem_error==0)
       begin
           icode=instruction[0:3];
           ifun=instruction[4:7];
           alufun=(icode==4'h6)?ifun:0;
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
                   rA=instruction[8:11];
                   rB=instruction[12:15];
               end
               8'h30://irmovq
               begin
                   instructionValid=1;
                   needRegids=1;
                   needValC=1;
                   rA=instruction[8:11];
                   rB=instruction[12:15];
                   valC={instruction[72:79],instruction[64:71],instruction[56:63],instruction[48:55],instruction[40:47],instruction[32:39],instruction[24:31],instruction[16:23]};
               end
               8'h40://rmmovq
               begin
                   instructionValid=1;
                   needRegids=1;
                   needValC=1;
                   rA=instruction[8:11];
                   rB=instruction[12:15];
                   valC={instruction[72:79],instruction[64:71],instruction[56:63],instruction[48:55],instruction[40:47],instruction[32:39],instruction[24:31],instruction[16:23]};
               end
               8'h50://mrmovq
               begin
                   instructionValid=1;
                   needRegids=1;
                   needValC=1;
                   rA=instruction[8:11];
                   rB=instruction[12:15];
                   valC={instruction[72:79],instruction[64:71],instruction[56:63],instruction[48:55],instruction[40:47],instruction[32:39],instruction[24:31],instruction[16:23]};
               end
               8'h6x://OPq 
               begin
                   if(ifun>=0 && ifun<=3) instructionValid=1;
                   else instructionValid=0;
                   needRegids=1;
                   needValC=0;
                   rA=instruction[8:11];
                   rB=instruction[12:15];
               end
               8'h7x://jmp
               begin
                   if(ifun>=0 && ifun<=6) instructionValid=1;
                   else instructionValid=0;
                   needRegids=0;
                   needValC=1;
                   valC={instruction[64:71],instruction[56:63],instruction[48:55],instruction[40:47],instruction[32:39],instruction[24:31],instruction[16:23],instruction[8:15]};
               end
               8'h80://call
               begin
                   instructionValid=1;
                   needRegids=0;
                   needValC=1;
                   valC={instruction[64:71],instruction[56:63],instruction[48:55],instruction[40:47],instruction[32:39],instruction[24:31],instruction[16:23],instruction[8:15]};
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
                   rA=instruction[8:11];
                   rB=instruction[12:15];
               end
               8'hb0://popq
               begin
                   instructionValid=1;
                   needRegids=0;
                   needValC=0;
                   rA=instruction[8:11];
                   rB=instruction[12:15];
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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2020/07/07 09:54:56
// Design Name:
// Module Name: ALU
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


module ALU(
    input [63:0] input1,
    input [63:0] input2,
    input [3:0] ALUfun,
    output reg [63:0] valE,
    output reg [2:0] CC//ZF:SF:OF
    );
    reg [63:0] complement;
    always @ (input1 or input2 or ALUfun)
    begin
        case(ALUfun)
            4'h0:
            begin
                valE=input2+input1;
                CC={(valE==0),(valE[63]),((input1[63]==input2[63])&&(input1[63]!=valE[63]))};
            end
            4'h1:
            begin
                valE=input2-input1;
                complement=(~input1)+1;
                CC={(valE==0),(valE[63]),((complement[63]==input2[63])&&(complement[63]!=valE[63]))};
            end
            4'h2:
            begin
                valE=input2&input1;
                CC={(valE==0),(valE[63]),1'b0};
            end
            4'h3:
            begin
                valE=input2^input1;
                CC={(valE==0),(valE[63]),1'b0};
            end
        endcase
    end
endmodule

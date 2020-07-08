`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/07 11:17:33
// Design Name: 
// Module Name: top
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


module top(input clock,input reset);
    reg [63:0] PC;
    wire IMEM_ERROR;
    wire INSTR_VALID,NEEDREGIDS,NEEDVALC,SETCC,MEMREAD,MEMWRITE;
    wire [3:0] ALUFUN;
    wire [79:0] INSTRUCTION;
    wire [3:0] ICODE,IFUN,RA,RB;
    wire [63:0] VALC,VALP,JUMPTARGE;
    wire [63:0] INPUT1,INPUT2;
    wire [63:0] ADDRESS,WRITEDATA;
    wire [63:0] NEW_PC;
    wire REGWRITE_E,REGWRITE_M;
    wire [3:0] WRITEREG_E,WRITEREG_M,READREG_A,READREG_B;
    wire [63:0] VALA,VALB,VALE,VALM;
    wire [2:0] CC_OUT;
    reg [2:0] CC;
    wire CND;
    always @ (posedge clock)
    begin
        if(reset) PC=0;
        else PC=NEW_PC;
    end
    
    instructionMemory instructionmemory(
        .clock(clock),
        .reset(0),
        .address(PC),
        
        .readData(INSTRUCTION)
    );
    
    Ctr ctr(
        .instruction(INSTRUCTION),
        .imem_error(0),
        .icode(ICODE),
        .ifun(IFUN),
        .rA(RA),
        .rB(RB),
        .valC(VALC),
        .instructionValid(INSTR_VALID),
        .needRegids(NEEDREGIDS),
        .needValC(NEEDVALC),
        .alufun(ALUFUN),
        .setCC(SETCC)
    );
    
     assign VALP=(NEEDREGIDS&&NEEDVALC)?(PC+10):(NEEDREGIDS?(PC+2):(NEEDVALC?(PC+9):(PC+1)));
     assign WRITEREG_E=((ICODE==4'h2&&CND)||ICODE==4'h3||ICODE==4'h6)?RB:
                         ((ICODE>=4'h8&&ICODE<=4'hb)?4'h4:
                         4'hf);
     assign WRITEREG_M=((ICODE==4'h5||ICODE==4'hb)?RA:4'hf);    
     assign READREG_A=(ICODE==4'h2||ICODE==4'h4||ICODE==4'h6||ICODE==4'ha)?RA:
             ((ICODE==4'h9||ICODE==4'hb)?4'h4:4'hf
             );             
     assign READREG_B=((ICODE>=4'h4&&ICODE<=4'h6)?RB:
                        (ICODE>=4'h8&&ICODE<=4'hb)?4'h4:4'hf
     );
     Register register(
         .clock(clock),
         .reset(reset),
         .writeRegE(WRITEREG_E),
         .writeRegM(WRITEREG_M),
         .readRegA(READREG_A),
         .readRegB(READREG_B),
         
         .readDataA(VALA),
         .readDataB(VALB),
         .writeDataE(VALE),
         .writeDataM(VALM)
     );
     
     assign INPUT1=(ICODE==4'h2||ICODE==4'h6)?VALA:
                 ((ICODE==4'h3||ICODE==4'h4||ICODE==4'h5)?VALC:
                 ((ICODE==4'h8||ICODE==4'ha)?-8:
                 8));
     
     assign INPUT2=(ICODE==4'h2||ICODE==4'h3)?0:VALB;
     
     ALU alu(
         .input1(INPUT1),
         .input2(INPUT2),
         .ALUfun(ALUFUN),
         
         .valE(VALE),
         .CC(CC_OUT)
     );
     
     always @ (negedge clock)
     begin
         if(SETCC) CC=CC_OUT;
     end
     
     assign ADDRESS=(ICODE==4'h4||ICODE==4'h5||ICODE==4'h8||ICODE==4'ha)?VALE:
             ((ICODE==4'h9||ICODE==4'hb)?VALA:
             0);
     assign WRITEDATA=(ICODE==4'h4||ICODE==4'ha)?VALA:((ICODE==4'h8)?VALP:0);
     
     assign MEMREAD=(ICODE==4'h5)||(ICODE==4'h9)||(ICODE==4'hb);
     
     assign MEMWRITE=(ICODE==4'h4)||(ICODE==4'h8)||(ICODE==4'ha);
     
     dataMemory datamemory(
         .clock(clock),
         .reset(reset),
         .address(ADDRESS),
         .writeData(WRITEDATA),
         .memWrite(MEMWRITE),
         .memRead(MEMREAD),
         .readData(VALM)
     );
     
     assign CND=(IFUN==0)||(IFUN==4'h1&&(CC[2]||CC[1]))||(IFUN==4'h2&&CC[1]&&!CC[2])||
               (IFUN==4'h3&&CC[2])||(IFUN==4'h4&&!CC[2])||(IFUN==4'h5&&!CC[1])||(IFUN==4'h6&&!CC[1]&&!CC[2]); 
    
    assign NEW_PC=(ICODE==4'h8||(ICODE==4'h7&&CND))?VALC:(
        (ICODE==4'h9)?VALM:
        VALP
    );
    
   
               
    
endmodule


module MCPUtb2();


reg reset, clk;


MCPU cpuinst (clk, reset);


initial begin
  reset=1;
  #10  reset=0;
end

always begin
  #5 clk=0; 
  #5 clk=1; 
end


/********OUR ASSEMBLER*****/

integer file, i;
reg[cpuinst.WORD_SIZE-1:0] memi;
parameter  [cpuinst.OPERAND_SIZE-1:0]  R0  = 0; //4'b0000
parameter  [cpuinst.OPERAND_SIZE-1:0]  R1  = 1; //4'b0001
parameter  [cpuinst.OPERAND_SIZE-1:0]  R2  = 2; //4'b0010
parameter  [cpuinst.OPERAND_SIZE-1:0]  R3  = 3; //4'b0011
parameter  [cpuinst.OPERAND_SIZE-1:0]  R4  = 4; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R5  = 5; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R6  = 6; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R7  = 7; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R8  = 8; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R9  = 9; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R10  = 10; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R11  = 11; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R12  = 12; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R13  = 13;
parameter  [cpuinst.OPERAND_SIZE-1:0]  R14  = 14; 
parameter  [cpuinst.OPERAND_SIZE-1:0]  R15  = 15; 
initial
begin

    for(i=0;i<256;i=i+1)
    begin
      cpuinst.raminst.mem[i]=0;
    end
    cpuinst.regfileinst.R[0]=0;
    cpuinst.regfileinst.R[1]=0;
    cpuinst.regfileinst.R[2]=0;
    cpuinst.regfileinst.R[3]=0;
    cpuinst.regfileinst.R[4]=0;
    cpuinst.regfileinst.R[5]=0;
    cpuinst.regfileinst.R[6]=0;
    cpuinst.regfileinst.R[7]=0;
    cpuinst.regfileinst.R[8]=0;
    cpuinst.regfileinst.R[9]=0;
    cpuinst.regfileinst.R[10]=0;
    cpuinst.regfileinst.R[11]=0;
    cpuinst.regfileinst.R[12]=0;
    cpuinst.regfileinst.R[13]=0;
    cpuinst.regfileinst.R[14]=0;
    cpuinst.regfileinst.R[15]=0;        



                                                                               //memory address: instruction
    i=0;  cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R0, 8'b00010011};   //0: R0=5102 & 1111_1111_0000_0000;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R1, 8'b11101110};   //1: R1=5102 & 0000_0000_1111_1111;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R3, 8'b00001000};   //1: R3=8; for shift
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R0, R0, R3};                 //2: LSL R0 R0 R3
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R2, R1, R0};                 //3: ADD R2 R1 R0
    
    i=i+1;  cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R4, 8'b00010011}; //0: R4=5116 & 1111_1111_0000_0000;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R5, 8'b11111100};   //1: R5=5116 & 0000_0000_1111_1111;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_SHORT_TO_REG, R6, 8'b00001000};   //1: R6=8;
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_LSL, R4, R4, R6};                 //2: LSL R4 R4 R6
    i=i+1;cpuinst.raminst.mem[i]={cpuinst.OP_ADD, R7, R4, R5};                 //3: ADD R7 R4 R5                                                              
                                                                               
    
    
    file = $fopen("program.list","w");
    for(i=0;i<cpuinst.raminst.RAM_SIZE;i=i+1)
    begin
      memi=cpuinst.raminst.mem[i];
      
      $fwrite(file, "%b_%b_%b_%b\n", 
        memi[cpuinst.INSTRUCTION_SIZE-1:cpuinst.INSTRUCTION_SIZE-cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE*3-1:2*cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE*2-1:cpuinst.OPCODE_SIZE],
        memi[cpuinst.OPCODE_SIZE-1:0]);
    end
    $fclose(file);
end

endmodule


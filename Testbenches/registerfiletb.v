
module MCPU_Registerfiletb();
  
  
  parameter WORD_SIZE = registerFile.WORD_SIZE;
  parameter OPERAND_SIZE = registerFile.OPERAND_SIZE;
  parameter REGISTERS_NUMBER = registerFile.REGISTERS_NUMBER;
  
  reg [OPERAND_SIZE-1:0] op1,op2,op3; // instruction operands
  reg [WORD_SIZE-1:0] datatoload; // data to feed to the specified reg (op1)
  reg [1:0] regsetcmd; // command for register file
  reg regsetwb; // enable register file command 
  
  reg is_correct;
  
  wire [WORD_SIZE-1:0] RegOp1;
  wire [WORD_SIZE-1:0] alu1; 
  wire [WORD_SIZE-1:0] alu2;
  
  MCPU_Registerfile registerFile(op1, op2, op3, RegOp1, alu1, alu2, datatoload, regsetwb, regsetcmd);
  
  
  integer i;
  initial begin
    regsetwb=0;
    is_correct = 0;
    op1=0;
    op2=0;
    op3=0;
    for (i = 0; i < REGISTERS_NUMBER; i = i + 1) begin
      regsetcmd = registerFile.NORMAL_EX; 
      op1 = i;          
      datatoload = 0;   
      regsetwb = 1;     
      #1
      regsetwb = 0;     
      #1;               
    end
    
    // testing for NORMAL_EX,LOAD_FROM_DATA
    for (i = 0; i < REGISTERS_NUMBER; i = i + 1) begin
      regsetcmd = registerFile.NORMAL_EX;
      op1 = i;
      op2 = i;
      op3 = i;
      datatoload = i;
      regsetwb = 1;
      #1; 
      regsetwb = 0;
      #1;      
      is_correct = (alu1 == datatoload) && (alu2 == datatoload) && (RegOp1 == datatoload);

    end
    
    // testing for MOV_INTERNAL
    for (i = 0; i < REGISTERS_NUMBER; i = i + 1) begin
      regsetcmd = registerFile.MOV_INTERNAL;
      op1 = (i + 1) % REGISTERS_NUMBER;
      op2 = i;
      regsetwb = 1;
      #1; 
      regsetwb = 0;
      #1;      
    end
    
    
    
  end

  
endmodule
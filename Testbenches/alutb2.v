module MCPU_Alutb2();

parameter CMD_SIZE=2;
parameter WORD_SIZE=8;

reg [CMD_SIZE-1:0] opcode;
reg [WORD_SIZE-1:0] r1;
reg [WORD_SIZE-1:0] r2;
wire [WORD_SIZE-1:0] out; // *2 removed
wire OVERFLOW;

// BEGIN
reg iscorrect;
parameter  [CMD_SIZE-1:0]  CMD_AND  = 0; //2'b00
parameter  [CMD_SIZE-1:0]  CMD_OR   = 1; //2'b01
parameter  [CMD_SIZE-1:0]  CMD_XOR   = 2; //2'b10
parameter  [CMD_SIZE-1:0]  CMD_ADD   = 3; //2'b11

reg [CMD_SIZE-1:0] opcode_tmp;
reg [WORD_SIZE-1:0] r1_tmp;
reg [WORD_SIZE-1:0] r2_tmp;

// END

MCPU_Alu #(.CMD_SIZE(CMD_SIZE), .WORD_SIZE(WORD_SIZE)) aluinst (opcode, r1, r2, out, OVERFLOW);

// Testbench code goes here

initial begin
  $display("@%0dns default is selected, opcode %b",$time,opcode);
end

always begin
 # 2
case(opcode_tmp)
  CMD_AND : begin
               iscorrect = (out == (r1_tmp&r2_tmp));

      end
  CMD_OR : begin
                iscorrect = (out == (r1_tmp|r2_tmp));
  
            end
  CMD_XOR : begin
              iscorrect = (out == (r1_tmp^r2_tmp));
 
            end
  default : begin
              iscorrect = ({OVERFLOW,out} == (r1_tmp+r2_tmp));
    
            end
 endcase
  r1_tmp = r1;
  r2_tmp = r2;
  opcode_tmp = opcode;
end 


always
begin
#2 r1 = 5; #2 r1 = 1; #2 r1 = 0; #2 r1 = 2;
end
always
begin
#2 r2 = 5; #2 r2 = 1; #2 r2 = 0; #2 r2 = 2;
end

always #2 opcode[0] = $random;
always #2 opcode[1] = $random;
 
endmodule




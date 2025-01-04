

module MCPU_Ramcontrollertb();
  
  parameter WORD_SIZE=ramcontroller.WORD_SIZE;
  parameter ADDR_WIDTH=ramcontroller.ADDR_WIDTH;
  parameter RAM_SIZE=ramcontroller.RAM_SIZE;
  
  
  reg [WORD_SIZE-1:0] tmp_mem[RAM_SIZE-1:0];
  reg [WORD_SIZE-1:0] am_array[3:0];
  
  reg we, re;
  reg is_correct_data, is_correct_instr;
  reg [WORD_SIZE-1:0] datawr;
  reg [WORD_SIZE-1:0] temp_mem_data;

  reg [ADDR_WIDTH-1:0] addr;
  reg [ADDR_WIDTH-1:0] instraddr;
  
  wire [WORD_SIZE-1:0] datard;
  wire [WORD_SIZE-1:0] instrrd;
  
  
  
  MCPU_RAMController ramcontroller(we, datawr, re, addr, datard, instraddr, instrrd);
  
  
  
  integer i;
  initial begin
    we = 0;
    is_correct_data = 0;
    is_correct_instr = 0;
    re = 0;
    // write random data
    for (i = 0; i < 12; i = i + 1) begin
      tmp_mem[i] = $random;
      datawr = tmp_mem[i];
      addr = i;
      #1
      we = 1;
      #1
      we = 0;
    end
    
    // read random data
    for (i = 0; i < 12; i = i + 1) begin
      addr = i;
      #1
      re = 1;
      #1
      temp_mem_data = tmp_mem[addr];
      is_correct_data = (datard == temp_mem_data);
      #1
      is_correct_data = 0;
      re = 0;
      instraddr = i;
      #1
      is_correct_instr = (instrrd == temp_mem_data);
      #1
      is_correct_instr = 0;
    end
    
    #10
    am_array[0] = 51;
    am_array[1] = 2;
    am_array[2] = 51;
    am_array[3] = 16;
    
     for (i = 0; i < 12; i = i + 1) begin
      tmp_mem[i] = am_array[i % 4];
      datawr = tmp_mem[i];
      addr = i;
      #1
      we = 1;
      #1
      we = 0;
    end
    
    // read random data
    for (i = 0; i < 12; i = i + 1) begin
      addr = i;
      #1
      re = 1;
      #1
      temp_mem_data = tmp_mem[addr];
      is_correct_data = (datard == temp_mem_data);
      #1
      is_correct_data = 0;
      re = 0;
      instraddr = i;
      #1
      is_correct_instr = (instrrd == temp_mem_data);
      #1
      is_correct_instr = 0;
    end
        
    end

  
endmodule
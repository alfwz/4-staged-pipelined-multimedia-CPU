library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all; 
use work.insbuffer_type.all;
 
entity file_io_tb is
end file_io_tb;
 
 
architecture behave of file_io_tb is
 
  -----------------------------------------------------------------------------
  -- Declare the Component Under Test
  -----------------------------------------------------------------------------
 
  signal tb_clk: std_logic;	 
  signal tb_alu_out: std_logic_vector(127 downto 0);
  signal rom_data: insBuffer;
  signal count:integer :=0;			   
  signal alu_out: std_logic_vector(127 downto 0);
  
  constant period : time := 20 ns;
  
  
  -----------------------------------------------------------------------------
  -- Instantiate and Map UUT
  -----------------------------------------------------------------------------
  file file_input : text;
  file file_output: text;
   
  
 
  begin 
	  UUT: entity pipiline_unit port map(
		  ins_in => rom_data,
		  clk => tb_clk,	
		  ALU_o => tb_alu_out
		  );	 
		  
  
 
  ---------------------------------------------------------------------------
  -- This procedure reads the file input_vectors.txt which is located in the
  -- simulation project area.
  -- It will read the data in and send it to the ripple-adder component
  -- to perform the operations.  The result is written to the
  -- output_results.txt file, located in the same directory.
  ---------------------------------------------------------------------------
  process
    variable ILINE : line;
    variable INS_LINE  : std_logic_vector(24 downto 0);
    variable count: integer:=0;
	variable v_out : line;
     
  begin
    file_open(file_input, "opcode.txt",  read_mode);
	file_open(file_output, "alu_out.txt", write_mode);
	
	
    while not endfile(file_input) loop
      readline(file_input, ILINE);
      read(ILINE, INS_LINE);   
	  rom_data(count)<= INS_LINE;
	  count := count+1;
    end loop; 
    file_close(file_input);	
	
	
	for i in 0 to count +4 loop
		wait for period;
		write(v_out, tb_alu_out);
		writeline(file_output, v_out);
    end loop;  
	file_close(file_output);
	
  end process;
  

  
  clock: process
  begin 
	  tb_clk <='0';
	  wait for 10ns;
	  tb_clk<='1';
	  wait for 10ns;
  end process;
end behave;
-------------------------------------------------------------------------------
--
-- Title       : pipiline_unit
-- Design      : processor
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\gavin\Desktop\Study\ESE345\project\processor\processor\src\pipiline_unit.vhd
-- Generated   : Sat Nov 30 17:56:18 2019
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {pipiline_unit} architecture {structural}}	

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;		  
use work.insbuffer_type.all;  
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pipiline_unit is		   
	port(		  	   
	ins_in : in insBuffer;
	clk : in std_logic;
	ALU_o : out std_logic_vector(127 downto 0)
	);
end pipiline_unit;

--}} End of automatically maintained section

architecture structural of pipiline_unit is		  	 
signal ins : std_logic_vector(24 downto 0);	  
signal r1_out : std_logic_vector(127 downto 0);			 
signal r2_out : std_logic_vector(127 downto 0);
signal r3_out : std_logic_vector(127 downto 0);		   	  	 
signal r1_s : std_logic_vector(127 downto 0);			 
signal r2_s : std_logic_vector(127 downto 0);
signal r3_s : std_logic_vector(127 downto 0);
signal ins_rf : std_logic_vector(24 downto 0);	  
signal ins_ALU : std_logic_vector(24 downto 0);
begin	  	
	u1:entity ins_buffer port map(
		instructions => ins_in,
		clk => clk,	 
		ins_out => ins
		);			 
		
	u2:entity register_file port map(  
		WrData => ALU_o,
		ins => ins,
		old_ins => ins_ALU,
		clk => clk,
		r1 => r1_out,
		r2 => r2_out,
		r3 => r3_out, 
		ins_out => ins_rf
		);	  				   
		
	u3:entity alu port map(	
		clk => clk,
		ins => ins_rf,
		r1 => r1_s,
		r2 => r2_s,
		r3 => r3_s,
		alu_out => ALU_o,	
		ins_out => ins_ALU
		);			   
		
	u4:entity forwarding_unit port map(
		ALU_out => ALU_o,
		r1_in => r1_out,
		r2_in => r2_out,  
		r3_in => r3_out,
		ins => ins_rf,
		old_ins => ins_ALU,
		r1_out => r1_s,
		r2_out => r2_s,
		r3_out => r3_s
		);
		

	 -- enter your statements here --

end structural;

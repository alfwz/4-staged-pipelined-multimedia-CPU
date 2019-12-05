-------------------------------------------------------------------------------
--
-- Title       : ins_buffer
-- Design      : processor
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\gavin\Desktop\Study\ESE345\project\processor\processor\src\ins_buffer.vhd
-- Generated   : Sat Nov 30 16:31:09 2019
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
--{entity {ins_buffer} architecture {behavioral}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package insbuffer_type is															 
type insBuffer is array(63 downto 0) of std_logic_vector (24 downto 0);
end package insbuffer_type;	 
use work.insbuffer_type.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	 
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ins_buffer is		  
	port(
	instructions : in insBuffer;
	clk : in std_logic;
	ins_out : out std_logic_vector(24 downto 0)			  
	);
end ins_buffer;

--}} End of automatically maintained section

architecture behavioral of ins_buffer is			 
signal PC : std_logic_vector(5 downto 0) := "000000";
begin		
	process(clk, instructions)
	begin					 
		if rising_edge(clk) then
			ins_out <= instructions(to_integer(unsigned(PC)));		
			PC <= PC + std_logic_vector(to_unsigned(1, PC'length));
		end if;
	end process;

	 -- enter your statements here --

end behavioral;

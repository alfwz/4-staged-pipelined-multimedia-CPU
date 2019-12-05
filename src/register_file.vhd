-------------------------------------------------------------------------------
--
-- Title       : register_file
-- Design      : processor
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\gavin\Desktop\Study\ESE345\project\processor\processor\src\register_file.vhd
-- Generated   : Sat Nov 30 15:35:50 2019
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
--{entity {register_file} architecture {behavioral}}

library IEEE;
use IEEE.std_logic_1164.all;   
use ieee.numeric_std.all;

entity register_file is
	 port(
		 WrData : in STD_LOGIC_VECTOR(127 downto 0);
		 ins : in STD_LOGIC_VECTOR(24 downto 0);   
		 old_ins : in std_logic_vector(24 downto 0);
		 r1 : out STD_LOGIC_VECTOR(127 downto 0);
		 r2 : out STD_LOGIC_VECTOR(127 downto 0);
		 r3 : out STD_LOGIC_VECTOR(127 downto 0);  
		 ins_out : out std_logic_vector(24 downto 0);
		 clk : in std_logic
	     );
end register_file;

--}} End of automatically maintained section

architecture behavioral of register_file is		  
type RegisterFile is array(31 downto 0) of std_logic_vector(127 downto 0);
signal regs : RegisterFile := ((others=>(others=>'0')));															 
begin					   	
	process(clk, WrData, ins)
	begin						
		if rising_edge(clk) then		
			if old_ins(24 downto 23) = "11" then 	   
				if old_ins(19 downto 15) = "00000" then
				null;
				else
					regs(to_integer(unsigned(old_ins(4 downto 0)))) <= WrData;	
				end if;		 
			else	   
				regs(to_integer(unsigned(old_ins(4 downto 0)))) <= WrData;
			end if;	   
			if ins(24) = '0' then
				r1 <= regs(to_integer(unsigned(ins(4 downto 0))));
				r2 <= regs(to_integer(unsigned(ins(14 downto 10))));							 
				r3 <= regs(to_integer(unsigned(ins(19 downto 15))));	
			end if;
			if ins(9 downto 5) = old_ins(4 downto 0) then
				r1 <= WrData;
				r2 <= regs(to_integer(unsigned(ins(14 downto 10))));							 
				r3 <= regs(to_integer(unsigned(ins(19 downto 15))));
			elsif ins(9 downto 5) = old_ins(4 downto 0) then
				r2 <= WrData;
				r1 <= regs(to_integer(unsigned(ins(9 downto 5))));							 
				r3 <= regs(to_integer(unsigned(ins(19 downto 15)))); 
			elsif ins(9 downto 5) = old_ins(4 downto 0) then
				r3 <= WrData  ;
				r2 <= regs(to_integer(unsigned(ins(14 downto 10))));							 
				r1 <= regs(to_integer(unsigned(ins(9 downto 5))));	
			else
				r1 <= regs(to_integer(unsigned(ins(9 downto 5))));
				r2 <= regs(to_integer(unsigned(ins(14 downto 10))));							 
				r3 <= regs(to_integer(unsigned(ins(19 downto 15))));	
			end if;
			ins_out <= ins;	
		end if;
	end process;

	 -- enter your statements here --

end behavioral;

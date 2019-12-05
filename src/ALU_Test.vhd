-------------------------------------------------------------------------------
--
-- Title       : ALU_Test
-- Design      : project
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : D:\project345\src\ALU_Test.vhd
-- Generated   : Mon Dec  2 13:43:13 2019
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
--{entity {ALU_Test} architecture {behavior}}

library IEEE;
use IEEE.std_logic_1164.all;	
use ieee.numeric_std.all;	
	 

entity ALU_Test is
	 port(
		 r1 : in STD_LOGIC_vector(7 downto 0);
		 r2 : in STD_LOGIC_vector(7 downto 0);
		 r3 : in STD_LOGIC_vector(7 downto 0);   
		 ins : in std_logic_vector(24 downto 0);
		 alu_out : out STD_LOGIC_vector(7 downto 0)
	     );
end ALU_Test;

--}} End of automatically maintained section

architecture behavior of ALU_Test is	
signal out_mod : std_logic_vector(127 downto 0) := std_logic_vector(to_unsigned(0, 128));
begin		   
	process(r1, r2, r3, ins)		  
	variable temp1, temp2: std_logic_vector(15 downto 0);
	begin
	
		if to_integer(signed(r1))= -128 and r2(7)='1' then 
					alu_out(7 downto 0) <= (Others=>'1');
					alu_out(7)<='0'; 			 
				else
					if r2(7)='1' then 			  		   
						--signed(r1(127 downto 96)*(-1)
						alu_out<=std_logic_vector(to_signed(to_integer(signed(r1))*(-1),8));

					elsif r2="00000000"then 
						alu_out<="00000000";
					else
						alu_out<=r1;
					end if;
				end if;
	
	end process;

	 -- enter your statements here --

end behavior;

-------------------------------------------------------------------------------
--
-- Title       : forwarding_unit
-- Design      : processor
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : C:\Users\gavin\Desktop\Study\ESE345\project\processor\processor\src\forwarding_unit.vhd
-- Generated   : Sat Nov 30 17:16:23 2019
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
--{entity {forwarding_unit} architecture {\behavioral \}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	

entity forwarding_unit is
	port(
	ALU_out : in std_logic_vector(127 downto 0);
	r1_in : in std_logic_vector(127 downto 0);
	r2_in : in std_logic_vector(127 downto 0);
	r3_in : in std_logic_vector(127 downto 0);	  
	ins : in std_logic_vector(24 downto 0);	
	old_ins : in std_logic_vector(24 downto 0);
	r1_out : out std_logic_vector(127 downto 0);
	r2_out : out std_logic_vector(127 downto 0);
	r3_out : out std_logic_vector(127 downto 0)
	);
end forwarding_unit;

--}} End of automatically maintained section

architecture behavioral of forwarding_unit is	
signal older_ins : std_logic_vector(24 downto 0);
signal old_out : std_logic_vector(127 downto 0);
begin	
	process(ALU_out, r1_in, r2_in, r3_in, ins, old_ins)
	begin 
		if ins(24) = '0' then
			if old_ins(4 downto 0) = ins(4 downto 0) then
				r1_out <= ALU_out;
				r2_out <= r2_in;
				r3_out <= r3_in;
			elsif older_ins(4 downto 0) = ins(4 downto 0) then
				r1_out <= old_out;
				r2_out <= r2_in;
				r3_out <= r3_in;
			else
				r1_out <= r1_in;
				r2_out <= r2_in;
				r3_out <= r3_in;
			end if;	
		elsif ins(24) = '1' then
			if ins(23) = '1' then
				if ins(19 downto 15) = "00000" then
					r1_out <= r1_in;
					r2_out <= r2_in;
					r3_out <= r3_in;
				else
					if old_ins(4 downto 0) = ins(9 downto 5) then
						r1_out <= ALU_out;
						r2_out <= r2_in;
						r3_out <= r3_in;
					elsif old_ins(4 downto 0) = ins(14 downto 10) then
						r2_out <= ALU_out;
						r1_out <= r1_in;
						r3_out <= r3_in;	 
					elsif older_ins(4 downto 0) = ins(9 downto 5) then
						r1_out <= old_out;
						r2_out <= r2_in;
						r3_out <= r3_in;
					elsif older_ins(4 downto 0) = ins(14 downto 10) then
						r2_out <= old_out;
						r1_out <= r1_in;
						r3_out <= r3_in;
					else
						r1_out <= r1_in;
						r2_out <= r2_in;
						r3_out <= r3_in;
					end if;
				end if;
			elsif ins(23) = '0' then		 
				if old_ins(4 downto 0) = ins(9 downto 5) then
					r1_out <= ALU_out;
					r2_out <= r2_in;
					r3_out <= r3_in;
				elsif old_ins(4 downto 0) = ins(14 downto 10) then
					r2_out <= ALU_out;
					r1_out <= r1_in;
					r3_out <= r3_in;	  
				elsif old_ins(4 downto 0) = ins(19 downto 15) then
					r3_out <= ALU_out;
					r1_out <= r1_in;
					r2_out <= r2_in;	
				elsif older_ins(4 downto 0) = ins(9 downto 5) then
					r1_out <= old_out;
					r2_out <= r2_in;
					r3_out <= r3_in;
				elsif older_ins(4 downto 0) = ins(14 downto 10) then
					r2_out <= old_out;
					r1_out <= r1_in;
					r3_out <= r3_in;	  
				elsif older_ins(4 downto 0) = ins(19 downto 15) then
					r3_out <= old_out;
					r1_out <= r1_in;
					r2_out <= r2_in;
				else  
					r1_out <= r1_in;
					r2_out <= r2_in;
					r3_out <= r3_in;
				end if;
			end if;		
		end if;		 
		older_ins <= old_ins;					
		old_out <= ALU_out;
	end process;			  


	 -- enter your statements here --

end behavioral;

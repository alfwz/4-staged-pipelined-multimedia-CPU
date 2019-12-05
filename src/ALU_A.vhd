-------------------------------------------------------------------------------
--
-- Title       : ALU_A
-- Design      : processor
-- Author      : zhongang.zhou@stonybrook.edu
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : c:\Users\gavin\Desktop\Study\ESE345\project\processor\processor\src\ALU_A.vhd
-- Generated   : Sun Dec  1 18:38:51 2019
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
--{entity {ALU_A} architecture {behavioral}}

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;	

entity ALU_A is
	port(
	r1: in std_logic_vector(127 downto 0);
	r2: in std_logic_vector(127 downto 0);
	r3: in std_logic_vector(127 downto 0);
	ins: in std_logic_vector(24 downto 0);
	ins_out: out std_logic_vector(24 downto 0);
	alu_out: out std_logic_vector(127 downto 0)
	);
end ALU_A;

--}} End of automatically maintained section

architecture behavioral of ALU_A is
begin
	   process(r1, r2, r3, ins) 	
		variable zero_count : integer range 0 to 32;
		variable one_count : integer range 0 to 32;
		variable bits_of_shift : intege range 0 to 128;
	begin  
		ins_out<=ins;
		
		------------------4.1 load imm instruction-------------------------
		if ins(24) = '0' then 
			alu_out <= std_logic_vector(signed(ins(20 downto 5)),128);					  				   
	
		------------------4.2 R4 instruction---------------------------
		-----------saturation??
			elsif ins(24 downto 23) = "10" then 
			case ins(22 downto 20) is 
				when "000" =>
					alu_out(127 downto 96) <= signed(r2(111 downto 96))* signed(r3(111 downto 96)) + signed(r1(111 downto 96));
					alu_out(95 downto 64) <= signed(r2(79 downto 64))* signed(r3(79 downto 64))+	signed(r1(79 downto 64));
					alu_out(63 downto 32) <= signed(r2(47 downto 32))* signed(r3(47 downto 32))+	signed(r1(47 downto 32));
					alu_out(31 downto 0) <= signed(r2(15 downto 0))* signed(r3(15 downto 0)) + signed(r1(15 downto 0));
					--if(signed(alu_out)>2147483647) then 
						--elsif(signed(alu_out)<-2147483648) then 
					
				when "001" =>
					alu_out(127 downto 96) <= signed(r2(127 downto 112))* signed(r3(127 downto 112)) + signed(r1(127 downto 112));
					alu_out(95 downto 64) <= signed(r2(95 downto 80))* signed(r3(95 downto 80))+	signed(r1(95 downto 80));
					alu_out(63 downto 32) <= signed(r2(63 downto 48))* signed(r3(63 downto 48))+	signed(r1(63 downto 48));
					alu_out(31 downto 0) <= signed(r2(31 downto 16))* signed(r3(31 downto 16))+	signed(r1(316 downto 0));
				when "010" =>  
					alu_out(127 downto 96) <=signed(r1(111 downto 96))- signed(r2(111 downto 96))* signed(r3(111 downto 96));
					alu_out(95 downto 64) <=signed(r1(79 downto 64))- signed(r2(79 downto 64))* signed(r3(79 downto 64));
					alu_out(63 downto 32) <=signed(r1(47 downto 32))- signed(r2(47 downto 32))* signed(r3(47 downto 32));
					alu_out(31 downto 0) <=signed(r1(15 downto 0)) - signed(r2(15 downto 0))* signed(r3(15 downto 0)) ;
				when "011" =>  
					alu_out(127 downto 96) <= signed(r1(127 downto 112))-signed(r2(127 downto 112))* signed(r3(127 downto 112)) ;
					alu_out(95 downto 64) <= signed(r1(95 downto 80))-signed(r2(95 downto 80))* signed(r3(95 downto 80));
					alu_out(63 downto 32) <= signed(r1(63 downto 48))-signed(r2(63 downto 48))* signed(r3(63 downto 48));
					alu_out(31 downto 0) <= signed(r1(316 downto 0))-signed(r2(31 downto 16))* signed(r3(31 downto 16));
				when "100" =>
					alu_out(127 downto 64) <= signed(r2(95 downto 64))* signed(r3(95 downto 64)) + signed(r1(95 downto 64));
					alu_out(63 downto 0) <= signed(r2(31 downto 0))* signed(r3(31 downto 0)) +signed(r1(31 downto 0));
				when "101" =>
					alu_out(127 downto 64) <= signed(r2(127 downto 96))* signed(r3(127 downto 96))+signed(r1(127 downto 96));
					alu_out(63 downto 0) <= signed(r2(63 downto 32))* sigend(r3(63 downto 32)) +signed(r1(63 downto 32));
				when "110" =>
					alu_out(127 downto 64) <= signed(r1(95 downto 64))-signed(r2(95 downto 64))* signed(r3(95 downto 64));
					alu_out(63 downto 0) <=  signed(r1(31 downto 0))-signed(r2(31 downto 0))* sigend(r3(31 downto 0));
				when "111" =>
					alu_out(127 downto 64) <= signed(r1(127 downto 96))-signed(r2(127 downto 96))* signed(r3(127 downto 96));
					alu_out(63 downto 0) <= signed(r1(63 downto 32))-signed(r2(63 downto 32))* sigend(r3(63 downto 32));
			end case;
			
			
		-----------------4.3 R3 instruction------------------------------------
			elsif ins(24 downto 23) = "11" then 
			case ins(22 downto 15) is
				when "---00000" =>
				when "---00001" =>
					alu_out(127 downto 96)<=unsigned(r2(127 downto 96))+unsigned(r3(127 downto 96));
					alu_out(95 downto 64)<=unsigned(r2(95 downto 64))+unsigned(r3(95 downto 64));
					alu_out(63 downto 32)<=unsigned(r2(63 downto 32))+unsigned(r3(63 downto 32));
					alu_out(31 downto 0)<=unsigned(r2(31 downto 0))+ unsigned(r3(31 downto 0));
				when "---00010" =>
					alu_out(127 downto 112)<=unsigned(r2(127 downto 112))+unsigned(r3(127 downto 112));
					alu_out(111 downto 96)<=unsigned(r2(111 downto 96))+unsigned(r3(111 downto 96));
					alu_out(95 downto 80)<=unsigned(r2(95 downto 80))+unsigned(r3(95 downto 80));
					alu_out(79 downto 64)<=unsigned(r2(79 downto 64))+unsigned(r3(79 downto 64));
					alu_out(63 downto 48)<=unsigned(r2(63 downto 48))+unsigned(r3(63 downto 48));
					alu_out(47 downto 32)<=unsigned(r2(47 downto 32))+unsigned(r3(47 downto 32));
					alu_out(31 downto 16)<=unsigned(r2(31 downto 16))+unsigned(r3(31 downto 16));
					alu_out(15 downto 0)<=unsigned(r2(15 downto 0))+unsigned(r3(15 downto 0));
				when "---00011" =>
				----saturation
					alu_out(127 downto 112)<=unsigned(r2(127 downto 112)) + unsigned(r3(127 downto 112));
					alu_out(111 downto 96)<=unsigned(r2(111 downto 96))+unsigned(r3(111 downto 96));
					alu_out(95 downto 80)<=unsigned(r2(95 downto 80))+unsigned(r3(95 downto 80));
					alu_out(79 downto 64)<=unsigned(r2(79 downto 64))+unsigned(r3(79 downto 64));
					alu_out(63 downto 48)<=unsigned(r2(63 downto 48))+unsigned(r3(63 downto 48));
					alu_out(47 downto 32)<=unsigned(r2(47 downto 32))+unsigned(r3(47 downto 32));
					alu_out(31 downto 16)<=unsigned(r2(31 downto 16))+unsigned(r3(31 downto 16));
					alu_out(15 downto 0)<=unsigned(r2(15 downto 0))+unsigned(r3(15 downto 0));
				when "---00100" =>
					alu_out <= r1 and r2;
				when "---00101" =>
				--BCW: broadcast word
				when "---00110" =>
					for i in 127 to 96 loop
						if ins(i) = '0' then 
							zero_count := zero_count+1;
						else 
							exit;
						end if;
					end loop;
					alu_out(127 downto 96) <= std_logic_vector(to_unsigned(zero_count,32));
					zero_count :=0;
					
					for i in 95 to 64 loop
						if ins(i) = '0' then 
							zero_count := zero_count+1;
						else 
							exit;
						end if;
					end loop;
					alu_out(95 downto 64) <= std_logic_vector(to_unsigned(zero_count,32));
					zero_count :=0;
					
					for i in 63 to 32 loop
						if ins(i) = '0' then 
							zero_count := zero_count+1;
						else 
							exit;
						end if;
					end loop;
					alu_out(63 downto 32) <= std_logic_vector(to_unsigned(zero_count,32));
					zero_count :=0;
					
					for i in 31 to 0 loop
						if ins(i) = '0' then 
							zero_count := zero_count+1;
						else 
							exit;
						end if;
					end loop;
					alu_out(31 downto 0) <= std_logic_vector(to_unsigned(zero_count,32));
					zero_count :=0;
					
				when "---00111" =>
					if(sigend(r1(127 downto 96)) > sigend(r2(127 downto 96))) then 
						alu_out(127 downto 96)<= r1(127 downto 96);
						else
							alu_out(127 downto 96) <= r2(127 downto 96);
					end if;
					
					if(sigend(r1(95 downto 64)) > sigend(r2(95 downto 64))) then 
						alu_out(95 downto 64)<= r1(95 downto 64);
						else
							alu_out(95 downto 64) <= r2(95 downto 64);
					end if;
					
					if(sigend(r1(63 downto 32)) > sigend(r2(63 downto 32))) then 
						alu_out(63 downto 32)<= r1(63 downto 32);
						else
							alu_out(63 downto 32) <= r2(63 downto 32);
					end if;
					
					if(sigend(r1(31 downto 0)) > sigend(r2(31 downto 0))) then 
						alu_out(31 downto 0)<= r1(31 downto 0);
						else
							alu_out(31 downto 0) <= r2(31 downto 0);
					end if;
				
				
				----------MIN: min signed word
				when "---01000" =>
					if(sigend(r1(127 downto 96)) > sigend(r2(127 downto 96))) then 
						alu_out(127 downto 96)<= r2(127 downto 96);
						else
							alu_out(127 downto 96) <= r1(127 downto 96);
					end if;
					
					if(sigend(r1(95 downto 64)) > sigend(r2(95 downto 64))) then 
						alu_out(95 downto 64)<= r2(95 downto 64);
						else
							alu_out(95 downto 64) <= r1(95 downto 64);
					end if;
					
					if(sigend(r1(63 downto 32)) > sigend(r2(63 downto 32))) then 
						alu_out(63 downto 32)<= r2(63 downto 32);
						else
							alu_out(63 downto 32) <= r1(63 downto 32);
					end if;
					
					if(sigend(r1(31 downto 0)) > sigend(r2(31 downto 0))) then 
						alu_out(31 downto 0)<= r2(31 downto 0);
						else
							alu_out(31 downto 0) <= r1(31 downto 0);
					end if;
					
					
				---------MSGN: multiply signed
				when "---01001" =>
					if(r2(127)='1') then 
						alu_out(127 downto 96)<=std_logic_vector(signed(r1(127 downto 96))*(-1),32);
						elsif unsigned(r2(127 downto 96))=0 then 
						alu_out(127 downto 96)<=std_logic_vector(0,32);
						else
						alu_out(127 downto 96)<=r1(127 downto 96);
					end if;
					
					if(r2(95)='1') then 
						alu_out(95 downto 64)<=std_logic_vector(signed(r1(95 downto 64))*(-1),32);
						elsif unsigned(r2(95 downto 64))=0 then 
						alu_out(95 downto 64)<=std_logic_vector(0,32);
						else
						alu_out(95 downto 64)<=r1(95 downto 64);
					end if;
					
					if(r2(63)='1') then 
						alu_out(63 downto 32)<=std_logic_vector(signed(r1(63 downto 32))*(-1),32);
						elsif unsigned(r2(63 downto 32))=0 then 
						alu_out(63 downto 32)<=std_logic_vector(0,32);
						else
						alu_out(63 downto 32)<=r1(63 downto 32);
					end if;
					
					if(r2(31)='1') then 
						alu_out(31 downto 0)<=std_logic_vector(signed(r1(31 downto 0))*(-1),32);
						elsif unsigned(r2(31 downto 0))=0 then 
						alu_out(31 downto 0)<=std_logic_vector(0,32);
						else
						alu_out(31 downto 0)<=r1(31 downto 0);
					end if;
					
				---------MPYU: multiply unsigned
				when "---01010" =>
					alu_out(128 downto 96)<=std_logic_vector(unsigned(r1(111 downto 96)* unsigned(r2(111 downto 96)),32));
					alu_out(96 downto 64)<=std_logic_vector(unsigned(r1(79 downto 64)* unsigned(r2(79 downto 64)),32));
					alu_out(63 downto 32)<=std_logic_vector(unsigned(r1(47 downto 32)* unsigned(r2(47 downto 32)),32));
					alu_out(31 downto 0)<=std_logic_vector(unsigned(r1(15 downto 0)* unsigned(r2(15 downto 0)),32));
				---------OR: bitwise logical or
				when "---01011" =>
					alu_out <= r1 or r2;
					
				---------POPCNTH: count ones in halfwords
				when "---01100" =>
					for i in 127 to 112 loop
						if ins(i)='1' then 
							one_count := one_count+1;
						end if;
					end loop;
					alu_out(127 downto 112) <= std_logic_vector(to_unsigned(one_count),16);
					one_count:=0;
					
					for i int 111 to 96 loop
						if ins(i)='1' then 
							one_count := one_count +1;
						end if;
					end loop;
					alu_out(111 downto 96) <= std_logic_vector(to_unsigned(one_count),16);
					one_count:=0;
					
					for i in 95 to 80 loop
						if ins(i)='1' then 
							one_count := one_count+1;
						end if;
					end loop;
					alu_out(95 downto 80) <= std_logic_vector(to_unsigned(one_count),16);
					one_count:=0;
					
					for i in 79 to 64 loop
						if ins(i)='1' then 
							one_count := one_count +1;
						end if;
					end loop;
					alu_out(79 downto 64) <= std_logic_vector(to_unsigned(one_count),16);
					one_count:=0;
					
					for i in 63 to 48 loop
						if ins(i)='1' then 
							one_count := one_count+1;
						end if;
					end loop;
					alu_out(63 downto 48) <= std_logic_vector(to_unsigned(one_count),16);
					one_count:=0;
					
					for i int 47 to 32 loop
						if ins(i)='1' then 
							one_count := one_count +1;
						end if;
					end loop;
					alu_out(47 downto 32) <= std_logic_vector(to_unsigned(one_count),16);
					one_count:=0;
					
					for i in 31 to 16 loop
						if ins(i)='1' then 
							one_count := one_count+1;
						end if;
					end loop;
					alu_out(31 downto 16) <= std_logic_vector(to_unsigned(one_count),16);
					one_count:=0;
					
					for i in 15 to 0 loop
						if ins(i)='1' then 
							one_count := one_count +1;
						end if;
					end loop;
					alu_out(15 downto 0) <= std_logic_vector(to_unsigned(one_count),16);
					one_count:=0;
							
				---------ROT: rotate bits right
				when "---01101" =>
					bits_of_shift:=to_unsigned(r2(6 downto 0));
					alu_out<=r1 SRL bits_of_shift;
				
				---------ROTW: rotate bits in word
				when "---01110" =>
					bits_of_shift:=to_unsigned(r2(100 downto 96));
					alu_out(127 downto 96)<=r1(127 downto 96) SRL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(68 downto 64));
					alu_out(95 downto 64)<=r1(95 downto 64) SRL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(36 downto 32));
					alu_out(63 downto 32)<=r1(63 downto 32) SRL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(5 downto 0));
					alu_out(31 downto 0)<=r1(31 downto 0) SRL bits_of_shift;
					
				---------SHLHI: shift left halfword immediate:
				when "---01111" =>
					bits_of_shift:=to_unsigned(r2(116 downto 112));
					alu_out(127 downto 112)<=r1(127 downto 112) SLL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(100 downto 96));
					alu_out(111 downto 96)<=r1(111 downto 96) SLL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(84 downto 80));
					alu_out(95 downto 80)<=r1(95 downto 80) SLL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(68 downto 64));
					alu_out(79 downto 64)<=r1(79 downto 64) SLL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(52 downto 48));
					alu_out(63 downto 48)<=r1(63 downto 48) SLL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(36 downto 32));
					alu_out(47 downto 32)<=r1(47 downto 32) SLL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(20 downto 16));
					alu_out(31 downto 16)<=r1(31 downto 16) SLL bits_of_shift;
					bits_of_shift:=to_unsigned(r2(4 downto 0));
					alu_out(15 downto 0)<=r1(15 downto 10) SLL bits_of_shift;
				
				---------SFH: subtract from halfword immediate
				when "---10000" =>
					alu_out(127 downto 112)<=std_logic_vector(unsigned(r2(127 downto 112))-unsigned(r2(127 downto 112)),16);
					alu_out(111 downto 96)<=std_logic_vector(unsigned(r2(111 downto 96))-unsigned(r2(111 downto 96)),16);
					alu_out(95 downto 80)<=std_logic_vector(unsigned(r2(95 downto 80))-unsigned(r2(95 downto 80)),16);
					alu_out(79 downto 64)<=std_logic_vector(unsigned(r2(79 downto 64))-unsigned(r2(79 downto 64)),16);
					alu_out(63 downto 48)<=std_logic_vector(unsigned(r2(63 downto 48))-unsigned(r2(63 downto 48)),16);
					alu_out(47 downto 32)<=std_logic_vector(unsigned(r2(47 downto 32))-unsigned(r2(47 downto 32)),16);
					alu_out(31 downto 16)<=std_logic_vector(unsigned(r2(31 downto 16))-unsigned(r2(31 downto 16)),16);
					alu_out(15 downto 0)<=std_logic_vector(unsigned(r2(15 downto 0))-unsigned(r2(15 downto 0)),16);
				
				---------SFW: subtract from word
				when "---10001" =>
					alu_out(127 downto 96)<=std_logic_vector(unsigned(r2(127 downto 96))-unsigned(r2(127 downto 96)),32);
					alu_out(95 downto 64)<=std_logic_vector(unsigned(r2(95 downto 64))-unsigned(r2(95 downto 64)),32);
					alu_out(63 downto 32)<=std_logic_vector(unsigned(r2(63 downto 32))-unsigned(r2(63 downto 32)),32);
					alu_out(31 downto 0)<=std_logic_vector(unsigned(r2(31 downto 0))-unsigned(r2(31 downto 0)),32);
					
				---------SFHS: subtract from halfword saturated
				---------saturation??
				when "---10010" =>
					alu_out(127 downto 112)<=std_logic_vector(signed(r2(127 downto 112))-signed(r2(127 downto 112)),16);
					alu_out(111 downto 96)<=std_logic_vector(signed(r2(111 downto 96))-signed(r2(111 downto 96)),16);
					alu_out(95 downto 80)<=std_logic_vector(signed(r2(95 downto 80))-signed(r2(95 downto 80)),16);
					alu_out(79 downto 64)<=std_logic_vector(signed(r2(79 downto 64))-signed(r2(79 downto 64)),16);
					alu_out(63 downto 48)<=std_logic_vector(signed(r2(63 downto 48))-signed(r2(63 downto 48)),16);
					alu_out(47 downto 32)<=std_logic_vector(signed(r2(47 downto 32))-signed(r2(47 downto 32)),16);
					alu_out(31 downto 16)<=std_logic_vector(signed(r2(31 downto 16))-signed(r2(31 downto 16)),16);
					alu_out(15 downto 0)<=std_logic_vector(signed(r2(15 downto 0))-signed(r2(15 downto 0)),16);
				
				---------XOR: bitwise logical exclusive-or
				when "---10011" =>
					alu_out => r1 xor r2;
				
			end case;
		end if;	
	end process;

end behavioral;

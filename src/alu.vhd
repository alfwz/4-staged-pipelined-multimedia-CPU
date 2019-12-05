
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;

entity alu is
	port(
	r1: in std_logic_vector(127 downto 0);
	r2: in std_logic_vector(127 downto 0);
	r3: in std_logic_vector(127 downto 0);
	ins: in std_logic_vector(24 downto 0);		 
	clk : in std_logic;
	ins_out: out std_logic_vector(24 downto 0);
	alu_out: out std_logic_vector(127 downto 0)
	);
end alu;

architecture behavioral of alu is  
begin	  
	process(r1, r2, r3, ins,clk)
		variable temp1, temp2: std_logic_vector(31 downto 0);  
		variable temp3, temp4: std_logic_vector(63 downto 0);
		variable zero_count : integer;
		variable one_count : integer;
		variable bits_of_shift : integer;
	begin  
		if rising_edge(clk)	then
			
		ins_out<=ins;
		
		------------------4.1 load imm instruction-------------------------	
		if ins(24) = '0' then 
			if ins(23 downto 21) = "000" then
			alu_out <= r1;
			alu_out(15 downto 0) <= ins(20 downto 5);	
			elsif ins(23 downto 21) = "001" then
			alu_out <= r1;
			alu_out(31 downto 16) <= ins(20 downto 5);
			elsif ins(23 downto 21) = "010" then
			alu_out <= r1;
			alu_out(47 downto 32) <= ins(20 downto 5);
			elsif ins(23 downto 21) = "011" then
			alu_out <= r1;
			alu_out(63 downto 48) <= ins(20 downto 5);
			elsif ins(23 downto 21) = "100" then
			alu_out <= r1;
			alu_out(79 downto 64) <= ins(20 downto 5);
			elsif ins(23 downto 21) = "101" then
			alu_out <= r1;
			alu_out(95 downto 80) <= ins(20 downto 5);
			elsif ins(23 downto 21) = "110" then
			alu_out <= r1;
			alu_out(111 downto 96) <= ins(20 downto 5);
			elsif ins(23 downto 21) = "111" then
			alu_out <= r1;
			alu_out(127 downto 112) <= ins(20 downto 5);
			end if;	  				   
	
		------------------4.2 R4 instruction---------------------------
		-----------saturation??
			elsif ins(24 downto 23) = "10" then 	   
			
				case ins(22 downto 20) is 
					-----Signed Integer Multiply-Add Low with Saturation------------------
					when "000" => 
					temp1:=std_logic_vector(signed(r2(111 downto 96))* signed(r3(111 downto 96)));
					temp2:=std_logic_vector(signed(temp1) + signed(r1(127 downto 96)));
					if temp2(31)='1' and temp1(31)='0' and r1(127)='0' then
						alu_out(127 downto 96)<=(others=>'1');
						alu_out(127)<='0';
					elsif temp2(31)='0' and temp1(31)='1' and r1(127)='1' then
						alu_out(127 downto 96)<=(others=>'0');
						alu_out(127)<='1';
					else
						alu_out(127 downto 96)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(79 downto 64))* signed(r3(79 downto 64)));
					temp2:=std_logic_vector(signed(temp1) + signed(r1(95 downto 64)));
					if temp2(31)='1' and temp1(31)='0' and r1(95)='0' then
						alu_out(95 downto 64)<=(others=>'1');
						alu_out(95)<='0';
					elsif temp2(31)='0' and temp1(31)='1' and r1(95)='1' then
						alu_out(95 downto 64)<=(others=>'0');
						alu_out(95)<='1';
					else
						alu_out(95 downto 64)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(47 downto 32))* signed(r3(47 downto 32)));
					temp2:=std_logic_vector(signed(temp1) + signed(r1(63 downto 32)));
					if temp2(31)='1' and temp1(31)='0' and r1(63)='0' then
						alu_out(63 downto 32)<=(others=>'1');
						alu_out(63)<='0';
					elsif temp2(31)='0' and temp1(31)='1' and r1(63)='1' then
						alu_out(63 downto 32)<=(others=>'0');
						alu_out(63)<='1';
					else
						alu_out(63 downto 32)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(15 downto 0))* signed(r3(15 downto 0)));
					temp2:=std_logic_vector(signed(temp1) + signed(r1(31 downto 0)));
					if temp2(31)='1' and temp1(31)='0' and r1(31)='0' then
						alu_out(31 downto 0)<=(others=>'1');
						alu_out(31)<='0';
					elsif temp2(31)='0' and temp1(31)='1' and r1(31)='1' then
						alu_out(31 downto 0)<=(others=>'0');
						alu_out(31)<='1';
					else
						alu_out(31 downto 0)<=temp2;
					end if;
					--------Signed Integer Multiply-Add High with Saturation---------------
					when "001" =>
					temp1:=std_logic_vector(signed(r2(127 downto 112))* signed(r3(127 downto 112)));
					temp2:=std_logic_vector(signed(temp1) + signed(r1(127 downto 96)));
					if temp2(31)='1' and temp1(31)='0' and r1(127)='0' then
						alu_out(127 downto 96)<=(others=>'1');
						alu_out(127)<='0';
					elsif temp2(31)='0' and temp1(31)='1' and r1(127)='1' then
						alu_out(127 downto 96)<=(others=>'0');
						alu_out(127)<='1';
					else
						alu_out(127 downto 96)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(95 downto 80))* signed(r3(95 downto 80)));
					temp2:=std_logic_vector(signed(temp1) + signed(r1(95 downto 64)));
					if temp2(31)='1' and temp1(31)='0' and r1(95)='0' then
						alu_out(95 downto 64)<=(others=>'1');
						alu_out(95)<='0';
					elsif temp2(31)='0' and temp1(31)='1' and r1(95)='1' then
						alu_out(95 downto 64)<=(others=>'0');
						alu_out(95)<='1';
					else
						alu_out(95 downto 64)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(63 downto 48))* signed(r3(63 downto 48)));
					temp2:=std_logic_vector(signed(temp1) + signed(r1(63 downto 32)));
					if temp2(31)='1' and temp1(31)='0' and r1(63)='0' then
						alu_out(63 downto 32)<=(others=>'1');
						alu_out(63)<='0';
					elsif temp2(31)='0' and temp1(31)='1' and r1(63)='1' then
						alu_out(63 downto 32)<=(others=>'0');
						alu_out(63)<='1';
					else
						alu_out(63 downto 32)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(31 downto 16))* signed(r3(31 downto 16)));
					temp2:=std_logic_vector(signed(temp1) + signed(r1(31 downto 0)));
					if temp2(31)='1' and temp1(31)='0' and r1(31)='0' then
						alu_out(31 downto 0)<=(others=>'1');
						alu_out(31)<='0';
					elsif temp2(31)='0' and temp1(31)='1' and r1(31)='1' then
						alu_out(31 downto 0)<=(others=>'0');
						alu_out(31)<='1';
					else
						alu_out(31 downto 0)<=temp2;
					end if;	
					----------Signed Integer Multiply-Subtract Low with Saturation-------------
					when "010" =>  
					temp1:=std_logic_vector(signed(r2(111 downto 96))*signed(r3(111 downto 96)));
					temp2:=std_logic_vector(signed(r1(127 downto 96))-signed(temp1));
					if temp2(31)='1' and temp1(31)='1' and r1(127)='0' then
						alu_out(127 downto 96)<=(others=>'1');
						alu_out(127)<='0';
					elsif temp2(31)='0' and temp1(31)='0' and r1(127)='1' then
						alu_out(127 downto 96)<=(others=>'0');
						alu_out(127)<='1';
					else
						alu_out(127 downto 96)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(79 downto 64))* signed(r3(79 downto 64)));
					temp2:=std_logic_vector(signed(r1(95 downto 64)) - signed(temp1));
					if temp2(31)='1' and temp1(31)='1' and r1(95)='0' then
						alu_out(95 downto 64)<=(others=>'1');
						alu_out(95)<='0';
					elsif temp2(31)='0' and temp1(31)='0' and r1(95)='1' then
						alu_out(95 downto 64)<=(others=>'0');
						alu_out(95)<='1';
					else
						alu_out(95 downto 64)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(47 downto 32))* signed(r3(47 downto 32)));
					temp2:=std_logic_vector(signed(r1(63 downto 32)) - signed(temp1));
					if temp2(31)='1' and temp1(31)='1' and r1(63)='0' then
						alu_out(63 downto 32)<=(others=>'1');
						alu_out(63)<='0';
					elsif temp2(31)='0' and temp1(31)='0' and r1(63)='1' then
						alu_out(63 downto 32)<=(others=>'0');
						alu_out(63)<='1';
					else
						alu_out(63 downto 32)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(15 downto 0))* signed(r3(15 downto 0)));
					temp2:=std_logic_vector(signed(r1(31 downto 0)) - signed(temp1));
					if temp2(31)='1' and temp1(31)='1' and r1(31)='0' then
						alu_out(31 downto 0)<=(others=>'1');
						alu_out(31)<='0';
					elsif temp2(31)='0' and temp1(31)='0' and r1(31)='1' then
						alu_out(31 downto 0)<=(others=>'0');
						alu_out(31)<='1';
					else
						alu_out(31 downto 0)<=temp2;
					end if;
	
					----------Signed Integer Multiply-Subtract High with Saturation-------------
					when "011" =>  
					temp1:=std_logic_vector(signed(r2(127 downto 112))* signed(r3(127 downto 112)));
					temp2:=std_logic_vector(signed(r1(127 downto 96)) - signed(temp1));
					if temp2(31)='1' and temp1(31)='1' and r1(127)='0' then
						alu_out(127 downto 96)<=(others=>'1');
						alu_out(127)<='0';
					elsif temp2(31)='0' and temp1(31)='0' and r1(127)='1' then
						alu_out(127 downto 96)<=(others=>'0');
						alu_out(127)<='1';
					else
						alu_out(127 downto 96)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(95 downto 80))* signed(r3(95 downto 80)));
					temp2:=std_logic_vector(signed(r1(95 downto 64)) - signed(temp1));
					if temp2(31)='1' and temp1(31)='1' and r1(95)='0' then
						alu_out(95 downto 64)<=(others=>'1');
						alu_out(95)<='0';
					elsif temp2(31)='0' and temp1(31)='0' and r1(95)='1' then
						alu_out(95 downto 64)<=(others=>'0');
						alu_out(95)<='1';
					else
						alu_out(95 downto 64)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(63 downto 48))* signed(r3(63 downto 48)));
					temp2:=std_logic_vector(signed(r1(63 downto 32)) - signed(temp1));
					if temp2(31)='1' and temp1(31)='1' and r1(63)='0' then
						alu_out(63 downto 32)<=(others=>'1');
						alu_out(63)<='0';
					elsif temp2(31)='0' and temp1(31)='0' and r1(63)='1' then
						alu_out(63 downto 32)<=(others=>'0');
						alu_out(63)<='1';
					else
						alu_out(63 downto 32)<=temp2;
					end if;
					
					temp1:=std_logic_vector(signed(r2(31 downto 16))* signed(r3(31 downto 16)));
					temp2:=std_logic_vector(signed(r1(31 downto 0)) - signed(temp1));
					if temp2(31)='1' and temp1(31)='1' and r1(31)='0' then
						alu_out(31 downto 0)<=(others=>'1');
						alu_out(31)<='0';
					elsif temp2(31)='0' and temp1(31)='0' and r1(31)='1' then
						alu_out(31 downto 0)<=(others=>'0');
						alu_out(31)<='1';
					else
						alu_out(31 downto 0)<=temp2;
					end if;	
					
					---------Signed Long Integer Multiply-Add Low with Saturation--------------
					when "100" =>
					temp3:=std_logic_vector(signed(r2(95 downto 64))* signed(r3(95 downto 64)));
					temp4:=std_logic_vector(signed(temp3) + signed(r1(127 downto 64)));
					if temp4(63)='1' and temp3(63)='0' and r1(127)='0' then
						alu_out(127 downto 64)<=(others=>'1');
						alu_out(127)<='0';
					elsif temp4(63)='0' and temp3(63)='1' and r1(127)='1' then
						alu_out(127 downto 64)<=(others=>'0');
						alu_out(127)<='1';
					else
						alu_out(127 downto 64)<=temp4;
					end if;
					
					temp3:=std_logic_vector(signed(r2(31 downto 0))* signed(r3(31 downto 0)));
					temp4:=std_logic_vector(signed(temp3) + signed(r1(63 downto 0)));
					if temp4(63)='1' and temp3(63)='0' and r1(63)='0' then
						alu_out(63 downto 0)<=(others=>'1');
						alu_out(63)<='0';
					elsif temp4(63)='0' and temp3(63)='1' and r1(63)='1' then
						alu_out(63 downto 0)<=(others=>'0');
						alu_out(63)<='1';
					else
						alu_out(63 downto 0)<=temp4;
					end if;
					-----------Signed Long Integer Multiply-Add High with Saturation------------
					when "101" =>
						temp3:=std_logic_vector(signed(r2(127 downto 96))* signed(r3(127 downto 96)));
					temp4:=std_logic_vector(signed(temp3) + signed(r1(127 downto 64)));
					if temp4(63)='1' and temp3(63)='0' and r1(127)='0' then
						alu_out(127 downto 64)<=(others=>'1');
						alu_out(127)<='0';
					elsif temp4(63)='0' and temp3(63)='1' and r1(127)='1' then
						alu_out(127 downto 64)<=(others=>'0');
						alu_out(127)<='1';
					else
						alu_out(127 downto 64)<=temp4;
					end if;
					
					temp3:=std_logic_vector(signed(r2(63 downto 32))* signed(r3(63 downto 32)));
					temp4:=std_logic_vector(signed(temp3) + signed(r1(63 downto 0)));
					if temp4(63)='1' and temp3(63)='0' and r1(63)='0' then
						alu_out(63 downto 0)<=(others=>'1');
						alu_out(63)<='0';
					elsif temp4(63)='0' and temp3(63)='1' and r1(63)='1' then
						alu_out(63 downto 0)<=(others=>'0');
						alu_out(63)<='1';
					else
						alu_out(63 downto 0)<=temp4;
					end if;
					-----------Signed Long Integer Multiply-Subtract Low with Saturation------------
					when "110" =>
					temp3:=std_logic_vector(signed(r2(95 downto 64))* signed(r3(95 downto 64)));
					temp4:=std_logic_vector(signed(r1(127 downto 64))- signed(temp3));
					if temp4(63)='1' and temp3(63)='1' and r1(127)='0' then
						alu_out(127 downto 64)<=(others=>'1');
						alu_out(127)<='0';
					elsif temp4(63)='0' and temp3(63)='0' and r1(127)='1' then
						alu_out(127 downto 64)<=(others=>'0');
						alu_out(127)<='1';
					else
						alu_out(127 downto 64)<=temp4;
					end if;
					
					temp3:=std_logic_vector(signed(r2(31 downto 0))* signed(r3(31 downto 0)));
					temp4:=std_logic_vector(signed(r1(63 downto 0))-signed(temp3));
					if temp4(63)='1' and temp3(63)='1' and r1(63)='0' then
						alu_out(63 downto 0)<=(others=>'1');
						alu_out(63)<='0';
					elsif temp4(63)='0' and temp3(63)='0' and r1(63)='1' then
						alu_out(63 downto 0)<=(others=>'0');
						alu_out(63)<='1';
					else
						alu_out(63 downto 0)<=temp4;
					end if;
					------------Signed Long Integer Multiply-Subtract High with Saturation-----------
					when "111" =>
					temp3:=std_logic_vector(signed(r2(127 downto 96))* signed(r3(127 downto 96)));
					temp4:=std_logic_vector(signed(r1(127 downto 64))- signed(temp3));
					if temp4(63)='1' and temp3(63)='1' and r1(127)='0' then
						alu_out(127 downto 64)<=(others=>'1');
						alu_out(127)<='0';
					elsif temp4(63)='0' and temp3(63)='0' and r1(127)='1' then
						alu_out(127 downto 64)<=(others=>'0');
						alu_out(127)<='1';
					else
						alu_out(127 downto 64)<=temp4;
					end if;
					
					temp3:=std_logic_vector(signed(r2(63 downto 32))* signed(r3(63 downto 32)));
					temp4:=std_logic_vector(signed(r1(63 downto 0))-signed(temp3));
					if temp4(63)='1' and temp3(63)='0' and r1(63)='1' then
						alu_out(63 downto 0)<=(others=>'1');
						alu_out(63)<='0';
					elsif temp4(63)='0' and temp3(63)='1' and r1(63)='0' then
						alu_out(63 downto 0)<=(others=>'0');
						alu_out(63)<='1';
					else
						alu_out(63 downto 0)<=temp4;
					end if;
					when others	 => null;	
				
				end case;
			
			
		-----------------4.3 R3 instruction------------------------------------
			elsif ins(24 downto 23) = "11" then 
			case ins(19 downto 15) is
				----------NOP---------
				when "00000" =>	 null; 
				--------A: add word---------
				when "00001" =>
					alu_out(127 downto 96)<=std_logic_vector(unsigned(r2(127 downto 96))+unsigned(r1(127 downto 96)));
					alu_out(95 downto 64)<=std_logic_vector(unsigned(r2(95 downto 64))+unsigned(r1(95 downto 64)));
					alu_out(63 downto 32)<=std_logic_vector(unsigned(r2(63 downto 32))+unsigned(r1(63 downto 32)));
					alu_out(31 downto 0)<=std_logic_vector(unsigned(r2(31 downto 0))+ unsigned(r1(31 downto 0)));	
				----AH: add halfword--
				when "00010" =>
					alu_out(127 downto 112)<=std_logic_vector(unsigned(r2(127 downto 112))+unsigned(r1(127 downto 112)));
					alu_out(111 downto 96)<=std_logic_vector(unsigned(r2(111 downto 96))+unsigned(r1(111 downto 96)));
					alu_out(95 downto 80)<=std_logic_vector(unsigned(r2(95 downto 80))+unsigned(r1(95 downto 80)));
					alu_out(79 downto 64)<=std_logic_vector(unsigned(r2(79 downto 64))+unsigned(r1(79 downto 64)));
					alu_out(63 downto 48)<=std_logic_vector(unsigned(r2(63 downto 48))+unsigned(r1(63 downto 48)));
					alu_out(47 downto 32)<=std_logic_vector(unsigned(r2(47 downto 32))+unsigned(r1(47 downto 32)));
					alu_out(31 downto 16)<=std_logic_vector(unsigned(r2(31 downto 16))+unsigned(r1(31 downto 16)));
					alu_out(15 downto 0)<=std_logic_vector(unsigned(r2(15 downto 0))+unsigned(r1(15 downto 0))); 
				----AHS: add halfword saturated
				when "00011" =>
				alu_out(127 downto 112)<=std_logic_vector(signed(r2(127 downto 112)) + signed(r1(127 downto 112)));	 
				if alu_out(127)='1' and r2(127) = '0' and r1(127) = '0' then 									  
					alu_out(127 downto 112)<=(others=>'1');
					alu_out(127)<='0'; 
				elsif alu_out(127) ='0' and r2(127) ='1' and r1(127)='1' then
					alu_out(127 downto 112)<=(others=>'0');
					alu_out(127)<='1';
				end if;
				alu_out(111 downto 96)<=std_logic_vector(signed(r2(111 downto 96))+signed(r1(111 downto 96)));
				if alu_out(111)='1' and r2(111) = '0' and r1(111) = '0' then 									  
					alu_out(111 downto 96)<=(others=>'1');
					alu_out(111)<='0'; 
				elsif alu_out(111) ='0' and r2(111) ='1' and r1(111)='1' then
					alu_out(111 downto 96)<=(others=>'0');
					alu_out(111)<='1';
				end if;
				alu_out(95 downto 80)<=std_logic_vector(signed(r2(95 downto 80))+signed(r1(95 downto 80)));
				if alu_out(95)='1' and r2(95) = '0' and r1(95) = '0' then 									  
					alu_out(95 downto 80)<=(others=>'1');
					alu_out(95)<='0'; 
				elsif alu_out(95) ='0' and r2(95) ='1' and r1(95)='1' then
					alu_out(95 downto 80)<=(others=>'0');
					alu_out(95)<='1';
				end if;
				alu_out(79 downto 64)<=std_logic_vector(signed(r2(79 downto 64))+signed(r1(79 downto 64)));
				if alu_out(79)='1' and r2(79) = '0' and r1(79) = '0' then 									  
					alu_out(79 downto 64)<=(others=>'1');
					alu_out(79)<='0'; 
				elsif alu_out(79) ='0' and r2(79) ='1' and r1(79)='1' then
					alu_out(79 downto 64)<=(others=>'0');
					alu_out(79)<='1';
				end if;
				alu_out(63 downto 48)<=std_logic_vector(signed(r2(63 downto 48))+signed(r1(63 downto 48)));
				if alu_out(63)='1' and r2(63) = '0' and r1(63) = '0' then 									  
					alu_out(63 downto 48)<=(others=>'1');
					alu_out(63)<='0'; 
				elsif alu_out(63) ='0' and r2(63) ='1' and r1(63)='1' then
					alu_out(63 downto 48)<=(others=>'0');
					alu_out(63)<='1';
				end if;
				alu_out(47 downto 32)<=std_logic_vector(signed(r2(47 downto 32))+signed(r1(47 downto 32)));
				if alu_out(47)='1' and r2(47) = '0' and r1(32) = '0' then 									  
					alu_out(47 downto 32)<=(others=>'1');
					alu_out(47)<='0'; 
				elsif alu_out(47) ='0' and r2(47) ='1' and r1(32)='1' then
					alu_out(47 downto 32)<=(others=>'0');
					alu_out(47)<='1';
				end if;
				alu_out(31 downto 16)<=std_logic_vector(signed(r2(31 downto 16))+signed(r1(31 downto 16)));	
				if alu_out(31)='1' and r2(31) = '0' and r1(31) = '0' then 									  
					alu_out(31 downto 16)<=(others=>'1');
					alu_out(31)<='0'; 
				elsif alu_out(31) ='0' and r2(31) ='1' and r1(31)='1' then
					alu_out(31 downto 16)<=(others=>'0');
					alu_out(31)<='1';
				end if;
				alu_out(15 downto 0)<=std_logic_vector(signed(r2(15 downto 0))+signed(r1(15 downto 0)));
				if alu_out(15)='1' and r2(15) = '0' and r1(15) = '0' then 									  
					alu_out(15 downto 0)<=(others=>'1');
					alu_out(15)<='0'; 
				elsif alu_out(15) ='0' and r2(15) ='1' and r1(15)='1' then
					alu_out(15 downto 0)<=(others=>'0');
					alu_out(15)<='1';
				end if;	 
				--------AND: bitwise logical and 
				when "00100" =>
				alu_out <= r1 and r2; 
				--------BCW: broadcast word
				when "00101" => 
				alu_out(127 downto 96)<=r1(31 downto 0);
				alu_out(95 downto 64)<=r1(31 downto 0);
				alu_out(63 downto 32)<=r1(31 downto 0);
				alu_out(31 downto 0)<=r1(31 downto 0);
				
				-------CLZ: count leading zeros in words
				when "00110" =>	  
				zero_count := 0;
					for i in 127 downto 96 loop
						if r1(i) = '0' then 
							zero_count := zero_count+1;		 
						else
							exit;
						end if;
					end loop;
					alu_out(127 downto 96) <= std_logic_vector(to_unsigned(zero_count,32));
					zero_count :=0;
					
					for i in 95 downto 64 loop
						if r1(i) = '0' then 
							zero_count := zero_count+1;
						else 
							exit;
						end if;
					end loop;
					alu_out(95 downto 64) <= std_logic_vector(to_unsigned(zero_count,32));
					zero_count :=0;
					
					for i in 63 downto 32 loop
						if r1(i) = '0' then 
							zero_count := zero_count+1;
						else 
							exit;
						end if;
					end loop;
					alu_out(63 downto 32) <= std_logic_vector(to_unsigned(zero_count,32));
					zero_count :=0;
					
					for i in 31 downto 0 loop
						if r1(i) = '0' then 
							zero_count := zero_count+1;
						else 
							exit;
						end if;
					end loop;
					alu_out(31 downto 0) <= std_logic_vector(to_unsigned(zero_count,32));
					zero_count :=0;
				---------MAX: max signed word	
				when "00111" =>
					if signed(r1(127 downto 96)) > signed(r2(127 downto 96)) then 
						alu_out(127 downto 96)<= r1(127 downto 96);
						else
							alu_out(127 downto 96) <= r2(127 downto 96);
					end if;
					
					if(signed(r1(95 downto 64)) > signed(r2(95 downto 64))) then 
						alu_out(95 downto 64)<= r1(95 downto 64);
						else
							alu_out(95 downto 64) <= r2(95 downto 64);
					end if;
					
					if(signed(r1(63 downto 32)) > signed(r2(63 downto 32))) then 
						alu_out(63 downto 32)<= r1(63 downto 32);
						else
							alu_out(63 downto 32) <= r2(63 downto 32);
					end if;
					
					if(signed(r1(31 downto 0)) > signed(r2(31 downto 0))) then 
						alu_out(31 downto 0)<= r1(31 downto 0);
						else
							alu_out(31 downto 0) <= r2(31 downto 0);
					end if;
				
				
				----------MIN: min signed word
				when "01000" =>
					if (to_integer(signed(r1(127 downto 96))) > to_integer(signed(r2(127 downto 96)))) then 
						alu_out(127 downto 96)<= r2(127 downto 96);
						else
							alu_out(127 downto 96) <= r1(127 downto 96);
					end if;
					
					if signed(r1(95 downto 64)) > signed(r2(95 downto 64)) then 
						alu_out(95 downto 64)<= r2(95 downto 64);
						else
							alu_out(95 downto 64) <= r1(95 downto 64);
					end if;
					
					if signed(r1(63 downto 32)) > signed(r2(63 downto 32)) then 
						alu_out(63 downto 32)<= r2(63 downto 32);
						else
							alu_out(63 downto 32) <= r1(63 downto 32);
					end if;
					
					if signed(r1(31 downto 0)) > signed(r2(31 downto 0)) then 
						alu_out(31 downto 0)<= r2(31 downto 0);
						else
							alu_out(31 downto 0) <= r1(31 downto 0);
					end if;
					
					
				---------MSGN: multiply signed
				-----???
				when "01001" =>
				if to_integer(signed(r1(127 downto 96)))= -2147483648 and r2(127)='1' then 
					alu_out(127 downto 96) <= (Others=>'1');
					alu_out(127)<='0'; 			 
				else
					if r2(127)='1' then 			  		   
						--signed(r1(127 downto 96)*(-1)
						alu_out(127 downto 96)<=std_logic_vector(to_signed(to_integer(signed(r1(127 downto 96)))*(-1),32));

					elsif r2(127 downto 96)="00000000000000000000000000000000" then 
						alu_out(127 downto 96)<="00000000000000000000000000000000";
					else
						alu_out(127 downto 96)<=r1(127 downto 96);
					end if;
				end if;
				
				
				if to_integer(signed(r1(95 downto 64)))= -2147483648 and (r2(127)='1') then 
					alu_out(95 downto 64)<=(Others=>'1');
					alu_out(95)<='0'; 
				else
					if(r2(95)='1') then 
						alu_out(95 downto 64)<=std_logic_vector(to_signed(to_integer(signed(r1(95 downto 64)))*(-1),32));
						elsif unsigned(r2(95 downto 64))=0 then 
						alu_out(95 downto 64)<="00000000000000000000000000000000";
						else
						alu_out(95 downto 64)<=r1(95 downto 64);
					end if;
				end if;
				
				if to_integer(signed(r1(63 downto 32)))= -2147483648 and (r2(127)='1') then 
					alu_out(63 downto 32)<=(Others=>'1');
					alu_out(63)<='0'; 
				else
					if(r2(63)='1') then
						alu_out(63 downto 32)<=std_logic_vector(to_signed(to_integer(signed(r1(63 downto 32)))*(-1),32));
						elsif unsigned(r2(63 downto 32))=0 then 
						alu_out(63 downto 32)<="00000000000000000000000000000000";
						else
						alu_out(63 downto 32)<=r1(63 downto 32);
					end if;
				end if;
				
				
				if to_integer(signed(r1(31 downto 0)))= -2147483648 and (r2(127)='1') then 
					alu_out(31 downto 0)<=(Others=>'1');
					alu_out(31)<='0'; 
				else
					if(r2(31)='1') then 
						alu_out(31 downto 0)<=std_logic_vector(to_signed(to_integer(signed(r1(31 downto 0)))*(-1),32));
						elsif unsigned(r2(31 downto 0))=0 then 
						alu_out(31 downto 0)<="00000000000000000000000000000000";
						else
						alu_out(31 downto 0)<=r1(31 downto 0);
					end if;	
				end if;
				---------MPYU: multiply unsigned
				when "01010" =>
				alu_out(127 downto 96)<=std_logic_vector(to_unsigned(to_integer(unsigned(r1(111 downto 96)))*to_integer( unsigned(r2(111 downto 96))),32));
				alu_out(95 downto 64)<=std_logic_vector(to_unsigned(to_integer(unsigned(r1(79 downto 64)))*to_integer( unsigned(r2(79 downto 64))),32));
				alu_out(63 downto 32)<=std_logic_vector(to_unsigned(to_integer(unsigned(r1(47 downto 32)))*to_integer( unsigned(r2(47 downto 32))),32));
				alu_out(31 downto 0)<=std_logic_vector(to_unsigned(to_integer(unsigned(r1(15 downto 0)))*to_integer( unsigned(r2(15 downto 0))),32));
				---------OR: bitwise logical or
				when "01011" =>
					alu_out <= r1 or r2;
					
				---------POPCNTH: count ones in halfwords
				when "01100" =>						  
				one_count := 0;
					for i in 127 downto 112 loop
						if r1(i)='1' then 
							one_count := one_count+1;
						end if;
					end loop;
					alu_out(127 downto 112) <= std_logic_vector(to_unsigned(one_count,16));
					one_count:=0;
					
					for i in 111 downto 96 loop
						if r1(i)='1' then 
							one_count := one_count +1;
						end if;
					end loop;
					alu_out(111 downto 96) <= std_logic_vector(to_unsigned(one_count,16));
					one_count:=0;
					
					for i in 95 downto 80 loop
						if r1(i)='1' then 
							one_count := one_count+1;
						end if;
					end loop;
					alu_out(95 downto 80) <= std_logic_vector(to_unsigned(one_count,16));
					one_count:=0;
					
					for i in 79 downto 64 loop
						if r1(i)='1' then 
							one_count := one_count +1;
						end if;
					end loop;
					alu_out(79 downto 64) <= std_logic_vector(to_unsigned(one_count,16));
					one_count:=0;
					
					for i in 63 downto 48 loop
						if r1(i)='1' then 
							one_count := one_count+1;
						end if;
					end loop;
					alu_out(63 downto 48) <= std_logic_vector(to_unsigned(one_count,16));
					one_count:=0;
					
					for i in 47 downto 32 loop
						if r1(i)='1' then 
							one_count := one_count +1;
						end if;
					end loop;
					alu_out(47 downto 32) <= std_logic_vector(to_unsigned(one_count,16));
					one_count:=0;
					
					for i in 31 downto 16 loop
						if r1(i)='1' then 
							one_count := one_count+1;
						end if;
					end loop;
					alu_out(31 downto 16) <= std_logic_vector(to_unsigned(one_count,16));
					one_count:=0;
					
					for i in 15 downto 0 loop
						if r1(i)='1' then 
							one_count := one_count +1;
						end if;
					end loop;
					alu_out(15 downto 0) <= std_logic_vector(to_unsigned(one_count,16));
					one_count:=0;
							
				---------ROT: rotate bits right
				when "01101" =>
					bits_of_shift:=to_integer(unsigned(r2(6 downto 0)));
					alu_out<=r1 ror bits_of_shift;
				
				---------ROTW: rotate bits in word
				when "01110" =>
					bits_of_shift:=to_integer(unsigned(r2(100 downto 96)));
					alu_out(127 downto 96)<=r1(127 downto 96) ror bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(68 downto 64)));
					alu_out(95 downto 64)<=r1(95 downto 64) ror bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(36 downto 32)));
					alu_out(63 downto 32)<=r1(63 downto 32) ror bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(4 downto 0)));
					alu_out(31 downto 0)<=r1(31 downto 0) ror bits_of_shift;
					
				---------SHLHI: shift left halfword immediate:
				------???
				when "01111" =>
					bits_of_shift:=to_integer(unsigned(r2(115 downto 112)));
					alu_out(127 downto 112)<=r1(127 downto 112) SLL bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(99 downto 96)));
					alu_out(111 downto 96)<=r1(111 downto 96) SLL bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(83 downto 80)));
					alu_out(95 downto 80)<=r1(95 downto 80) SLL bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(67 downto 64)));
					alu_out(79 downto 64)<=r1(79 downto 64) SLL bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(51 downto 48)));
					alu_out(63 downto 48)<=r1(63 downto 48) SLL bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(35 downto 32)));
					alu_out(47 downto 32)<=r1(47 downto 32) SLL bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(19 downto 16)));
					alu_out(31 downto 16)<=r1(31 downto 16) SLL bits_of_shift;
					bits_of_shift:=to_integer(unsigned(r2(3 downto 0)));
					alu_out(15 downto 0)<=r1(15 downto 0) SLL bits_of_shift;
				
				---------SFH: subtract from halfword immediate
				when "10000" =>
				alu_out(127 downto 112)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(127 downto 112)))-to_integer(unsigned(r2(127 downto 112))),16));
				alu_out(111 downto 96)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(111 downto 96)))-to_integer(unsigned(r2(111 downto 96))),16));
				alu_out(95 downto 80)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(95 downto 80)))-to_integer(unsigned(r2(95 downto 80))),16));
				alu_out(79 downto 64)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(79 downto 64)))-to_integer(unsigned(r2(79 downto 64))),16));
				alu_out(63 downto 48)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(63 downto 48)))-to_integer(unsigned(r2(63 downto 48))),16));
				alu_out(47 downto 32)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(47 downto 32)))-to_integer(unsigned(r2(47 downto 32))),16));
				alu_out(31 downto 16)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(31 downto 16)))-to_integer(unsigned(r2(31 downto 16))),16));
				alu_out(15 downto 0)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(15 downto 0)))-to_integer(unsigned(r2(15 downto 0))),16));
				
				---------SFW: subtract from word
				when "10001" =>	
				alu_out(127 downto 96)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(127 downto 96)))-to_integer(unsigned(r2(127 downto 96))),32));
				alu_out(95 downto 64)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(95 downto 64)))-to_integer(unsigned(r2(95 downto 64))),32));
				alu_out(63 downto 32)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(63 downto 32)))-to_integer(unsigned(r2(63 downto 32))),32));
				alu_out(31 downto 0)<=std_logic_vector(to_unsigned(to_integer(unsigned(r2(31 downto 0)))-to_integer(unsigned(r2(31 downto 0))),32));
					
				---------SFHS: subtract from halfword saturated
				---------saturation??
				when "10010" =>
				alu_out(127 downto 112)<=std_logic_vector(signed(r2(127 downto 112)) - signed(r1(127 downto 112)));	 
				if alu_out(127)='0' and r2(127)='1' and r1(127)='0'  then  
					alu_out(127 downto 112) <= (others=>'0');
					alu_out(127)<='1';
				elsif alu_out(127)='1' and r2(127)='0' and r2(127)='1' then 
					alu_out(127 downto 112) <= (others=>'1');
					alu_out(127)<='0';
				end if;	
				
				alu_out(111 downto 96)<=std_logic_vector(signed(r2(111 downto 96))-signed(r1(111 downto 96)));
				if alu_out(111)='0' and r2(111)='1' and r1(111)='0'  then  
					alu_out(111 downto 96) <= (others=>'0');
					alu_out(111)<='1';
				elsif alu_out(111)='1' and r2(111)='0' and r2(111)='1' then 
					alu_out(111 downto 96) <= (others=>'1');
					alu_out(111)<='0';
				end if;
				
				alu_out(95 downto 80)<=std_logic_vector(signed(r2(95 downto 80))-signed(r1(95 downto 80)));
				if alu_out(95)='0' and r2(95)='1' and r1(95)='0'  then  
					alu_out(95 downto 80) <= (others=>'0');
					alu_out(95)<='1';
				elsif alu_out(95)='1' and r2(95)='0' and r2(95)='1' then 
					alu_out(95 downto 80) <= (others=>'1');
					alu_out(95)<='0';
				end if;
				
				alu_out(79 downto 64)<=std_logic_vector(signed(r2(79 downto 64))-signed(r1(79 downto 64)));
				if alu_out(79)='0' and r2(79)='1' and r1(79)='0'  then  
					alu_out(79 downto 64) <= (others=>'0');
					alu_out(79)<='1';
				elsif alu_out(79)='1' and r2(79)='0' and r2(79)='1' then 
					alu_out(79 downto 64) <= (others=>'1');
					alu_out(79)<='0';
				end if;
				
				alu_out(63 downto 48)<=std_logic_vector(signed(r2(63 downto 48))-signed(r1(63 downto 48)));
				if alu_out(63)='0' and r2(63)='1' and r1(63)='0'  then  
					alu_out(63 downto 48) <= (others=>'0');
					alu_out(63)<='1';
				elsif alu_out(63)='1' and r2(63)='0' and r2(63)='1' then 
					alu_out(63 downto 48) <= (others=>'1');
					alu_out(63)<='0';
				end if;
				
				alu_out(47 downto 32)<=std_logic_vector(signed(r2(47 downto 32))-signed(r1(47 downto 32)));
				if alu_out(47)='0' and r2(47)='1' and r1(47)='0'  then  
					alu_out(47 downto 32) <= (others=>'0');
					alu_out(47)<='1';
				elsif alu_out(47)='1' and r2(47)='0' and r2(47)='1' then 
					alu_out(47 downto 32) <= (others=>'1');
					alu_out(47)<='0';
				end if;
				
				alu_out(31 downto 16)<=std_logic_vector(signed(r2(31 downto 16))-signed(r1(31 downto 16)));	
				if alu_out(31)='0' and r2(31)='1' and r1(31)='0'  then  
					alu_out(31 downto 16) <= (others=>'0');
					alu_out(31)<='1';
				elsif alu_out(31)='1' and r2(31)='0' and r2(31)='1' then 
					alu_out(31 downto 16) <= (others=>'1');
					alu_out(31)<='0';
				end if;
				
				alu_out(15 downto 0)<=std_logic_vector(signed(r2(15 downto 0))-signed(r1(15 downto 0)));
				if alu_out(15)='0' and r2(15)='1' and r1(15)='0'  then  
					alu_out(15 downto 0) <= (others=>'0');
					alu_out(15)<='1';
				elsif alu_out(15)='1' and r2(15)='0' and r2(15)='1' then 
					alu_out(15 downto 0) <= (others=>'1');
					alu_out(15)<='0';
				end if;
			
				---------XOR: bitwise logical exclusive-or
				when "10011" =>
				alu_out <= r1 xor r2;	  
				when others => null;
				
			end case;
		end if;	  
		end if;
	end process;

end behavioral;
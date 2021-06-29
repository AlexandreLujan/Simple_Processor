library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY ROM IS
	PORT ( 
		address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);         
		data : OUT STD_LOGIC_VECTOR(10 DOWNTO 0) 
	);
END ENTITY;

ARCHITECTURE behavioral OF ROM IS
	TYPE mem IS ARRAY ( 0 TO 2**4 - 1) OF STD_LOGIC_VECTOR(10 DOWNTO 0);
	
	CONSTANT my_Rom : mem := (
		0  => "00000100011", -- SET IMM 35
		1  => "00100000001", -- ADD IMM 1
		2  => "01000000010", -- SUB IMM 2
		3  => "101----0101", -- STORE IMM 5
		4  => "100----0101", -- LOAD IMM 5
		5  => "011--------", -- DEBUG 34 (Stop)
		6  => "00000001010", -- SET IMM 10
		7  => "00100000001", -- ADD IMM 1
		8  => "00000001010", -- SET IMM 10
		9  => "00100000001", -- ADD IMM 1
		10 => "01100000000", -- DEBUG 11
		11 => "00000001011", -- SET IMM 11
		12 => "00100000001", -- ADD IMM 1
		13 => "01100000000", -- DEBUG 12
		14 => "00000001100", -- SET IMM 12
		15 => "00100000001"  -- ADD IMM 1
	);
	
BEGIN

	PROCESS (address)
	BEGIN
	
		CASE address IS
			WHEN "0000" => data <= my_rom(0);
			WHEN "0001" => data <= my_rom(1);
			WHEN "0010" => data <= my_rom(2);
			WHEN "0011" => data <= my_rom(3);
			WHEN "0100" => data <= my_rom(4);
			WHEN "0101" => data <= my_rom(5);
			WHEN "0110" => data <= my_rom(6);
			WHEN "0111" => data <= my_rom(7);
			WHEN "1000" => data <= my_rom(8);
			WHEN "1001" => data <= my_rom(9);
			WHEN "1010" => data <= my_rom(10);
			WHEN "1011" => data <= my_rom(11);
			WHEN "1100" => data <= my_rom(12);
			WHEN "1101" => data <= my_rom(13);
			WHEN "1110" => data <= my_rom(14);
			WHEN "1111" => data <= my_rom(15);
			WHEN OTHERS => data <= "ZZZZZZZZZZZ"; 
		END CASE;
	END PROCESS;
	
END ARCHITECTURE;
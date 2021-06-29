library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

ENTITY PC_UNITY IS
	PORT(
		Enable_PC : IN  STD_LOGIC;
		Clock     : IN  STD_LOGIC;
		Address   : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
END PC_UNITY;

ARCHITECTURE RTL OF PC_UNITY IS

  SIGNAL count: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
  
BEGIN
 
	PROCESS(Clock, Enable_PC)
	BEGIN
		IF(rising_edge(Clock) AND Enable_PC = '1') THEN 
			count <= count + '1';
		END IF;
	END PROCESS;

	Address <= count;
 
END RTL;
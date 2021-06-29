library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY TESTBENCH IS
END ENTITY;

ARCHITECTURE RTL OF TESTBENCH IS

	SIGNAL clock_gen : STD_LOGIC;
		
	COMPONENT TOP
	PORT(
		CLOCK : IN STD_LOGIC
	);
	END COMPONENT;
	
BEGIN

	TOP_0 : TOP
	PORT MAP(        
		CLOCK  => clock_gen
	);
	
	PROCESS
	BEGIN
		for i in 1 to 20 loop
			clock_gen <= '0';
         wait for 10 ns;
         clock_gen <= '1';
			wait for 10ns;
		end loop;
		wait;
	END PROCESS;
	
END ARCHITECTURE;
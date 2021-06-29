library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reg8 is
	port ( 
		ENABLE : in  STD_LOGIC; 
		RESET  : in  STD_LOGIC;
		CLOCK  : in  STD_LOGIC;
		D      : in  STD_LOGIC_VECTOR (7 downto 0);
		Q      : out STD_LOGIC_VECTOR (7 downto 0)
	);
end reg8 ;
	
architecture RTL of reg8 is

BEGIN
    process(CLOCK, RESET)
    begin
        if RESET = '1' then
            Q <= "00000000";
        elsif rising_edge(CLOCK) then
            if ENABLE = '1' then
                Q <= D;
            end if;
        end if;
    end process;	
	
end RTL ;
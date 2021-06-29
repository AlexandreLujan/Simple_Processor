LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bidir IS
    PORT(
        bidir   : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        oe      : IN STD_LOGIC;
        inp     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        outp    : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END bidir;

ARCHITECTURE RTL OF bidir IS

BEGIN 
    PROCESS (oe, bidir, inp)          
        BEGIN                   
        IF( oe = '0') THEN
            bidir <= "ZZZZZZZZ";
            outp <= bidir;
        ELSE
            bidir <= inp; 
            outp <= bidir;
        END IF;
    END PROCESS;
END RTL;
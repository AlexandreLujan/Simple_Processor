library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;

ENTITY ULA IS 
	PORT (        
		op         : IN STD_LOGIC_VECTOR(2 DOWNTO 0);        
		imm     	  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);        
		clk    	  : IN STD_LOGIC;
		Enable_REG : IN STD_LOGIC;
		datain  	  : IN STD_LOGIC_VECTOR(7 downto 0);
		dataout    : OUT STD_LOGIC_VECTOR(7 downto 0);
		address    : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
END ENTITY;

ARCHITECTURE RTL OF ULA IS 

	SIGNAL D_S, Q_S : STD_LOGIC_VECTOR(7 DOWNTO 0);

	COMPONENT reg8
	PORT (        
		ENABLE : in  STD_LOGIC; 
		RESET  : in  STD_LOGIC;
		CLOCK  : in  STD_LOGIC;
		D      : in  STD_LOGIC_VECTOR (7 downto 0);
		Q      : out STD_LOGIC_VECTOR (7 downto 0)   
	);
	END COMPONENT;

BEGIN 

	reg8_0 : reg8
	PORT MAP(
		ENABLE => Enable_REG,
		RESET  => '0', 
		CLOCK  => clk,        
		D      => D_S,     
		Q      => Q_S
	);

	PROCESS (op, imm, Q_S, datain) 
	BEGIN
	
		case op is
			when "000" => D_S     <= imm; --load imm
							  address <= "ZZZZ";
							  dataout <= "ZZZZZZZZ";
							  REPORT "load_imm: " & INTEGER'image(to_integer(UNSIGNED(Q_S))) & CR;
							  
			when "001" => D_S     <= std_logic_vector(unsigned(Q_S) + unsigned(imm)); --soma imm
							  address <= "ZZZZ";
							  dataout <= "ZZZZZZZZ";
							  REPORT "Soma: " & INTEGER'image(to_integer(UNSIGNED(Q_S))) & CR;
							  
			when "010" => D_S     <= std_logic_vector(unsigned(Q_S) - unsigned(imm)); --sub imm
							  address <= "ZZZZ";
							  dataout <= "ZZZZZZZZ";
							  REPORT "Sub: " & INTEGER'image(to_integer(UNSIGNED(Q_S))) & CR;
							  
			when "011" => D_S     <= Q_S; --print terminal
							  address <= "ZZZZ";
							  dataout <= "ZZZZZZZZ";
							  REPORT "Debug: " & INTEGER'image(to_integer(UNSIGNED(Q_S))) & CR;
							  
			when "100" => D_S     <= datain; --load ram
							  dataout <= "ZZZZZZZZ";
							  address <= imm(3 downto 0);
							  REPORT "Load_RAM: " & INTEGER'image(to_integer(UNSIGNED(Q_S))) & CR;
							  
			when "101" => D_S     <= Q_S; --store ram
			              dataout <= Q_S;
							  address <= imm(3 downto 0);
							  REPORT "Store_RAM: " & INTEGER'image(to_integer(UNSIGNED(Q_S))) & CR;
							  						  
			when others => D_S     <= "ZZZZZZZZ";
							   address <= "ZZZZ";
							   dataout <= "ZZZZZZZZ";
		end case;
	
	END PROCESS;
	
END ARCHITECTURE;
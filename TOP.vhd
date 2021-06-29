library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY TOP IS
	PORT(
		CLOCK : IN STD_LOGIC
	);
END TOP;

ARCHITECTURE RTL OF TOP IS

	SIGNAL S_ADDRESS_RAM, S_ADDRESS_ROM      					 : STD_LOGIC_VECTOR (3 DOWNTO 0);
	SIGNAL S_DATA_ROM         				     					 : STD_LOGIC_VECTOR (10 DOWNTO 0);
	SIGNAL S_DATA_RAM_IN, S_DATA_RAM_OUT     					 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL S_DATA_ULA_IN, S_DATA_ULA_OUT    					 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL S_DATA_BUS							 	  					 : STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL S_RW, S_ENABLE_PC, S_OE, S_NOT_OE, S_ENABLE_REG : STD_LOGIC;

	COMPONENT ULA
	PORT (        
		op         : IN STD_LOGIC_VECTOR(2 DOWNTO 0);        
		imm     	  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);        
		clk    	  : IN STD_LOGIC;
		Enable_REG : IN STD_LOGIC;
		datain  	  : IN STD_LOGIC_VECTOR(7 downto 0);
		dataout    : OUT STD_LOGIC_VECTOR(7 downto 0);
		address    : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
	END COMPONENT;
	
	COMPONENT Unid_Controle
	PORT ( 
			RESET      : in  STD_LOGIC;
			CLOCK      : in  STD_LOGIC;
			ENABLE_PC  : out STD_LOGIC;
			OP  	     : in  STD_LOGIC_VECTOR (2 downto 0);
			RW   	     : out STD_LOGIC;
			OE			  : out STD_LOGIC;
			ENABLE_REG : out STD_LOGIC
		 );
	END COMPONENT;
	
	COMPONENT ROM
	PORT (        
		address : IN STD_LOGIC_VECTOR(3 DOWNTO 0);         
		data : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)   
	);
	END COMPONENT;
	
	COMPONENT PC_UNITY
	PORT (        
		Enable_PC : IN  STD_LOGIC;
		Clock     : IN  STD_LOGIC;
		Address   : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
	END COMPONENT;
	
	COMPONENT sync_ram
	PORT (
		clock   : IN STD_LOGIC;
		rw      : IN STD_LOGIC; -- 0 para leitura, 1 para escrita
		address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		datain  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		dataout : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT bidir
   PORT(
      bidir   : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
      oe      : IN STD_LOGIC;
      inp     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
      outp    : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	END COMPONENT;

BEGIN

	ULA_0 : ULA
	PORT MAP( 
		op         => S_DATA_ROM (10 DOWNTO 8), 
		imm        => S_DATA_ROM (7 DOWNTO 0),        
		clk        => CLOCK,
		Enable_REG => S_ENABLE_REG,
		datain     => S_DATA_ULA_OUT,
		dataout    => S_DATA_ULA_IN,
		address    => S_ADDRESS_RAM
	);
	
	UNID_CONTROLE_0 : Unid_Controle
	PORT MAP( 
		 RESET      => '0',
		 CLOCK      => CLOCK,
		 ENABLE_PC  => S_ENABLE_PC,
		 OP         => S_DATA_ROM (10 DOWNTO 8),	   
		 RW         => S_RW,
		 OE		   => S_OE,
		 ENABLE_REG => S_ENABLE_REG
	);
	
	ROM_0 : ROM
	PORT MAP(        
		address => S_ADDRESS_ROM,
		data    => S_DATA_ROM
	);
	
	PC_UNITY_0 : PC_UNITY
	PORT MAP(
		Enable_PC => S_ENABLE_PC,
		Clock     => CLOCK,
		Address   => S_ADDRESS_ROM
	);
	
	sync_ram_0 : sync_ram
	PORT MAP(
		clock   => CLOCK,
		rw      => S_RW,
		address => S_ADDRESS_RAM,
		datain  => S_DATA_RAM_OUT,
		dataout => S_DATA_RAM_IN
	);
	
	bidir_0 : bidir
   PORT MAP(
      bidir => S_DATA_BUS,
      oe    => S_OE,
		inp   => S_DATA_ULA_IN,
      outp  => S_DATA_ULA_OUT
	);
	
	bidir_1 : bidir
   PORT MAP(
      bidir => S_DATA_BUS,
      oe    => S_NOT_OE,
		inp   => S_DATA_RAM_IN,
      outp  => S_DATA_RAM_OUT
	);
	
	S_NOT_OE <= NOT S_OE;
		
END RTL;
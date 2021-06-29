library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Control_Unit is
	port (
			RESET      : in  STD_LOGIC;
			CLOCK      : in  STD_LOGIC;
			ENABLE_PC  : out STD_LOGIC;
			OP  	     : in  STD_LOGIC_VECTOR (2 downto 0);
			RW   	     : out STD_LOGIC;
			OE			  : out STD_LOGIC;
			ENABLE_REG : out STD_LOGIC
		 );
end Control_Unit;

architecture RTL of Control_Unit is

type estado is (Init, Exec, RegX, LoadX, LoadY, Debug, Stop, StoreX, StoreY);
signal state, next_state : estado;

begin
		
	process(state, OP)
	begin
		case state is 
			when Init =>
				if((OP = "000") OR (OP = "001") OR (OP = "010")) then
					next_state <= Exec;
				elsif(OP = "011") then
					next_state <= Debug;
				elsif(OP = "100") then
					next_state <= LoadX;
				elsif(OP = "101") then
					next_state <= StoreX;
				else
					next_state <= Init;
				end if;
					
			when RegX =>
				next_state <= Init;
			when Exec =>
				next_state <= RegX;
			when Debug =>
				next_state <= Stop;
			when Stop =>
				next_state <= Stop;
			when LoadX =>
				next_state <= LoadY;
			when LoadY =>
				next_state <= RegX;	
			when StoreX =>
				next_state <= StoreY;
			when StoreY =>
				next_state <= Init;
			when others =>
				next_state <= Init;
		end case;
	end process;
	
	process(CLOCK, RESET)
	begin
		if(RESET = '1') then
			state <= Init;
		elsif (rising_edge(CLOCK)) then
			state <= next_state;
		end if;
		
	end process;
	
	ENABLE_PC <= '1' when ((state = RegX) OR (state = StoreY)) else '0';
					 
	RW <= '1' when (state = StoreX) else '0';
			
	OE <= '1' when (state = StoreX) else '0';
			
	ENABLE_REG <= '1' when ((state = LoadY) OR (state = Exec)) else '0';
	
end RTL;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sram_write is
	Port ( 
		CLOCK : in std_logic;
		
		NENABLE : in std_logic;
		ADDR : in std_logic_vector(17 downto 0);
		DATA_IN : in std_logic_vector(15 downto 0);	
		NRDY : out std_logic;
		
		--SRAM signals
		D : out std_logic_vector(15 downto 0);
		A : out std_logic_vector(17 downto 0);
		NWE, NCE, NLB, NUB, NOE: out std_logic
	);
end sram_write;

architecture fsm of sram_write is
	TYPE STATE_TYPE IS (i, w0, w1, w2, w3);
	SIGNAL state: STATE_TYPE;
	signal input_buffer : std_logic_vector(15 downto 0);
begin

FSM : process(CLOCK)
begin
	if rising_edge(CLOCK) then	
		if NENABLE = '1' then	
			A <= (others => 'Z');
			D <= (others => 'Z');
			NWE <= 'Z';
			NCE <= 'Z';
			NLB <= 'Z';
			NUB <= 'Z';
			NOE <= 'Z';
			NRDY <= '0';
			state <= i;
		else
			case state is 
				when i =>
					NCE <= '0';
					NOE <= '1';
					NWE <= '1';
					NUB <= '0';
					NLB <= '0';
					--									
					state <= w0;
					NRDY <= '1';
				when w0 =>
					input_buffer <= DATA_IN;
					D <= input_buffer;
					A <= ADDR;
					NWE <= '0';
					--					
					state <= w1;
					NRDY <= '1';
				when w1 =>
					-- just a delay
					--
					state <= w2;
					NRDY <= '1';
				when w2 =>
					-- just a delay
					--
					state <= w3;
					NRDY <= '1';
				when w3 =>		
					-- just a delay				
					--
					state <= i;	
					NRDY <= '0';					
			end case;
		end if;
	end if;
end process;

end fsm;

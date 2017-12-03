library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sram_read is
	Port ( 
		CLOCK : in std_logic;
		
		NENABLE : in std_logic;
		ADDR : in std_logic_vector(17 downto 0);
		DATA_OUT : out std_logic_vector(15 downto 0);	
		NRDY : out std_logic;
		
		--SRAM signals
		D : in std_logic_vector(15 downto 0);
		A : out std_logic_vector(17 downto 0);
		NWE, NCE, NLB, NUB, NOE: out std_logic
	);
end sram_read;

architecture fsm of sram_read is
	TYPE STATE_TYPE IS (i, r0, r1, r2, r3);
	SIGNAL state: STATE_TYPE;
	signal output_buffer : std_logic_vector(15 downto 0);
begin

FSM : process(CLOCK)
begin
	if rising_edge(CLOCK) then	
		if NENABLE = '1' then	
			A <= (others => 'Z');
			NWE <= 'Z';
			NCE <= 'Z';
			NLB <= 'Z';
			NUB <= 'Z';
			NOE <= 'Z';
			NRDY <= '0';
			state <= i;
		else
			DATA_OUT <= output_buffer;
			case state is 
				when i =>
					NCE <= '0';
					NOE <= '0';
					NWE <= '1';
					NUB <= '0';
					NLB <= '0';
					--									
					state <= r0;
					NRDY <= '1';
				when r0 =>
					A <= ADDR;
					--					
					state <= r1;
					NRDY <= '1';
				when r1 =>
					-- just a delay
					--
					state <= r2;
					NRDY <= '1';
				when r2 =>
					-- just a delay
					--
					state <= r3;
					NRDY <= '1';
				when r3 =>
					output_buffer <= D;					
					--
					state <= i;	
					NRDY <= '0';					
			end case;
		end if;
	end if;
end process;

end fsm;

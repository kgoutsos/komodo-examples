library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity bus_control is
	Port ( 
		CLOCK : in std_logic;
		
		SW_bus : out  STD_LOGIC_VECTOR (7 downto 0);
		
		SRAM_NWR : out std_logic;
		SRAM_ADDR : out std_logic_vector(17 downto 0);
		SRAM_DATA_IN : in std_logic_vector(15 downto 0);	
		SRAM_DATA_OUT : out std_logic_vector(15 downto 0);	
		SRAM_NRDY : in std_logic
	);
end bus_control;

architecture rtl of bus_control is
	TYPE STATE_TYPE IS (i, prew, waiw, aftw, prer, wair, aftr, waftr);
	SIGNAL state: STATE_TYPE;

	signal addi : integer := 0;
	
	signal cnt : integer := 0;
	signal nwrite : std_logic := '0';
	signal wait_cnt : integer := 0;
	signal ow_cnt : integer := 0;
	
	type word_array is array (0 to 9) of std_logic_vector(0 to 15);
	signal addr_array : word_array := (
		x"3412", x"b7b8", x"3151", x"d59c", x"bbf3", 
		x"a29f", x"4aa8", x"19a3", x"fd77", x"b67e"
	);
	signal data_array : word_array := (		
		x"33a5", x"5470", x"2f71", x"3617", x"245a",
		x"d9b9", x"47a7", x"8a31", x"e3f2", x"9fa9"
	);
begin

process(CLOCK)
begin
	if rising_edge(CLOCK) then	
		case state is
			when i =>
				addi <= 0;
				cnt <= 0;
				if nwrite = '0' then
					state <= prew;
				else
					state <= prer;
				end if;
			when prew =>
				SRAM_NWR <= '0';
				SRAM_ADDR <= "00" & addr_array(cnt); 
				SRAM_DATA_OUT <= data_array(cnt); 
				--
				state <= waiw;
			when waiw =>
				if wait_cnt < 10 then
					state <= waiw;
					wait_cnt <= wait_cnt + 1;
				else
					state <= aftw;
					wait_cnt <= 0;
				end if;				
			when aftw =>
				if cnt < 10 then
					cnt <= cnt + 1;
					addi <= addi + 1;
					state <= prew;
				else
					nwrite <= '1';
					cnt <= 0;
					addi <= 0;
					state <= i;
				end if;				
			when prer =>
				SRAM_NWR <= '1';
				SRAM_ADDR <= "00" & addr_array(cnt);
				--
				state <= wair;
			when wair =>
				if wait_cnt < 10 then
					state <= wair;
					wait_cnt <= wait_cnt + 1;
				else
					state <= aftr;
					wait_cnt <= 0;
				end if;	
			when aftr =>				
				if cnt < 10 then
					cnt <= cnt + 1;
					addi <= addi + 1;
					state <= waftr;
				else
					nwrite <= '1';
					cnt <= 0;
					addi <= 0;
					state <= i;
				end if;	
			when waftr =>
				if ow_cnt < 12000000 then
					ow_cnt <= ow_cnt + 1;
					state <= waftr;
				else
					SW_bus <= SRAM_DATA_IN(7 downto 0);
					ow_cnt <= 0;
					state <= prer;
				end if;				
		end case;
	end if;
end process;

end rtl;

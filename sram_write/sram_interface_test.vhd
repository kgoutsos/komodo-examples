LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY sram_interface_sram_interface_sch_tb IS
END sram_interface_sram_interface_sch_tb;
ARCHITECTURE behavioral OF sram_interface_sram_interface_sch_tb IS 

   COMPONENT sram_interface
   PORT( SRAM_NCE	:	OUT	STD_LOGIC; 
          SRAM_NLB	:	OUT	STD_LOGIC; 
          SRAM_NUB	:	OUT	STD_LOGIC; 
          SRAM_NOE	:	OUT	STD_LOGIC; 
          SRAM_A	:	OUT	STD_LOGIC_VECTOR (17 DOWNTO 0); 
          SRAM_D	:	INOUT	STD_LOGIC_VECTOR (15 DOWNTO 0); 
          SW_bus	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          CLOCK	:	IN	STD_LOGIC; 
          SRAM_NWE	:	OUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL SRAM_NCE	:	STD_LOGIC;
   SIGNAL SRAM_NLB	:	STD_LOGIC;
   SIGNAL SRAM_NUB	:	STD_LOGIC;
   SIGNAL SRAM_NOE	:	STD_LOGIC;
   SIGNAL SRAM_A	:	STD_LOGIC_VECTOR (17 DOWNTO 0);
   SIGNAL SRAM_D	:	STD_LOGIC_VECTOR (15 DOWNTO 0);
   SIGNAL SW_bus	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL CLOCK	:	STD_LOGIC;
   SIGNAL SRAM_NWE	:	STD_LOGIC;

	constant CLOCK_period : time := 20 ns;
BEGIN

   UUT: sram_interface PORT MAP(
		SRAM_NCE => SRAM_NCE, 
		SRAM_NLB => SRAM_NLB, 
		SRAM_NUB => SRAM_NUB, 
		SRAM_NOE => SRAM_NOE, 
		SRAM_A => SRAM_A, 
		SRAM_D => SRAM_D, 
		SW_bus => SW_bus, 
		CLOCK => CLOCK, 
		SRAM_NWE => SRAM_NWE
   );

CLOCK_process :process
begin
	CLOCK <= '0';
	wait for CLOCK_period/2;
	CLOCK <= '1';
	wait for CLOCK_period/2;
end process;

END;

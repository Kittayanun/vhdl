library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PC is
	port(
		Clk	:	in	std_logic;
		Reset	:	in	std_logic;
		PC_IN	:	in	std_logic_vector(1 downto 0);
		PC_OUT:	out std_logic_vector(1 downto 0)
	);
end PC;

architecture Behav of PC is
	signal PC_reset	:	std_logic;
begin
	setPC:process(Clk)
	begin
		if (rising_edge(Clk)) then
			if (PC_reset = '1') then
				PC_OUT <= (others => '0');
			else
				PC_OUT <= PC_IN;
			end if;
		end if;
	end process setPC;
	
	resetPC:process(Reset,Clk)
	begin
		if (Reset = '1') then
			PC_reset <= '1';
		elsif ((rising_edge(clk)) and (Reset = '0')) then
			PC_reset <= '0';
		end if;
	end process resetPC;
end Behav;

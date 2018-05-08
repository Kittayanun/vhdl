LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity PC is
	port(
		clk				:	in std_logic;
		instruc		:	in	std_logic_vector(1 downto 0);
		to_instruction	:	out std_logic_vector(1 downto 0)
	);
end PC;

architecture Behav of PC is
	signal next_index : std_logic_vector(1 downto 0);
begin
	process(clk)
	begin
		if (falling_edge(clk)) then
			next_index <= std_logic_vector(unsigned(instruc) + to_unsigned(1,2));
		end if;
	end process;
	to_instruction <= next_index;
end Behav;
library ieee;
use ieee.std_logic_1164.all;

entity control is
	port(
		in_instruction	:	in std_logic_vector(1 downto 0);
		regWrite			:	out std_logic;
		ALUop				:	out std_logic_vector(1 downto 0)
	);
end control;

architecture Behav of control is
	begin
		with in_instruction select
			regWrite <= '1' when "00",		--ADD
							'1' when "01",		--SUB
							'1' when "10",		--AND
							'1' when "11";		--OR
							
		with in_instruction select
			ALUop <= "00" when "00",		--ADD
						"01" when "01",		--SUB
						"10" when "10",		--AND
						"11" when "11";		--OR
						
end Behav;
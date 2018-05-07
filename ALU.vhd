library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU is
  port(
		clk			: in std_logic;
		rn,operand 	: in std_logic_vector (7 downto 0);		--first and second register source operand
		opCode 		: in std_logic_vector (1 downto 0);		--select function
		rd 			: out std_logic_vector (7 downto 0)		--register destination operand
	);
end ALU;

architecture Behav of ALU is
	signal total : std_logic_vector(7 downto 0);
	begin
	process(clk)
		begin
			--add : rd = rn + operand
			if (opCode = "10") then
				total <= rn + operand;
				
			--sub : rd = rn - operand
			elsif (opCode = "11") then
				total <= rn - operand;
				
			end if;
			
		rd <= total;
	end process;
end Behav;
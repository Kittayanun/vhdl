library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_mem is
	port(
		pc_in	:	in		std_logic_vector(1 downto 0);
		
		rs		:	out	std_logic_vector(1 downto 0);		--first source
		rt		:	out	std_logic_vector(1 downto 0);		--second source
		rd		:	out	std_logic_vector(1 downto 0);		--destenation source
		opCode		:	out	std_logic_vector(1 downto 0)		--assign function
	);
end Instruction_mem;

architecture Behave of Instruction_mem is
	type data_type is array (0 to 3 ) of std_logic_vector(7 downto 0);
	constant data_sel: data_type:=(
		"11110010",
		"10100011",
		"11000000",
		"00010000"
		);
	begin
		rs <= data_sel(to_integer(unsigned(pc_in)))(7 downto 6);
		rt <= data_sel(to_integer(unsigned(pc_in)))(5 downto 4);
		rd <= data_sel(to_integer(unsigned(pc_in)))(3 downto 2);
		opCode <= data_sel(to_integer(unsigned(pc_in)))(1 downto 0);
end Behave;
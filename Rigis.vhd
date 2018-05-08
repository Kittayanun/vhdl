library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;

--register
entity regis is
	port(
		clk			: in std_logic;
		write_des 	: in std_logic_vector(1 downto 0); 		--address destination
		write_data 	: in std_logic_vector(7 downto 0); 		--write data in destenation
		wr				: in std_logic;								--wr control,1 = write enable 
		
		addr_data_1 	: in std_logic_vector(1 downto 0); 	--address first registor source
		addr_data_2 	: in std_logic_vector(1 downto 0); 	--address second registor source
		
		data1 		: out std_logic_vector(7 downto 0); 	--first registor source
		data2 		: out std_logic_vector(7 downto 0)		--secode registor source
		
		);
end regis;

architecture Behav of regis is
type reg_type is array (0 to 3 ) of std_logic_vector (7 downto 0);
signal reg_array: reg_type:=(
	"00011110",
	"00010110",
	"00000111",
	"00001111"
	);
	
signal test_data1 : std_logic_vector(7 downto 0);
signal test_data2 : std_logic_vector(7 downto 0);
begin
	process(clk) 
	begin
		if(rising_edge(clk)) then
			if(wr='1') then
				reg_array(to_integer(unsigned(write_des))) <= write_data;
			end if;
		end if;
	end process;
 
	test_data1 <=  reg_array(to_integer(unsigned(addr_data_1)));
	test_data2 <=  reg_array(to_integer(unsigned(addr_data_2)));
	
	data1 <= test_data1;
	data2 <= test_data2;
	
 end Behav;

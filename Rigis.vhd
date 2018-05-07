library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;
--use ieee.std_logic_unsigned.all;

--register
entity regis is
	port(
		clk			: in std_logic;
		write_des 	: in std_logic_vector(1 downto 0); 	--address destination
		write_data 	: in std_logic_vector(7 downto 0); 	--write data in destenation
		wr,rst		: in std_logic;							--wr control,1 = write enable and rst is ..
		
		addr_data_1 	: in std_logic_vector(1 downto 0); 	--address first registor source
		addr_data_2 	: in std_logic_vector(1 downto 0); 	--address second registor source
		
		data1 		: out std_logic_vector(7 downto 0); --first registor source
		data2 		: out std_logic_vector(7 downto 0) 	--secode registor source
		);
end regis;

architecture Behav of regis is
type reg_type is array (0 to 7 ) of std_logic_vector (7 downto 0);
signal reg_array: reg_type;
begin
	process(clk,rst) 
	begin
		if(rst='1') then
			reg_array(0) <= "00000001";
			reg_array(1) <= x"02";
			reg_array(2) <= x"03";
			reg_array(3) <= x"04";
			reg_array(4) <= x"05";
			reg_array(5) <= x"06";
			reg_array(6) <= x"07";
			reg_array(7) <= x"08";
		elsif(rising_edge(clk)) then
			if(wr='1') then
				reg_array(to_integer(unsigned(write_des))) <= write_data;
			end if;
		end if;
	end process;
 
	data1 <= "00000001" when addr_data_1 = "00" else reg_array(to_integer(unsigned(addr_data_1)));
	data2 <= "00000001" when addr_data_2 = "00" else reg_array(to_integer(unsigned(addr_data_2)));
 end Behav;

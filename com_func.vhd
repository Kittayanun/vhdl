library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity com_func is
	port(
		clk	:	in	std_logic;
		in_addr_pc : in std_logic_vector(1 downto 0);
		--out_data1, out_data2 : out std_logic_vector(7 downto 0);
		out_data_write : out std_logic_vector(7 downto 0);
		
		print_opCode	:	out	std_logic_vector(1 downto 0); -- test opCode out instruction_mem to ALU
		
		print_data1		:	out std_logic_vector(7 downto 0);  -- test data1 out Register to ALU
		print_data2		:	out std_logic_vector(7 downto 0)  -- test data1 out Register to ALU
	);
end com_func;

architecture Structural of com_func is
	--PC
	component PC is
		port(
			clk				:	in std_logic;
			instruc		:	in	std_logic_vector(1 downto 0);
			to_instruction	:	out std_logic_vector(1 downto 0)
		);
	end component;
	
	--Instruction
	component Instruction_mem is
		port(
			pc_in	:	in		std_logic_vector(1 downto 0);
			
			rs		:	out	std_logic_vector(1 downto 0);				--first source
			rt		:	out	std_logic_vector(1 downto 0);				--second source
			rd		:	out	std_logic_vector(1 downto 0);				--destenation source
			opCode		:	out	std_logic_vector(1 downto 0);		--assign function
			out_opCode		:	out	std_logic_vector(1 downto 0)
		);
	end component;
	
	--control
	component control is
		port(
			in_instruction	:	in std_logic_vector(1 downto 0);		--form Instruction_mem (opCode)
			regWrite			:	out std_logic;								--assign enable write destination
			ALUop				:	out std_logic_vector(1 downto 0)		--assign function
		);
	end component;
	
	--Rigister
	component regis is
		port(
			clk			: in std_logic;
			write_des 	: in std_logic_vector(1 downto 0); 		--address destination
			write_data 	: in std_logic_vector(7 downto 0); 		--write data in destenation
			wr				: in std_logic;								--wr control,1 = write enable and rst is ..
			
			addr_data_1 	: in std_logic_vector(1 downto 0); 	--address first registor source
			addr_data_2 	: in std_logic_vector(1 downto 0); 	--address second registor source
			
			data1 		: out std_logic_vector(7 downto 0); 	--first registor source
			data2 		: out std_logic_vector(7 downto 0); 	--secode registor source
			
			out_data1	: out std_logic_vector(7 downto 0);
			out_data2 	: out std_logic_vector(7 downto 0)
			);
	end component;
	
	--ALU
	component ALU is
		port(
			--clk			: in std_logic;
			rn			 	: in std_logic_vector (7 downto 0);		--first and second register source operand
			operand		: in std_logic_vector (7 downto 0);
			opCode 		: in std_logic_vector (1 downto 0);		--select function
			rd 			: out std_logic_vector (7 downto 0)		--register destination operand
		);
	end component;
	
	--signal Instruction_mem
	signal Tem_rs		:	std_logic_vector(1 downto 0);		--first source
	signal Tem_rt		:	std_logic_vector(1 downto 0);		--second source
	signal Tem_rd		:	std_logic_vector(1 downto 0);		--destenation source
	signal Tem_opCode		:	std_logic_vector(1 downto 0);		--assign function
	--signal Register
	signal Tem_wr		: std_logic := '1';						--wr control,1 = write enable and rst is ..
	--signal Tem_wr_write	: std_logic := '1';						--wr control,1 = write enable
	signal Tem_write_data	: std_logic_vector(7 downto 0);	--write data in destenation
	signal Tem_data1 		: std_logic_vector(7 downto 0); --first registor source
	signal Tem_data2 		: std_logic_vector(7 downto 0); 	--secode registor source
	--signal ALU
	--signal Tem_RD_ALU 	: std_logic_vector (7 downto 0);		--first and second register source operand

	
	begin
		UO: Instruction_mem
			port map(in_addr_pc, Tem_rs, Tem_rt, Tem_rd, Tem_opCode, print_opCode);
			
		U1: regis
			port map(clk, Tem_rd, Tem_write_data, Tem_wr, Tem_rs, Tem_rt,
					Tem_data1, Tem_data2, print_data1, print_data2);
			
		U2: ALU
			port map(Tem_data1, Tem_data2, Tem_opCode, out_data_write);
			
		--U3: regis
		--	port map(clk, Tem_rd, Tem_RD_ALU, Tem_wr_write,Tem_rst,
		--		Tem_rs, Tem_rt,out_data1, out_data2);
			
end Structural;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:06:40 03/28/2013 
-- Design Name: 
-- Module Name:    comparator_block - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator_block is
	generic (
		DR : integer := 100;
		INPUT_SIZE : integer := 12;
		INDEX_SIZE : integer := 7
	);
	port (
		operands : in std_logic_vector( (DR/2) * INPUT_SIZE - 1 downto 0 );
		clk : in std_logic;
		index : out std_logic_vector( INDEX_SIZE - 1 downto 0 )
	);
end comparator_block;

architecture Behavioral of comparator_block is

	component comparator is
		generic( 
			OPERAND_SIZE : integer := INPUT_SIZE
		);
		port(
			operandA, operandZ : in std_logic_vector(OPERAND_SIZE - 1 downto 0);
			indexA, indexZ : in std_logic_vector(6 downto 0); -- assuming DR never gets bigger than 127 (7 bits)
			result : out std_logic_vector(OPERAND_SIZE - 1 downto 0);
			index : out std_logic_vector(6 downto 0);
			clk : in std_logic
		);
	end component;
	
	component flipflop is
		generic(
			N : integer := INPUT_SIZE
		);
		port (
			d : in std_logic_vector( N-1 downto 0 );
			clk : in std_logic;
			q : out std_logic_vector( N-1 downto 0)
		);
	end component;

	type line_array_index is array(0 to DR/2 - 1) of std_logic_vector(INDEX_SIZE - 1 downto 0);
	type line_array_result is array(0 to DR/2 - 1) of std_logic_vector(INPUT_SIZE - 1 downto 0);
	
	signal COMPARATOR_PREV_result, COMPARATOR_result : line_array_result;
	signal COMPARATOR_PREV_index, COMPARATOR_index : line_array_index;

	signal j : integer;

begin

	PIPEADD3_FF: flipflop port map (
		d => operands(11 downto 0),
		clk => clk,
		q => COMPARATOR_PREV_result(0)
	);
	
	COMPARATOR_COL0: comparator port map (
		operandA => operands(11 downto 0),
		operandZ => COMPARATOR_PREV_result(0),
		indexA => std_logic_vector(to_unsigned(1, 7)),
		indexZ => std_logic_vector(to_unsigned(0, 7)),
		result => COMPARATOR_result(0),
		index => COMPARATOR_index(0),
		clk => clk
	);

	BLOCK_GENERATE: for j in 1 to DR/2 - 1 generate
	
		COMPARATOR_PREV: comparator port map (
			operandA => operands(INPUT_SIZE * (j+1) - 1 downto INPUT_SIZE * j),
			operandZ => COMPARATOR_result(j-1),
			indexA => std_logic_vector(to_unsigned(2*j, 7)),
			indexZ => COMPARATOR_index(j-1),
			result => COMPARATOR_PREV_result(j),
			index => COMPARATOR_PREV_index(j),
			clk => clk
		);
		
		COMPARATOR_COLx: comparator port map (
			operandA => operands(INPUT_SIZE * (j+1) - 1 downto INPUT_SIZE * j),
			operandZ => COMPARATOR_PREV_result(j),
			indexA => std_logic_vector(to_unsigned(2*j+1, 7)),
			indexZ => COMPARATOR_PREV_index(j),
			result => COMPARATOR_result(j),
			index => COMPARATOR_index(j),
			clk => clk
		);

	end generate;
	
	index <= COMPARATOR_index(DR/2 - 1);

end Behavioral;


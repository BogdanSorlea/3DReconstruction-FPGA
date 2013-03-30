----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:02:20 03/27/2013 
-- Design Name: 
-- Module Name:    pipeadd3 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeadd3 is
	port(
		column_sum : in std_logic_vector(9 downto 0);
		clk : in std_logic;
		result : out std_logic_vector(11 downto 0)
	);
end pipeadd3;

architecture Behavioral of pipeadd3 is

	component adder2 is
		generic(
			OPERATOR_SIZE : integer
		);
		port(
			operatorA : in std_logic_vector(OPERATOR_SIZE - 1 downto 0);
			operatorB : in std_logic_vector(OPERATOR_SIZE - 1 downto 0);
			result : out std_logic_vector(OPERATOR_SIZE downto 0)
		);
	end component;
	
	component flipflop is
		generic (
			N : integer := 10
		);
		
		port (
			d : in std_logic_vector( N-1 downto 0 );
			clk : in std_logic;
			q : out std_logic_vector( N-1 downto 0)
		);
	end component;

	signal ff1, ff2 : std_logic_vector(9 downto 0);
	signal ff3, ff4 : std_logic_vector(10 downto 0);
	signal sum1 : std_logic_vector(10 downto 0);
	signal sum2 : std_logic_vector(11 downto 0);
	signal pad1_column_sum : std_logic_vector(10 downto 0);

begin

	FF_1: flipflop port map (
		d => column_sum,
		clk => clk,
		q => ff1
	);
	
	FF_2: flipflop port map (
		d => ff1,
		clk => clk,
		q => ff2
	);
	
	SUM2_1: adder2 generic map (
		OPERATOR_SIZE => 10
	) port map (
		operatorA => column_sum,
		operatorB => ff2,
		result => sum1
	);

	FF_3: flipflop generic map(
		N => 11
	) port map (
		d => sum1,
		clk => clk,
		q => ff3
	);
	
	FF_4: flipflop generic map(
		N => 11
	) port map (
		d => ff3,
		clk => clk,
		q => ff4
	);
	
	SUM2_2: adder2 generic map (
		OPERATOR_SIZE => 11
	) port map (
		operatorA => pad1_column_sum,
		operatorB => ff4,
		result => sum2
	);
	
	pad1_column_sum <= "0" & column_sum;
	
	result <= sum2 when (rising_edge(clk));

end Behavioral;


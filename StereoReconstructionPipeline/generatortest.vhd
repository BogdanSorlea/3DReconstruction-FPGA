----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:04 03/28/2013 
-- Design Name: 
-- Module Name:    generatortest - Behavioral 
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

entity generatortest is
	port(
		d : in std_logic_vector(1 downto 0);
		clk : in std_logic;
		q : out std_logic_vector(1 downto 0)
	);
end generatortest;

architecture Behavioral of generatortest is

	constant SIZE : integer := 50;
	
	type line_array is array(0 to SIZE-1) of std_logic_vector(1 downto 0);

	component flipflop is
		generic(
			N : integer := 2
		);
		port (
			d : in std_logic_vector( N-1 downto 0 );
			clk : in std_logic;
			q : out std_logic_vector( N-1 downto 0)
		);
	end component;
	
	signal i : integer;
	signal internal : line_array;

begin

	LINE_GENERATE: for i in 0 to SIZE-1 generate
	
		FIRST_GENERATE: if i = 0 generate
			FIRST_CELL: flipflop port map(
				d => d,
				clk => clk,
				q => internal(0)
			);
		end generate;
		
		REST_GENERATE: if i > 0 generate
			REST_CELL: flipflop port map(
				d => internal(i-1),
				clk => clk,
				q => internal(i)
			);
		end generate;
		
		q <= internal(SIZE-1);
	
	end generate;

end Behavioral;


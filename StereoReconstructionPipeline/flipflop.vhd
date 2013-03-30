----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:39:57 03/27/2013 
-- Design Name: 
-- Module Name:    flipflop - Behavioral 
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

entity flipflop is
	
	generic (
		N : integer := 8
	);
	
	port (
		d : in std_logic_vector( N-1 downto 0 );
		clk : in std_logic;
		q : out std_logic_vector( N-1 downto 0)
	);
	
end flipflop;

architecture Behavioral of flipflop is
begin

	process(clk, d)
	begin
	
		if ( rising_edge(clk) ) then
			q <= d;
		end if;
	
	end process;

end Behavioral;


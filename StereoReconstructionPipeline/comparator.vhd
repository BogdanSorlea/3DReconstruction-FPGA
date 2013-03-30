----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:43:46 03/26/2013 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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

entity comparator is
	
	generic( 
		OPERAND_SIZE : integer := 12
		-- 12 bits if R=1
		-- 14 bits if R=2 or R=3
	);
				
	port(
		operandA, operandZ : in std_logic_vector(OPERAND_SIZE - 1 downto 0);
		indexA, indexZ : in std_logic_vector(6 downto 0); -- assuming DR never gets bigger than 127 (7 bits)
		result : out std_logic_vector(OPERAND_SIZE - 1 downto 0);
		index : out std_logic_vector(6 downto 0);
		clk : in std_logic
	);

end comparator;

architecture Behavioral of comparator is
	signal tmp_result : std_logic_vector(OPERAND_SIZE - 1 downto 0);
	signal tmp_index : std_logic_vector(6 downto 0);
begin

	tmp_result <= operandZ when (unsigned(operandZ) < unsigned(operandA)) else operandA;
	tmp_index <= indexZ when (unsigned(operandZ) < unsigned(operandA)) else indexA;
	
	FF: process(clk, tmp_result)
	begin
		if (rising_edge(clk)) then
			result <= tmp_result;
			index <= tmp_index;
		end if;
	end process;

--	COMPARISON: process(clk, operandA, operandZ)
--		variable diff : unsigned(OPERAND_SIZE downto 0);
--	begin
--	
--		diff := unsigned("0" & operandA) - unsigned("0" & operandZ);
--	
--		if ( rising_edge(clk) ) then
--			if ( diff(diff'left) = '1' ) then --or operandZ(operandZ'left) = 'Z' ) then
--				result <= operandA;
--			else
--				result <= operandZ;
--			end if;
--		end if;
--	
--	end process;

end Behavioral;


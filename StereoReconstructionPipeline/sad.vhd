----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:02:34 03/27/2013 
-- Design Name: 
-- Module Name:    sad - Behavioral 
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

entity sad is
	
	port(
		leftOperand, rightOperand : in std_logic_vector(7 downto 0);
		result : out std_logic_vector(7 downto 0)
	);

end sad;

architecture Behavioral of sad is
begin

--	diffLR <= unsigned("0" & leftOperand) - unsigned("0" & rightOperand);
--	diffRL <= unsigned("0" & rightOperand) - unsigned("0" & leftOperand);
--
--	result <= std_logic_vector(diffLR) when diffRL(8) = '1' else std_logic_vector(diffRL);
	
	COMPUTE: process(leftOperand, rightOperand)
		variable diff : unsigned(8 downto 0);
	begin
		diff := unsigned("0" & rightOperand) - unsigned("0" & leftOperand);
		if ( diff(diff'left) = '1' ) then
			result <= std_logic_vector(unsigned(leftOperand) - unsigned(rightOperand));
		else
			result <= std_logic_vector(unsigned(rightOperand) - unsigned(leftOperand));
		end if;
	end process;
	
--	COMPUTE: process(leftOperand, rightOperand)
--		variable diffLR, diffRL : unsigned(8 downto 0);
--	begin
--	
--		diffLR := unsigned("0" & leftOperand) - unsigned("0" & rightOperand);
--		diffRL := unsigned("0" & rightOperand) - unsigned("0" & leftOperand);
--		
--		if ( diffRL(8) = '1' ) then
--			result <= std_logic_vector(diffLR);
--		else
--			result <= std_logic_vector(diffRL);
--		end if;
--		
--	end process;

end Behavioral;


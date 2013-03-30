----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:25:41 03/27/2013 
-- Design Name: 
-- Module Name:    adder - Behavioral 
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

entity adder is

	generic(
		OPERAND_NO : integer := 3;
		RESULT_SIZE : integer := 12
	);
	
	port(
		operand : in std_logic_vector(8 * OPERAND_NO - 1 downto 0);
		result : out std_logic_vector(RESULT_SIZE - 1 downto 0)
	);
	
end adder;

architecture Behavioral of adder is

begin

	COMPUTE: process(operand)
		variable sum, tmp : std_logic_vector(RESULT_SIZE - 1 downto 0) := (others => '0');
		variable paddingValue : std_logic_vector(RESULT_SIZE - 8 - 1 downto 0) := (others => '0');
		variable i : integer;
	begin
		
		paddingValue := (others => '0');
		
		for i in 1 to OPERAND_NO loop
			tmp := std_logic_vector(unsigned(sum) + unsigned(paddingValue & operand(8 * i - 1 downto 8 * (i - 1))));
			sum := tmp;
		end loop;
		
		result <= sum;
		
	end process;

end Behavioral;


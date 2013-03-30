----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:45:04 03/27/2013 
-- Design Name: 
-- Module Name:    adder3 - Behavioral 
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

entity adder3 is

	generic(
		RESULT_SIZE : integer := 10
	);

	port(
		operandA : in std_logic_vector(7 downto 0);
		operandB : in std_logic_vector(7 downto 0);
		operandC : in std_logic_vector(7 downto 0);
		result : out std_logic_vector(RESULT_SIZE - 1 downto 0)
	);

end adder3;

architecture Behavioral of adder3 is
begin

	result <= std_logic_vector(resize(unsigned(operandA), RESULT_SIZE) 
						+ resize(unsigned(operandB), RESULT_SIZE) 
						+ resize(unsigned(operandC), RESULT_SIZE));

end Behavioral;
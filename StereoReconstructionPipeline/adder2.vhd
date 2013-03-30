----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:28:22 03/27/2013 
-- Design Name: 
-- Module Name:    adder2 - Behavioral 
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

entity adder2 is

	generic(
		OPERATOR_SIZE : integer := 10
	);

	port(
		operatorA : in std_logic_vector(OPERATOR_SIZE - 1 downto 0);
		operatorB : in std_logic_vector(OPERATOR_SIZE - 1 downto 0);
		result : out std_logic_vector(OPERATOR_SIZE downto 0)
	);

end adder2;

architecture Behavioral of adder2 is
begin

	result <= std_logic_vector(resize(unsigned(operatorA), OPERATOR_SIZE + 1) 
						+ resize(unsigned(operatorB), OPERATOR_SIZE + 1));

end Behavioral;

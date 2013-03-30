--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:52:09 03/27/2013
-- Design Name:   
-- Module Name:   C:/Users/Bogdan/Desktop/D3Reconstruction/StereoReconstructionPipeline/comparator_test.vhd
-- Project Name:  StereoReconstructionPipeline
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparator
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY comparator_test IS
END comparator_test;
 
ARCHITECTURE behavior OF comparator_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT comparator
    PORT(
         operandA : IN  std_logic_vector(11 downto 0);
         operandZ : IN  std_logic_vector(11 downto 0);
         result : OUT  std_logic_vector(11 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal operandA : std_logic_vector(11 downto 0) := (others => '0');
   signal operandZ : std_logic_vector(11 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal result : std_logic_vector(11 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: comparator PORT MAP (
          operandA => operandA,
          operandZ => operandZ,
          result => result,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		wait for clk_period;
      -- insert stimulus here 
		
		operandA <= "000000001111";
		operandZ <= "110011111111";
		
		wait for clk_period;
		
		operandA <= "111100001111";
		operandZ <= "110011111111";
		
		wait for clk_period;
		
		operandA <= "111100000000";
		operandZ <= (others => 'Z');
		
		wait for clk_period;
		
		operandA <= (others => 'Z');
		operandZ <= "111100001001";
		
		wait for clk_period;

      wait;
   end process;

END;

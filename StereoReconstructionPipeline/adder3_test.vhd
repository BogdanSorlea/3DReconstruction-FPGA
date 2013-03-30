--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:51:08 03/27/2013
-- Design Name:   
-- Module Name:   C:/Users/Bogdan/Desktop/D3Reconstruction/StereoReconstructionPipeline/adder3_test.vhd
-- Project Name:  StereoReconstructionPipeline
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: adder3
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
 
ENTITY adder3_test IS
END adder3_test;
 
ARCHITECTURE behavior OF adder3_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT adder3
    PORT(
         operands : IN  std_logic_vector(23 downto 0);
         result : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal operands : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(9 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
	signal clk : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: adder3 PORT MAP (
          operands => operands,
          result => result
        );

   -- Clock process definitions
   period_process :process
   begin
		clk <= '0';
		wait for period/2;
		clk <= '1';
		wait for period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		operands <= (others => '1');
		
		wait for period;

      wait;
   end process;

END;

--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:54:58 03/27/2013
-- Design Name:   
-- Module Name:   C:/Users/Bogdan/Desktop/D3Reconstruction/StereoReconstructionPipeline/sad_test.vhd
-- Project Name:  StereoReconstructionPipeline
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sad
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
 
ENTITY sad_test IS
END sad_test;
 
ARCHITECTURE behavior OF sad_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sad
    PORT(
         leftOperand : IN  std_logic_vector(7 downto 0);
         rightOperand : IN  std_logic_vector(7 downto 0);
         result : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal leftOperand : std_logic_vector(7 downto 0) := (others => '0');
   signal rightOperand : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
	
	signal clk : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sad PORT MAP (
          leftOperand => leftOperand,
          rightOperand => rightOperand,
          result => result
        );
 
	-- Clock process definitions
   clk_process :process
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

      wait for period*10;
		wait for period;
		leftOperand <= "00001111";
		rightOperand <= "00000011";
		wait for period;
		leftOperand <= "00000000";
		rightOperand <= "00000000";
		wait for period;
		leftOperand <= "00000011";
		rightOperand <= "00001111";
		wait for period;
		leftOperand <= "00000011";
		rightOperand <= "00000011";
		wait for period;
		leftOperand <= "00000000";
		rightOperand <= "00000000";
		wait for period;
		leftOperand <= "10000000";
		rightOperand <= "00000001";
		wait for period;
		leftOperand <= "00000000";
		rightOperand <= "00000000";
		wait for period;
		leftOperand <= "ZZZZZZZZ";
		rightOperand <= "00000000";
		wait for period;
		leftOperand <= "00000000";
		rightOperand <= "00000000";
		wait for period;
		leftOperand <= "00000000";
		rightOperand <= "ZZZZZZZZ";
      -- insert stimulus here 

      wait;
   end process;

END;

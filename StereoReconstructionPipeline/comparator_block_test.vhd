--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:35:03 03/28/2013
-- Design Name:   
-- Module Name:   C:/Users/Bogdan/Desktop/D3Reconstruction/StereoReconstructionPipeline/comparator_block_test.vhd
-- Project Name:  StereoReconstructionPipeline
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: comparator_block
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
 
ENTITY comparator_block_test IS
END comparator_block_test;
 
ARCHITECTURE behavior OF comparator_block_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT comparator_block
	 GENERIC (
		DR : integer := 10
	 );
    PORT(
         operands : IN  std_logic_vector(59 downto 0);
         clk : IN  std_logic;
         index : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal operands : std_logic_vector(59 downto 0) := (others => '1');
   signal clk : std_logic := '0';

 	--Outputs
   signal index : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: comparator_block PORT MAP (
          operands => operands,
          clk => clk,
          index => index
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

      -- insert stimulus here 
			
		wait for clk_period;
		operands <= "000000001000000000000011000000000100000000000001000000000000"; -- 0
		wait for clk_period;
		operands <= "000000001001000000000011100000000101000000000001100000000001";
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011"; -- 1
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000000";
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000000000000000011"; -- 2
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011";
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011"; -- 3
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000000000000000011";
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000000000000000011000000000011"; -- 4
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011";
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011"; -- 5
		wait for clk_period;
		operands <= "000000000011000000000011000000000000000000000011000000000011";
		
		wait for clk_period;
		operands <= "000000000011000000000000000000000011000000000011000000000011"; -- 6
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011";
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011"; -- 7
		wait for clk_period;
		operands <= "000000000011000000000000000000000011000000000011000000000011";
		
		wait for clk_period;
		operands <= "000000000000000000000011000000000011000000000011000000000011"; -- 8
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011";
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011"; -- 9
		wait for clk_period;
		operands <= "000000000000000000000011000000000011000000000011000000000011";
		
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011";
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011";
		
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011";
		wait for clk_period;
		operands <= "000000000011000000000011000000000011000000000011000000000011";
		
      wait;
   end process;

END;

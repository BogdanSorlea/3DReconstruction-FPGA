--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:37:54 04/01/2013
-- Design Name:   
-- Module Name:   C:/Users/Bogdan/Desktop/D3Reconstruction/StereoReconstructionPipeline/pipeline_test.vhd
-- Project Name:  StereoReconstructionPipeline
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pipeline
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
 
ENTITY pipeline_test IS
END pipeline_test;
 
ARCHITECTURE behavior OF pipeline_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT pipeline
    PORT(
         left : IN  std_logic_vector(23 downto 0);
         right : IN  std_logic_vector(23 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         start : IN  std_logic;
         index : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal left : std_logic_vector(23 downto 0) := (others => '0');
   signal right : std_logic_vector(23 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs
   signal index : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: pipeline PORT MAP (
          left => left,
          right => right,
          clk => clk,
          rst => rst,
          start => start,
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

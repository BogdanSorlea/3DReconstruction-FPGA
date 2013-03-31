----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:30:05 03/27/2013 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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

entity pipeline is

	generic(
		R : integer := 1;
		DR : integer := 100
	);
	
	port(
		left, right: in std_logic_vector(8 * (2 * R + 1) - 1 downto 0);
		--left, right : in std_logic_vector(8 * (DR / 2) * (2 * R + 1) - 1 downto 0);
		clk, rst, start : in std_logic;
		index : out std_logic_vector(6 downto 0)
	);

end pipeline;

architecture Behavioral of pipeline is

	constant COMPARATOR_OPERAND_SIZE : integer := 12;
	-- 12 bits if R=1
	-- 14 bits if R=2 or R=3
	constant ADDER3_RESULT_SIZE : integer := 10;
	-- 10 bits for ADDER3
	
	type state_type is ( idle, initialShiftBoth, initialShiftRight, shiftLeft, shiftRight );

	type line_array_7 is array(0 to DR/2-1) of std_logic_vector(6 downto 0);
	type line_array_7_ex1 is array(1 to DR/2-1) of std_logic_vector(6 downto 0);
	type line_array_8 is array(0 to DR/2-1) of std_logic_vector(7 downto 0);
	type line_array_10 is array(0 to DR/2-1) of std_logic_vector(9 downto 0);
	type line_array_12 is array(0 to DR/2-1) of std_logic_vector(11 downto 0);
	type line_array_12_ex1 is array(1 to DR/2-1) of std_logic_vector(11 downto 0);
	type table_array_8 is array( (2 * R + 1) - 1 downto 0 ) of line_array_8;
	
	--type matrix is array(integer range<>, integer range<>) of std_logic_vector(7 downto 0);

	component sad is
		port(
			leftOperand, rightOperand : in std_logic_vector(7 downto 0);
			result : out std_logic_vector(7 downto 0)
		);	
	end component;
	
	component comparator is
		generic( 
			OPERAND_SIZE : integer := COMPARATOR_OPERAND_SIZE
		);
		port(
			operandA, operandZ : in std_logic_vector(OPERAND_SIZE - 1 downto 0);
			indexA, indexZ : in std_logic_vector(6 downto 0); -- assuming DR never gets bigger than 127 (7 bits)
			result : out std_logic_vector(OPERAND_SIZE - 1 downto 0);
			index : out std_logic_vector(6 downto 0);
			clk : in std_logic
		);
	end component;
	
	component adder3 is
		generic(
			RESULT_SIZE : integer := ADDER3_RESULT_SIZE
		);
		port(
			operandA : in std_logic_vector(7 downto 0);
			operandB : in std_logic_vector(7 downto 0);
			operandC : in std_logic_vector(7 downto 0);
			result : out std_logic_vector(RESULT_SIZE - 1 downto 0)
		);
	end component;
	
	component flipflop is
		generic(
			N : integer
		);
		port (
			d : in std_logic_vector( N-1 downto 0 );
			clk : in std_logic;
			q : out std_logic_vector( N-1 downto 0)
		);
	end component;
	
	component pipeadd3 is
	
		port(
			column_sum : in std_logic_vector(9 downto 0);
			clk : in std_logic;
			result : out std_logic_vector(11 downto 0)
		);
	
	end component;

	signal i, j : integer;
	
	--signal SAD_result : array( 0 to (2 * R + 1) - 1 ) of line_array_8;
	signal SAD_result : table_array_8;
	signal ADDER3_result : line_array_10;
	signal PIPEADD3_result, COMPARATOR_result : line_array_12;
	signal COMPARATOR_PREV_result : line_array_12_ex1;
	signal COMPARATOR_index : line_array_7;
	signal COMPARATOR_PREV_index : line_array_7_ex1;
	signal PIPEADD3_col0_buf : std_logic_vector(11 downto 0);
	
	signal leftLine, rightLine : table_array_8;
	signal leftLineCLK, rightLineCLK, leftLineCLKEN, rightLineCLKEN : std_logic;
	
	signal state, next_state: state_type;
	signal initialShift, nextInitialShift: integer;

begin

	STATEMACHINE_SL: process (clk)
	begin
		if ( rising_edge(clk) ) then
			if ( rst = '1' ) then
				state <= idle;
			else
				state <= next_state;
			end if;
			
			initialShift <= nextInitialShift;
			
		end if;
	end process STATEMACHINE_SL;
	
	

	STATEMACHINE_CL: process(state, start, initialShift)
	begin
		case (state) is	
			when idle =>
				if ( start = '1' ) then
					next_state <= initialShiftBoth;
				else
					next_state <= idle;
				end if;
				
				nextInitialShift <= 0;
				
				leftLineCLKEN <= '0';
				rightLineCLKEN <= '0';
			
			when initialShiftBoth =>
			
				next_state <= initialShiftRight;
				
				nextInitialShift <= 1;
				
				leftLineCLKEN <= '1';
				rightLineCLKEN <= '1';
			
			when initialShiftRight =>
			
				if ( initialShift < DR/2 ) then
					next_state <= initialShiftRight;
				else
					next_state <= shiftRight;
				end if;
			
				nextInitialShift <= initialShift + 1;
				
				leftLineCLKEN <= '0';
				rightLineCLKEN <= '1';
			
			when shiftRight =>
			
				next_state <= shiftLeft;
				
				nextInitialShift <= 0;
			
				leftLineCLKEN <= '0';
				rightLineCLKEN <= '1';
			
			when shiftLeft =>
			
				next_state <= shiftRight;
				
				nextInitialShift <= 0;
				
				leftLineCLKEN <= '1';
				rightLineCLKEN <= '0';
			
		end case;
	end process STATEMACHINE_CL;
	
	
	leftLineCLK <= leftLineCLKEN and clk;
	rightLineCLK <= rightLineCLKEN and clk;


	COLUMN_ITERATION: for j in 0 to (DR / 2 - 1) generate
		
		SAD_LINE_ITERATION: for i in 0 to ((2 * R + 1) - 1) generate
		
			LINE_SHIFT_REGISTER_COL0: if ( j = 0 ) generate 
		
				SR_LEFT_COL0_FF: flipflop generic map (
					N => 8
				) port map(
					d => left((i+1) * 8 - 1 downto i * 8),
					clk => leftLineCLK,
					q => leftLine(i)(j)
				);
				
				SR_RIGHT_COLx_FF: flipflop generic map (
					N => 8
				) port map(
					d => rightLine(i)(j+1),
					clk => rightLineCLK,
					q => rightLine(i)(j)
				);
			
			end generate;
			
			LINE_SHIFT_REGISTER_COLx: if ( j > 0 and j < (DR/2 - 1) ) generate 
		
				SR_LEFT_COLx_FF: flipflop generic map (
					N => 8
				) port map(
					d => leftLine(i)(j-1),
					clk => leftLineCLK,
					q => leftLine(i)(j)
				);
				
				SR_RIGHT_COLx_FF: flipflop generic map (
					N => 8
				) port map(
					d => rightLine(i)(j+1),
					clk => rightLineCLK,
					q => rightLine(i)(j)
				);
			
			end generate;
			
			LINE_SHIFT_REGISTER_COLMAX: if ( j = (DR/2 - 1) ) generate 
		
				SR_LEFT_COLMAX_FF: flipflop generic map (
					N => 8
				) port map(
					d => leftLine(i)(j-1),
					clk => leftLineCLK,
					q => leftLine(i)(j)
				);
				
				SR_RIGHT_COLMAX_FF: flipflop generic map (
					N => 8
				) port map(
					d => right((i+1) * 8 - 1 downto i * 8),
					clk => rightLineCLK,
					q => rightLine(i)(j)
				);
			
			end generate;
		
			COMPUTE_SAD: sad port map(
				--leftOperand => left( (DR/2 * i * 8 + (j+1) * 8 - 1) downto (DR/2 * i * 8 + j * 8) ), 
				--rightOperand => right( (DR/2 * i * 8 + (j+1) * 8 - 1) downto (DR/2 * i * 8 + j * 8) ),
				leftOperand => leftLine(i)(j), 
				rightOperand => rightLine(i)(j),
				result => SAD_result(i)(j)
			);
		end generate;
		
		ADDER_3: adder3 port map(
			operandA => SAD_result(0)(j),
			operandB => SAD_result(1)(j),
			operandC => SAD_result(2)(j),
			result => ADDER3_result(j)
		);

		PIPE_ADD3: pipeadd3 port map(
			column_sum => ADDER3_result(j),
			clk => clk,
			result => PIPEADD3_result(j)
		);
		
		PIPEADD3_COL0: if ( j = 0 ) generate 
		
			PIPEADD3_FF: flipflop generic map (
				N => 12
			) port map (
				d => PIPEADD3_result(j),
				clk => clk,
				q => PIPEADD3_col0_buf
			);
			
			COMPARATOR_COL0: comparator port map (
				operandA => PIPEADD3_result(j),
				operandZ => PIPEADD3_col0_buf,
				indexA => std_logic_vector(to_unsigned(2*j+1, 7)),
				indexZ => std_logic_vector(to_unsigned(2*j, 7)),
				result => COMPARATOR_result(j),
				index => COMPARATOR_index(j),
				clk => clk
			);
		
		end generate;
		
		PIPEADD3_COLx: if ( j > 0 ) generate 
			
			COMPARATOR_PREV: comparator port map (
				operandA => PIPEADD3_result(j),
				operandZ => COMPARATOR_result(j-1),
				indexA => std_logic_vector(to_unsigned(2*j, 7)),
				indexZ => COMPARATOR_index(j-1),
				result => COMPARATOR_PREV_result(j),
				index => COMPARATOR_PREV_index(j),
				clk => clk
			);
			
			COMPARATOR_COLx: comparator port map (
				operandA => PIPEADD3_result(j),
				operandZ => COMPARATOR_PREV_result(j),
				indexA => std_logic_vector(to_unsigned(2*j+1, 7)),
				indexZ => COMPARATOR_PREV_index(j),
				result => COMPARATOR_result(j),
				index => COMPARATOR_index(j),
				clk => clk
			);
		
		end generate;
		
	end generate;
	
	index <= COMPARATOR_index(COMPARATOR_index'right);

end Behavioral;


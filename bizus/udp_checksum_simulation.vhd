--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:40:28 05/08/2024
-- Design Name:   
-- Module Name:   /home/ise/Desktop/my_repo/bizus/udp_checksum_simulation.vhd
-- Project Name:  bizus
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: udp_checksum_header
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
 
ENTITY udp_checksum_simulation IS
END udp_checksum_simulation;
 
ARCHITECTURE behavior OF udp_checksum_simulation IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT udp_checksum_header
    PORT(
         i_data : IN  std_logic_vector(7 downto 0);
         i_last : IN  std_logic;
         i_clk : IN  std_logic;
         o_valid : OUT  std_logic;
         o_done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_data : std_logic_vector(7 downto 0) := (others => '0');
   signal i_last : std_logic := '0';
   signal i_clk : std_logic := '0';

 	--Outputs
   signal o_valid : std_logic;
   signal o_done : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: udp_checksum_header PORT MAP (
          i_data => i_data,
          i_last => i_last,
          i_clk => i_clk,
          o_valid => o_valid,
          o_done => o_done
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for i_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;

-- Vhdl test bench created from schematic /home/ise/Desktop/my_repo/Projeto1/Aula_sim.sch - Thu Apr 18 01:45:17 2024
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY Aula_sim_Aula_sim_sch_tb IS
END Aula_sim_Aula_sim_sch_tb;
ARCHITECTURE behavioral OF Aula_sim_Aula_sim_sch_tb IS 

   COMPONENT Aula_sim
   PORT( DIPSW	:	IN	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          CLK27MHz	:	IN	STD_LOGIC; 
          BUT	:	IN	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          XLXN_4	:	OUT	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          GPIO	:	INOUT	STD_LOGIC_VECTOR (7 DOWNTO 0));
   END COMPONENT;

   SIGNAL DIPSW	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL CLK27MHz	:	STD_LOGIC;
   SIGNAL BUT	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL XLXN_4	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL GPIO	:	STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN

   UUT: Aula_sim PORT MAP(
		DIPSW => DIPSW, 
		CLK27MHz => CLK27MHz, 
		BUT => BUT, 
		XLXN_4 => XLXN_4, 
		GPIO => GPIO
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
      WAIT for 100ns;
		DIPSW <= "0000";
      WAIT for 100ns;
		DIPSW <= "0001";
      WAIT for 100ns;
		DIPSW <= "0010";
      WAIT for 100ns;
		DIPSW <= "0011";
      WAIT for 100ns;
		DIPSW <= "0100";
      WAIT for 100ns;
		DIPSW <= "0101";
      WAIT for 100ns;
		DIPSW <= "0110";
      WAIT for 100ns;
		DIPSW <= "0111";
      WAIT for 100ns;
		DIPSW <= "1000";
      WAIT for 100ns;
		DIPSW <= "1001";
      WAIT for 100ns;
		DIPSW <= "1010";
      WAIT for 100ns;
		DIPSW <= "1011";
      WAIT for 100ns;
		DIPSW <= "1100";
      WAIT for 100ns;
		DIPSW <= "1101";
      WAIT for 100ns;
		DIPSW <= "1110";
      WAIT for 100ns;
		DIPSW <= "1111";
      WAIT for 100ns;
		
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;

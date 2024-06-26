library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AULA_4 is
    Port ( DIPSW : in  STD_LOGIC_VECTOR (3 downto 0); --dsldasl
           BUT : in  STD_LOGIC_VECTOR (3 downto 0); --input never read
           LEDS: out  STD_LOGIC_VECTOR (3 downto 0);
           CLK27MHZ : in  STD_LOGIC; --input never read
           GPIO : inout  STD_LOGIC_VECTOR (7 downto 0)); --input never re
end AULA_4;

architecture Comportamento of AULA_4 is
signal CLK1Hz : std_logic;
signal cont : std_logic_vector(24 downto 0);
signal Q : std_logic_vector(3 downto 0);
signal SHIFT : std_logic_vector(4 downto 0);
component FFD_C port (D,CLK,CLR: in std_logic; Q: out std_logic); end component;
begin
	process(CLK27MHz)
	begin
		if(CLK27MHz'event and CLK27MHz = '1') then
			if(cont = "1100110111111110010111111") then cont <= "0000000000000000000000000";
			else cont <= cont + "0000000000000000000000001";
			end if;
		end if;
	end process;
	CLK1Hz <= cont(24);

--	U0:FFD_C port map( D => Q(2), CLK => CLK1Hz, clr => BUT(0), Q => Q(3));
--	U1:FFD_C port map( D => Q(1), CLK => CLK1Hz, clr => BUT(0), Q => Q(2));
--	U2:FFD_C port map( D => Q(0), CLK => CLK1Hz, clr => BUT(0), Q => Q(1));
--	U3:FFD_C port map( D => but(3), CLK => CLK1Hz, clr => BUT(0), Q => Q(0));
	
	SHIFT(0) <= BUT(3);
	loop_shift: for i in 0 to 3 generate
		u: ffd_c PORT MAP (D=> SHIFT(i), CLK => CLK1Hz, clr => but(0), Q => shift(i+1));
	end generate;

	LEDS <= SHIFT(4 DOWNTO 1);
end Comportamento;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FFD_C is
	port( D, CLK, CLR: in std_logic;
			Q : out std_logic);
end FFD_C;

architecture behavior of FFD_C is
begin
	process(CLK,CLR)
	begin
		if(CLR = '1') then
			Q <= '0';
		elsif(CLK'event and CLK='1') then
			Q <= D;
		end if;
	end process;
end behavior;

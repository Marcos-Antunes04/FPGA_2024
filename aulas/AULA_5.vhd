library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AULA_5 is
    Port ( DIPSW : in  STD_LOGIC_VECTOR (3 downto 0); --dsldasl
           BUT : in  STD_LOGIC_VECTOR (3 downto 0); --input never read
           LEDS: out  STD_LOGIC_VECTOR (3 downto 0);
           CLK27MHZ : in  STD_LOGIC; --input never read
           GPIO : inout  STD_LOGIC_VECTOR (7 downto 0)); --input never re
end AULA_5;

architecture Comportamento of AULA_5 is
signal CLK1Hz, CLK8Hz : std_logic;
signal cont : std_logic_vector(24 downto 0);
signal Q : std_logic_vector(7 downto 0);
signal cascata1, cascata2 : std_logic;
component CONTBCD port (UP,CLK,CLR,ENIN: in std_logic;
							   ENOUT : out std_logic;
								Q: out std_logic_vector(3 downto 0));
end component;
	begin
	U0: CONTBCD port map (CLK=> CLK8Hz, CLR => BUT(0), ENIN => not BUT(1),
								 UP=> BUT(2), ENOUT => cascata1, Q=>Q(3 downto 0));
	U1: CONTBCD port map (CLK=> CLK8Hz, CLR => BUT(0),ENIN=> cascata1,
								 UP=> BUT(2), ENOUT => cascata2, Q=>Q(7 downto 4));
	LEDS <= Q(7 downto 4);
	process(CLK27MHz)
	begin
		if(CLK27MHz'event and CLK27MHz = '1') then
			if(cont = "1100110111111110010111111") then cont <= "0000000000000000000000000";
			else cont <= cont + "0000000000000000000000001";
			end if;
		end if;
	end process;
	CLK1HZ <= cont(24);
	CLK8HZ <= cont(21);
end Comportamento;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CONTBCD is
    Port ( CLK, CLR, ENIN, UP: in std_logic;
			  ENOUT : out std_logic;
			  Q : out std_logic_vector(3 downto 0));
end CONTBCD;

architecture Comportamento of CONTBCD is
signal cont, proxcont : std_logic_vector(3 downto 0);
begin
	proxcont <= "0000" when (cont="1001" and UP='1' and ENIN='1') else
					 "1001" when (cont="0000" and UP='0' and ENIN='1') else
					 cont when (ENIN='0') else
					 cont + ((not UP) & (not UP) & (not UP) & '1');
	ENOUT <= '1' when (cont="1001" and UP='1' and ENIN='1') else
				'1' when (cont="0000" and UP='0' and ENIN='1') else
				'0';
	Q <= cont;
	process(CLK, CLR)
	begin
		if(CLR = '1') then cont <= "0000";
		elsif(CLK'event and CLK='1') then cont <= proxcont;
		end if;
	end process;
end Comportamento;



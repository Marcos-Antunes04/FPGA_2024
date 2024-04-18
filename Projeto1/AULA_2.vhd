library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AULA_2 is
    Port ( DIPSW : in  STD_LOGIC_VECTOR (3 downto 0); 
           BUT : in  STD_LOGIC_VECTOR (3 downto 0); 
           LEDS: out  STD_LOGIC_VECTOR (3 downto 0);
           CLK27MHZ : in  STD_LOGIC; 
           GPIO : inout  STD_LOGIC_VECTOR (7 downto 0)); 
end AULA_2;

architecture Comportamento of AULA_2 is
	component SomadorCompleto port (ai,bi,ci:in std_logic; si,co:out std_logic);
	end component;
	signal carry: std_logic_vector( 3 downto 0);
	begin
	U0: SomadorCompleto port map (ai => BUT(0),bi => DIPSW(0),ci => '0'     ,si => LEDS(0) ,co => carry(0));d
	U1: SomadorCompleto port map (ai => BUT(1),bi => DIPSW(1),ci => carry(0),si => LEDS(1) ,co => carry(1));
	U2: SomadorCompleto port map (ai => BUT(2),bi => DIPSW(2),ci => carry(1),si => LEDS(2) ,co => carry(2));
	U3: SomadorCompleto port map (ai => BUT(3),bi => DIPSW(3),ci => carry(2),si => LEDS(3) ,co => carry(3));
	--U0: SomadorCompleto port map (ai => BUT(0),bi => DIPSW(0),ci => '0'     ,si => LEDS(0) ,co => carry(0));
	--for i in 1 to 3 loop
	--	U1: SomadorCompleto port map (ai => BUT(i),bi => DIPSW(i),ci => carry(i-1),si => LEDS(i) ,co => carry(i));
	--end loop;
		
end Comportamento;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity SomadorCompleto is	
    Port ( ai, bi, ci : in  std_logic;
			  si, co: out std_logic
			);
end SomadorCompleto;

architecture Comportamento of SomadorCompleto is
begin
	si <= ai xor bi xor ci;
	co <= (ai and bi) or (ai and ci) or (bi and ci);
	
end Comportamento;


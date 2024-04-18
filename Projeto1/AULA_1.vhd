library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AULA_1 is
    Port ( DIPSW : in  STD_LOGIC_VECTOR (3 downto 0); --dsldasl
           BUT : in  STD_LOGIC_VECTOR (3 downto 0); --input never read
           LEDS: out  STD_LOGIC_VECTOR (3 downto 0);
           CLK27MHZ : in  STD_LOGIC; --input never read
           GPIO : inout  STD_LOGIC_VECTOR (7 downto 0)); --input never re
end AULA_1;

architecture Comportamento of AULA_1 is
signal I1, I2: std_logic;
begin
	I1 <= DIPSW(3) xor DIPSW(2); 
	I2 <= DIPSW(1) xor DIPSW(0); 
	LEDS(0) <= I2 and I2;
	LEDS (3 downto 1) <= '1' & I1 & I2; 
end Comportamento;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port (Mux : in  STD_LOGIC_VECTOR (1 downto 0);
          Y : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end mux;

architecture Behavioral of mux is
	
begin
	Y(0) <= not(Mux(0)) and not(Mux(1));
	Y(1) <= Mux(0) and not(Mux(1));
	Y(2) <= not(Mux(0)) and Mux(1);
	Y(3) <= Mux(0) and Mux(1);
	
end Behavioral;
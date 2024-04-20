library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux is
    Port (Mux : in  STD_LOGIC_VECTOR (1 downto 0);
          Y : out  STD_LOGIC_VECTOR (3 downto 0)
			 );
end mux;

architecture Behavioral of mux is
	
begin
	--Y(0) <= (not(Mux(0))) and (not(Mux(1)));
	--Y(1) <= Mux(0) and (not(Mux(1)));
	--Y(2) <= (not(Mux(0))) and Mux(1);
	--Y(3) <= Mux(0) and Mux(1);
	
	multiplexer: process(Mux)
	begin
		case Mux is
			when "00" =>
				Y <= "0001";
			when "01" =>
				Y <= "0010";
			when "10" =>
				Y <= "0100";
			when "11" =>
				Y <= "1000";
			when others =>
				Y <= "1111";
		end case;
	end process;
	
end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
entity ULA_1 is 
port (
		A : in std_logic_vector(3 downto 0);
		B : in std_logic_vector(3 downto 0);
		O : out std_logic_vector(3 downto 0);
		Selection : in std_logic_vector(2 downto 0)
);
end ULA_1;

architecture Hardware of ULA_1 is
begin
process(A,B,Selection)
begin
	case Selection is
	
	when "000" => 
		O <= A + B;
	when "001" => 
		O <= A - B;
	when "010" => 
		O <= A and B;
	when "011" => 
		O <= A or B;
	when "100" => 
		O <= A xor B;
	when "101" => 
		O <= not A;
	when "110" => 
		O <= not B;
	when others => 
		--O <= "zzzz";

	end case;
end process;
end Hardware;
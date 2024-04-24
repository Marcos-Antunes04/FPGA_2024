library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;               -- Needed for shifts

entity udp_checksum_header is
    Port ( i_data : in  STD_LOGIC_VECTOR (7 downto 0);
           i_last : in  STD_LOGIC;
           i_clk : in  STD_LOGIC;
           o_valid : out  STD_LOGIC;
           o_done : out  STD_LOGIC);
end udp_checksum_header;

architecture Behavioral of udp_checksum_header is
signal temp_data : std_logic_vector(15 downto 0) := "0000000000000000";
signal temp_sum : std_logic_vector(39 downto 0)  := "00000000";
signal state: std_logic := '0';
signal received_checksum : std_logic_vector(7 downto 0);
signal calculated_checksum : std_logic_vector(7 downto 0);
begin
clock_accumulator: process(i_clk)
begin
	
	for i in 1 to 10 loop
		if(rising_edge(i_clk) and state = '0' and not(i = 6)) then
			temp_data <= temp_data or i_data;
			state <= '1';
		elsif(rising_edge(i_clk) and state = '1' and not(i = 6)) then
			temp_data <= shift_left(temp_data,8);
			temp_data <= temp_data or i_data;
			temp_sum <= temp_sum + temp_data;
			temp_data <= "0000000000000000";
			state <= '0';
		elsif(rising_edge(i_clk) and i = 6) then
			received_checksum <= i_data; 
		end if;
	end loop;
	
	calculated_checksum <= total_sum and not(shift_left("11111111",32)));
	calculated_checksum <= 	calculated_checksum + shift_left(); -- to finish

	
end process;
end Behavioral;


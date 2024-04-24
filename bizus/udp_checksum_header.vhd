library IEEE;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity udp_checksum_header is
    Port ( i_data : in  STD_LOGIC_VECTOR (7 downto 0);
           i_last : in  STD_LOGIC;
           i_clk : in  STD_LOGIC;
           o_valid : out  STD_LOGIC;
           o_done : out  STD_LOGIC);
end udp_checksum_header;

architecture Behavioral of udp_checksum_header is
shared variable temp_data : std_logic_vector(15 downto 0) := "0000000000000000";
shared variable temp_sum : std_logic_vector(19 downto 0)  := "00000000000000000000";
shared variable state: std_logic := '0';
shared variable received_checksum : std_logic_vector(15 downto 0);
signal calculated_checksum : std_logic_vector(15 downto 0);
shared variable count : integer range 1 to 10 := 1;
begin
clock_accumulator: process(i_clk)
begin
	if(rising_edge(i_clk)) then
		o_done <= '0';
		if(state = '0') then
			temp_data := "00000000" & i_data;
			state := '1';
		elsif(state = '1') then
			temp_data := temp_data(15 downto 8) & i_data;
			if(not(count = 6)) then
				temp_sum := temp_sum + ("0000" & temp_data);
			else
				received_checksum := temp_data;
			end if;
			state := '0';
			count := count + 1;
			if (count=10) then
				count := 1;
			end if;
		end if;
	end if;
	o_done <= '1';
	calculated_checksum <= not(temp_sum(15 downto 0) + ("000000000000" & temp_sum(19 downto 16)));
end process;
clock_data: process(calculated_checksum)
begin
	if(calculated_checksum = received_checksum) then
		o_valid <= '1';
	else
		o_valid <= '0';
	end if;
end process;
end Behavioral;


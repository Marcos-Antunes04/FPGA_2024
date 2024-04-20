library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity UART_TX is port(
		start, clk: in std_logic;
		tx: out std_logic
	);
end UART_TX;

architecture Behavioral of UART_TX is
-- 9600 baud rate
-- 100Mhz clock -> 100000000/9600 = 10416 
signal count : integer range 0 to 10416 := 0;
signal flag : std_logic := '0';

-- Signals for data transmission
type state_type is (rdy, send_data, check_bit);
signal state : state_type := rdy;
signal txdata : std_logic_vector(9 downto 0);
signal tx_temp : std_logic;
signal bit_count : integer range 0 to 11 := 0;

begin

Baud_rate_generation: process(clk)
begin
	if(rising_edge(clk)) then
		if(state=rdy) then
			count <= 0;
		elsif(count < 10416) then
			count <= count + 1;
			flag <= '0';
		else
			flag <= '1';
		end if;
	end if;
end process;
	
Data_transmission_process: process(clk)
begin
	if(rising_edge(clk)) then
		case(state) is
			when rdy =>
				tx_temp <= '1';
				if(start = '0') then
					state <= rdy;
				else
					state <= send_data;
					txdata <= ('1' & X"41" & '0');
				end if;
			when send_data =>
				tx_temp <= txdata(bit_count);
				bit_count <= bit_count + 1;
				state <= check_bit;
			when check_bit =>
				if(flag = '1') then
					if(bit_count < 10) then
						state <= send_data;
					else
						state <= rdy;
						bit_count <= 0;
					end if;
				else
					state <= check_bit;
				end if;
			when others =>
				state <= rdy;
		end case;
	end if;
end process;
				
tx <= tx_temp;
end Behavioral;


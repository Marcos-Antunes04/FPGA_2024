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
signal CLK1Hz, CLK8Hz, CLK100k : std_logic;
signal cont : std_logic_vector(24 downto 0);
signal Q : std_logic_vector(7 downto 0);
signal cascata1, cascata2 : std_logic;
component CONTBCD port (UP,CLK,CLR,ENIN: in std_logic;
							   ENOUT : out std_logic;
								Q: out std_logic_vector(3 downto 0));
end component;

component display port( NUM7, NUM6, NUM5, NUM4, NUM3, NUM2, NUM1, NUM0: in std_logic_vector(3 downto 0);
		CLK: in std_logic; CS, Dout: out std_logic);
end component;

signal num7,num6,num5,num4,num3,num2,num1,num0: std_logic_vector(3 downto 0);
signal clkdisp,cs,din: std_logic;
signal cont100k,contaux: std_logic_vector(23 downto 0);

	begin
	U0: CONTBCD port map (CLK=> CLK8Hz, CLR => BUT(0), ENIN => not BUT(1),
								 UP=> BUT(2), ENOUT => cascata1, Q=>Q(3 downto 0));
	U1: CONTBCD port map (CLK=> CLK8Hz, CLR => BUT(0),ENIN=> cascata1,
								 UP=> BUT(2), ENOUT => cascata2, Q=>Q(7 downto 4));
	LEDS <= Q(7 downto 4);
	num0 <= Q(3 downto 0);
	num1 <= Q(7 downto 4);
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
	
	process(CLK27MHz)
	begin
		if(CLK27MHz'event and CLK27MHz = '1') then
			if (cont100k = "000000000000000000000000") then cont100k <= "000000000000000100001101";
			else cont100k <= cont100k-"000000000000000000000001";
			end if;
			contaux <= contaux + "000000000000000000000001";
		end if;
	end process;

	CLK100k <= cont100k(8);
	UDISP: display port map (num7 => num7,num6 => num6,num5 => num5,num4 => num4,num3 => num3,num2 => num2,
								  num1 => num1,num0 => num0,clk => clkdisp,cs => cs,dout => din); 

	clkdisp <= contaux(5); -- 421875 Hz
	GPIO(0) <= clkdisp;
	GPIO(4) <= cs;
	GPIO(1) <= din;
	
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



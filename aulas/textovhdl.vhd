library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity textovhdl is
    Port ( CLK27MHz : in  STD_LOGIC;
           LEDS : out  STD_LOGIC_VECTOR (3 downto 0);
			  BUT : in  STD_LOGIC_VECTOR (3 downto 0);
			  DIPSW : in  STD_LOGIC_VECTOR (3 downto 0);
			  GPIO : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end textovhdl;

architecture comportamento of textovhdl is
component display port( NUM7, NUM6, NUM5, NUM4, NUM3, NUM2, NUM1, NUM0: in std_logic_vector(3 downto 0);
		CLK: in std_logic; CS, Dout: out std_logic); end component;
signal cont100k,contaux: std_logic_vector(23 downto 0);
signal num7,num6,num5,num4,num3,num2,num1,num0: std_logic_vector(3 downto 0);
signal CLK100k,clk621ms: std_logic;
signal clkdisp,cs,din: std_logic;
begin


LEDS <= clk621ms & clk621ms & clk621ms & clk621ms;
GPIO(7 downto 3) <= "00000";
num0 <= "0000";
num1 <= "0001";
num2 <= "0010";
num3 <= "0011";
num4 <= "0100";
num5 <= "0101";
num6 <= "0110";
num7 <= "0111";

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
clk621ms <= contaux(23); -- aprox. 1,6 Hz

UDISP: display port map (num7 => num7,num6 => num6,num5 => num5,num4 => num4,num3 => num3,num2 => num2,
                       num1 => num1,num0 => num0,clk => clkdisp,cs => cs,dout => din); 

clkdisp <= contaux(5); -- 421875 Hz
GPIO(0) <= clkdisp;
GPIO(1) <= cs;
GPIO(2) <= din;

end comportamento;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity display is		--Implementao do componente Display
port( NUM7, NUM6, NUM5, NUM4, NUM3, NUM2, NUM1, NUM0: in std_logic_vector(3 downto 0);
		CLK: in std_logic; 
		CS, Dout: out std_logic);
end display;

architecture comportamento of display is

--Declarao e inicializao das variveis---------------------
signal EN: std_logic_vector(8 downto 0):="000000000"; --ontador de 9 bits
signal palavra, proxpalavra: std_logic_vector(15 downto 0):="0000000000000000"; --palavra na fila de bits e proxpalavra
signal proxnum, proxdisplay: std_logic_vector(3 downto 0); --sinais de controle de algarismo e posicao do display
signal Dis: std_logic_vector(2 downto 0); --Sinal da posicao da posicao a partir do contador de 9 bits
signal proxfig,Fig: std_logic_vector(1 downto 0):="00"; --Sinal que pega o bit mais significativo e o sexto bit, para a logica de configuraao da palavra
signal configur: std_logic:='0';
---------------------------------------------------------------

begin

		Dis<=EN(7 downto 5); --Posicao do display baseada no contador de 9 bits
		
		proxnum <= NUM1 when Dis="001" else 
					  NUM2 when Dis="010" else
					  NUM3 when Dis="011" else
					  NUM4 when Dis="100" else
					  NUM5 when Dis="101" else
					  NUM6 when Dis="110" else
					  NUM7 when Dis="111" else
					  NUM0;

		proxdisplay <= 	"0010" when Dis="001" else 
								"0011" when Dis="010" else
								"0100" when Dis="011" else
								"0101" when Dis="100" else
								"0110" when Dis="101" else
								"0111" when Dis="110" else
								"1000" when Dis="111" else
								"0001";
	
		proxpalavra<=	"0000110000000001" when (configur = '0' and Dis = "000") else -- modo normal
							"0000101111111111" when (configur = '0' and Dis = "001") else -- scan todos
							"0000101000001111" when (configur = '0' and Dis = "010") else -- intensidade
							"0000100111111111" when (configur = '0' and Dis = "011") else -- BCD
							--"1111111111111111" when (configur = '0' and Dis = "100") else
							--"0000001100000111";
							--"0000001101010101";
							--"0000"&"0001"&"01010111";
							"0000"&proxdisplay&"0000"&proxnum;
						
		 
	process(CLK) --Processo que atualiza os valores do componente
	begin
			if(CLK'event and CLK='0') then -- As configuraes de proximo estado podem ser feitas a qualquer momento
				EN<=EN+"000000001";
				configur <= EN(8) or configur;

				if(EN(4) = '0') then --Coloca a proxpalavra na fila de bits no "final" do CS='1' 
					palavra<=proxpalavra;
				else
					palavra<=palavra(14 downto 0)&'0'; --Coloca o proximo bit da fila no bus a cada clock quando CS='0'					
--					palavra<='0'&palavra(15 downto 1); --Coloca o proximo bit da fila no bus a cada clock quando CS='0'
				end if;
			end if;
	end process;


	Dout<=palavra(15); --Bus: sinal sendo passado para o display
--	Dout<=palavra(0); --Bus: sinal sendo passado para o display
	CS <= not EN(4);  --Sinal CS que controla a habilitao da escrita no display
end comportamento;	



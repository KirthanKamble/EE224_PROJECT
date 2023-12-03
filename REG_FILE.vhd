library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity REG_FILE is
    port (
        A1 : in std_logic_vector (2 downto 0);
        A2 : in std_logic_vector (2 downto 0);
        A3 : in std_logic_vector (15 downto 0);
        A4 : in std_logic_vector (2 downto 0);

        D1 : out std_logic_vector (15 downto 0);
        D2 : out std_logic_vector (15 downto 0);
        D3 : out std_logic_vector (15 downto 0);
        D4 : in std_logic_vector  (15 downto 0);
		  
		  ra : out std_logic_vector (15 downto 0);
		  rb : out std_logic_vector (15 downto 0);
		  rc : out std_logic_vector (15 downto 0);

        RF_W : in std_logic;
        RF_IP: in std_logic;
		  clk  : in std_logic;
		  rst  : in std_logic
    );
end entity REG_FILE;

architecture rtl of REG_FILE is

    type Register_Block is array (0 to 7) of std_logic_vector (15 downto 0);
    signal registers : Register_Block := ((others => "0000000000000000"));
begin
    Reg_write : process(RF_W, RF_IP, clk, rst)
    begin 
        --if (rising_edge(clk)) then
		if (RF_w = '1' and rst = '0') then
            registers(to_integer(unsigned(A4))) <= D4;
		elsif(rst = '1') then
			for i in 0 to 7 loop
			registers(i) <= "0000000000000000";
			end loop;
      end if;
		  
		  if (RF_IP = '1') then
            registers(7) <= A3;
			else
				registers(7)<=registers(7);
        end if;
		  --end if;
    end process;
	 
--    IP_write : process(RF_IP)
--    begin
--        --if (clk='1' and clk'event) then
--		  if (RF_IP = '1') then
--            registers(7) <= A3;
--			else
--				registers(7)<=registers(7);
--        end if;
--		  --end if;
--    end process;


    D1 <= registers(to_integer(unsigned(A1)));
    D2 <= registers(to_integer(unsigned(A2)));
    D3 <= registers(7);
	 ra <= registers(0);
	 rb <= registers(1);
	 rc <= registers(2);
    
end architecture;

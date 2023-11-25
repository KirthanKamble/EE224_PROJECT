library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity REG_FILE is
    port (
        A1 : in std_logic_vector (3 downto 0);
        A2 : in std_logic_vector (3 downto 0);
        A3 : in std_logic_vector (15 downto 0);
        A4 : in std_logic_vector (3 downto 0);

        D1 : out std_logic_vector (15 downto 0);
        D2 : out std_logic_vector (15 downto 0);
        D3 : out std_logic_vector (15 downto 0);
        D4 : in std_logic_vector (15 downto 0);

        RF_W : in std_logic;
		  RF_IP: in std_logic 
    );
end entity REG_FILE;

architecture rtl of REG_FILE is

    type Register_Block is array (0 to 7) of std_logic_vector (15 downto 0);
    signal registers : Register_Block := ((others => (others => '0')));

begin
    process(RF_W, A4, D4)
    begin 
        if rising_edge(RF_W) then 
            registers(to_integer(unsigned(A4))) <= D4;
        end if;
    end process;
	 
	 process(RF_IP, A3)
    begin 
        if rising_edge(RF_IP) then 
            registers(7) <= A3;
        end if;
    end process;

    D1 <= registers(to_integer(unsigned(A1)));
    D2 <= registers(to_integer(unsigned(A2)));
    D3 <= registers(7);
    
end architecture;

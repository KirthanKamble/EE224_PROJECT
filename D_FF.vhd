library ieee;
use ieee.std_logic_1164.all;

entity D_FF is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        D     : in std_logic;
        Q     : out std_logic 
    );
end entity D_FF;

architecture rtl of D_FF is

begin
                clock_process: process(clk, reset)
                begin
                    if(reset = '0') then 
                        if(rising_edge(clk)) then
                            Q <= D;
                        end if;

                    elsif (reset='1') then
                        Q <= '0';

    end process clock_process;

end architecture;
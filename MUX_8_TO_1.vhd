library ieee;
use ieee.std_logic_1164.all;

entity MUX_8_TO_1 is
    port (
        I0 : in std_logic_vector (15 downto 0);
        I1 : in std_logic_vector (15 downto 0);
        I2 : in std_logic_vector (15 downto 0);
        I3 : in std_logic_vector (15 downto 0);
        I4 : in std_logic_vector (15 downto 0);
        I5 : in std_logic_vector (15 downto 0);
        I6 : in std_logic_vector (15 downto 0);
        I7 : in std_logic_vector (15 downto 0);

        S  : in std_logic_vector (2 downto 0);

        Y  : out std_logic_vector (15 downto 0)
    );
end entity MUX_8_TO_1;

architecture rtl of MUX_8_TO_1 is
    
begin
    with S select
        Y <= I0 when "000",
             I1 when "001",
             I2 when "010",
             I3 when "011",
             I4 when "100",
             I5 when "101",
             I6 when "110",
             I7 when "111",
             std_logic_vector(to_unsigned(0, 16)) when others;

end architecture;

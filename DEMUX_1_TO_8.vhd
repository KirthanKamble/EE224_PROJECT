library ieee;
use ieee.std_logic_1164.all;

entity DEMUX_1_TO_8 is
    port (
        I : in std_logic_vector (15 downto 0);
        S : in std_logic_vector (2 downto 0);
        E : in std_logic;

        Y0 : out std_logic_vector (15 downto 0);
        Y1 : out std_logic_vector (15 downto 0);
        Y2 : out std_logic_vector (15 downto 0);
        Y3 : out std_logic_vector (15 downto 0);
        Y4 : out std_logic_vector (15 downto 0);
        Y5 : out std_logic_vector (15 downto 0);
        Y6 : out std_logic_vector (15 downto 0);
        Y7 : out std_logic_vector (15 downto 0)
    );
end entity DEMUX_1_TO_8;

architecture rtl of DEMUX_1_TO_8 is

begin
    enable: if (E='1') generate
        with S select
        Y0 <= I when "000",
        Y1 <= I when "001",
        Y2 <= I when "010",
        Y3 <= I when "011",
        Y4 <= I when "100",
        Y5 <= I when "101",
        Y6 <= I when "110",
        Y7 <= I when "111";

    end generate enable;
end architecture;
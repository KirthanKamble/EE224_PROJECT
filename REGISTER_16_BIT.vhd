library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity REGISTER_16_BIT is
    port (
        Clk   : in std_logic;
        Reset : in std_logic;
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end entity REGISTER_16_BIT;

architecture rtl of REGISTER_16_BIT is

    component D_FF is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            preset: in std_logic;
            D     : in std_logic;
            Q     : out std_logic 
        );
    end component D_FF;

begin
    
    D00: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(0), Q=>data_out(0));
    D01: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(1), Q=>data_out(1));
    D02: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(2), Q=>data_out(2));
    D03: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(3), Q=>data_out(3));
    D04: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(4), Q=>data_out(4));
    D05: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(5), Q=>data_out(5));
    D06: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(6), Q=>data_out(6));
    D07: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(7), Q=>data_out(7));
    D08: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(8), Q=>data_out(8));
    D09: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(9), Q=>data_out(9));
    D10: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(10), Q=>data_out(10));
    D11: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(11), Q=>data_out(11));
    D12: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(12), Q=>data_out(12));
    D13: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(13), Q=>data_out(13));
    D14: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(14), Q=>data_out(14));
    D15: D_FF port map (clk=>Clk, reset=>Reset, preset=>'0', D=>data_in(15), Q=>data_out(15));

end architecture;
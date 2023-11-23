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

        D1 : out std_logic_vetor (15 downto 0);
        D2 : out std_logic_vetor (15 downto 0);
        D3 : out std_logic_vetor (15 downto 0);
        D4 : out std_logic_vetor (15 downto 0);

        RF_W : in std_logichello i am rg what to do plz let me do som
    );
end entity REG_FILE;

architecture rtl of REG_FILE is

    component REGISTER_16_BIT is
        port (
            Clk   : in std_logic;
            Reset : in std_logic;
            data_in : in std_logic_vector(15 downto 0);
            data_out : out std_logic_vector(15 downto 0)
        );
    end component REGISTER_16_BIT;

    component MUX_8_TO_1 is
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
    end component MUX_8_TO_1;

    component DEMUX_1_TO_8 is
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
    end component DEMUX_1_TO_8;

begin
    A1: 

    

end architecture;
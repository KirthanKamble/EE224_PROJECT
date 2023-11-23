library ieee;
use ieee.std_logic_1164.all;

entity ADDER_16_BIT is
    port (
        data_A : in std_logic_vector (15 downto 0);
        data_B : in std_logic_vector (15 downto 0);
        data_C : out std_logic_vector (15 downto 0)
    );
end entity ADDER_16_BIT;

architecture rtl of ADDER_16_BIT is

    signal C_par, S_par : std_logic := '0';

    component FULL_ADDER is
        port (
            A,B,Ci: in std_logic;
            S,Co  : out std_logic
        );
    end component FULL_ADDER;

begin
    add_instance : for i in 0 to 15 generate 
        adder: FULL_ADDER port map ()
    end generate add_instance;

end architecture;

---------------------------------------------------------------------------
-- for any entity that goes into alu use entity definition as follows: 
-- entity entity_name is
--port (
--    data_A : in std_logic_vector (15 downto 0);
--    data_B : in std_logic_vector (15 downto 0);
--    data_C : out std_logic_vector (15 downto 0)
--);
--end entity entity_name;
----------------------------------------------------------------------------
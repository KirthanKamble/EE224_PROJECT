library ieee;
use ieee.std_logic_1164.all;

entity ADDER_16_BIT is
    port (
        data_A : in std_logic_vector (15 downto 0);
        data_B : in std_logic_vector (15 downto 0);
        M      : in std_logic;
        data_C : out std_logic_vector (15 downto 0)
    );
end entity ADDER_16_BIT;

architecture rtl of ADDER_16_BIT is

    signal C_par : std_logic;

    component FULL_ADDER is
        port (
            A,B,Ci: in std_logic;
            S,Co  : out std_logic
        );
    end component FULL_ADDER;

begin

    C_par <= M; --instanciate M to C_par to be used in addition/subatraction

    add_instance: for i in 0 to 15 generate 
        add_bit: FULL_ADDER port map (A=>data_A(i), 
                                      B=>(M xor data_B(i)), 
                                      Ci=>C_par, 
                                      S=>data_C(i), 
                                      Co=>C_par);
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
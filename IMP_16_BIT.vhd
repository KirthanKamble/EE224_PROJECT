library ieee;
use ieee.std_logic_1164.all;

entity IMP_16_BIT is
    port (
        data_A : in std_logic_vector (15 downto 0);
        data_B : in std_logic_vector (15 downto 0);
        data_C : out std_logic_vector (15 downto 0)
    );
end entity IMP_16_BIT;

architecture rtl of IMP_16_BIT is

begin
    bitwise_imp : for i in 0 to 15 generate 
        data_C(i) <= (not data_A(i)) or data_B(i);
    end generate bitwise_imp;

end architecture;
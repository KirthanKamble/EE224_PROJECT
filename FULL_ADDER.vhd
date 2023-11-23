library ieee;
use ieee.std_logic_1164.all;

entity FULL_ADDER is
    port (
        A,B,Ci: in std_logic;
        S,Co  : out std_logic
    );
end entity FULL_ADDER;

architecture rtl of FULL_ADDER is

    signal G,P : std_logic;

begin
    G <= A and B;
    P <= (A xor B);
    Co <= G or (P and Ci); 
    S <= P xor Ci;
end architecture;
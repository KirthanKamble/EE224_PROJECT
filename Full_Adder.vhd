library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Gates.all;

entity Full_Adder is
	port(A,B, Cin: in std_logic; S,C: out std_logic);
end entity Full_Adder;

architecture Struct of Full_Adder is
signal D1,D2,D3: std_logic;
begin
	D1 <= A xor B;
	S <= D1 xor Cin;
	D2 <= A nand B;
	D3 <= Cin nand D1;
	C <= D2 nand D3;
end Struct;
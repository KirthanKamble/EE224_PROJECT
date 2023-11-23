library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Gates.all;

entity Four_Bit_Adder_Substractor is
	port(A,B: in std_logic_vector(3 downto 0);M: in std_logic;S: out std_logic_vector(3 downto 0);Cout: out std_logic);
end entity Four_Bit_Adder_Substractor;

architecture Struct of Four_Bit_Adder_Substractor is
component Full_Adder is
	port(A,B,Cin: in std_logic; S,C: out std_logic);
end component Full_Adder;

signal Carry: std_logic_vector(2 downto 0);
signal B_XOR_M: std_logic_vector(3 downto 0);
begin
	x1: XOR_2 port map(A=>B(0),B=>M,Y=>B_XOR_M(0));
	x2: XOR_2 port map(A=>B(1),B=>M,Y=>B_XOR_M(1));
	x3: XOR_2 port map(A=>B(2),B=>M,Y=>B_XOR_M(2));
	x4: XOR_2 port map(A=>B(3),B=>M,Y=>B_XOR_M(3));
	fa1: Full_Adder port map(A=>A(0),B=>B_XOR_M(0),Cin=>M,S=>S(0),C=>Carry(0));
	fa2: Full_Adder port map(A=>A(1),B=>B_XOR_M(1),Cin=>Carry(0),S=>S(1),C=>Carry(1));
	fa3: Full_Adder port map(A=>A(2),B=>B_XOR_M(2),Cin=>Carry(1),S=>S(2),C=>Carry(2));
	fa4: Full_Adder port map(A=>A(3),B=>B_XOR_M(3),Cin=>Carry(2),S=>S(3),C=>Cout);
end Struct;
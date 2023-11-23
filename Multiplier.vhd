library ieee;
use ieee.std_logic_1164.all;

library work;
use work.gates.all;

entity Multiplier is 
	port(data_A,data_B: in std_logic_vector(15 downto 0); 
	     data_C: out std_logic_vector(15 downto 0)
	    );
end entity Multiplier;

architecture St of Multiplier is
	
component Four_Bit_Adder_Substractor is
	port(A,B: in std_logic_vector(3 downto 0);
	     M  : in std_logic;
	     S  : out std_logic_vector(3 downto 0);
	     Cout: out std_logic
	    );
end component Four_Bit_Adder_Substractor;

signal A1,B1,AB0,AB1,AB2,AB3,s1,s2,s3,car: std_logic_vector(3 downto 0);
begin
	A1 <= data_A(3 downto 0);
	B1 <= data_B(3 downto 0);
	
	k1: for i in 0 to 3 generate:
	begin
	AB0(i) <= A1(i) and B1(0);
	AB1(i) <= A1(i) and B1(1);
	AB2(i) <= A1(i) and B1(2);
	AB3(i) <= A1(i) and B1(3);
	end generate;
	
	f1: Four_Bit_Adder_Substractor port map(A(2 downto 0)=>AB0(3 downto 1),A(3)=>'0',B=>AB1,M=>'0',S=>S1,Cout=>car(0));
	f2: Four_Bit_Adder_Substractor port map(A(2 downto 0)=>S1(3 downto 1),A(3)=>car(0),B=>AB2,M=>'0',S=>S2,Cout=>car(1));
	f3: Four_Bit_Adder_Substractor port map(A(2 downto 0)=>S2(3 downto 1),A(3)=>car(1),B=>AB3,M=>'0',S=>S3,Cout=>car(2));
	
	data_C(0) <= AB0(0);
	data_C(1) <= S1(0);
	data_C(2) <= S2(0);
	data_C(6 downto 3) <= S3;
	data_C(7) <= car(2);
	data_C(15 downto 8) <= "00000000";
end architecture St;

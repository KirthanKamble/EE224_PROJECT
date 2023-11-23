
library ieee;
use ieee.std_logic_1164.all;

--for any entity that goes into alu use entity definition as follows: 
entity concat is
port (
    data_A : in std_logic_vector (15 downto 0);
    data_B : in std_logic_vector (15 downto 0);
    data_C : out std_logic_vector (15 downto 0)
);
end entity concat;

architecture df of concat is
	
	signal A_int : std_logic_vector(8 downto 0);
	signal B_int : std_logic_vector(6 downto 0);
	
begin
	A_int  <= data_A(8 downto 0);
	B_int  <= data_B(6 downto 0);
	data_C <= A_int & B_int;

end architecture;
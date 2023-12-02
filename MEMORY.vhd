
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity MEMORY is
    port (
        Mem_rAdd : in  std_logic_vector(15 downto 0);
        Mem_rDat : out std_logic_vector(15 downto 0);

        Mem_wAdd : in std_logic_vector(15 downto 0);
        Mem_wDat : in std_logic_vector(15 downto 0);
        Mem_w    : in std_logic;
		  clk      : in std_logic
    );
end entity MEMORY;

architecture rtl of MEMORY is

    type mem_unit is array (65535 downto 0) of std_logic_vector(15 downto 0);
    SIGNAL Memory_Data : mem_unit := (
		0 => "0000001000111101",
		1 => "0111010000111110",
		2 => "0000000110000001",
		3 => "0010001001101000",
		4 => "0001101110101000",
		5 => "0000000011000000",
		6 => "0001010011011000",
		7 => "0001110101101000",
		8 => "1000101000000010",
		9 => "1011000000000110",
		10 => "0101011000111111",
		11 => "1011000000001011",
		61 => x"0004",
		62 => x"00F8",
		OTHERS => (OTHERS => '1'));

begin
    Mem_rDat <= Memory_Data(to_integer(unsigned(Mem_rAdd)));

    Memory_write: process(Mem_w, Mem_wAdd, Clk)
    begin 
        if (Mem_W = '1' and rising_edge(clk)) then 
            Memory_Data(to_integer(unsigned(Mem_wAdd))) <= Mem_wDat;
        end if;
    end process;

end architecture;
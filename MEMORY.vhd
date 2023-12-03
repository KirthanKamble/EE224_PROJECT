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
		0 => "0000000001010000",
		1 => "0010000001010000",
		2 => "0011000001010000",
		3 => "0100000001010000",
		4 => "0101000001010000",
		5 => "0110000001010000",
		6 => "0001000001000010",
		7 => "1000000000000010",
		8 => "1001000000000010",
		9 => "1010000001000010",
		10 => "1011000001000010",
		11 => "1100000001000010",
		12 => "1101000000000001",
		13 => "1111000001000000",
		
		OTHERS => "0000000001010000");

begin
    Mem_rDat <= Memory_Data(to_integer(unsigned(Mem_rAdd)));

    Memory_write: process(Mem_w, Mem_wAdd, Clk)
    begin 
        if (Mem_W = '1' and rising_edge(clk)) then 
            Memory_Data(to_integer(unsigned(Mem_wAdd))) <= Mem_wDat;
        end if;
    end process;

end architecture;

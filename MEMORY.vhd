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
		0  => "1001000000000001",
		1  => "1001001000000001",
		2  => "1100000001000001",
		3  => "1010011001000001",
		4  => "1010100001000000",
		5  => "1010000001000000",
		6  => "1010110001000000",
		7  => "1000000011111111",
		8  => "1000000000000000",
		9  => "1001001000000000",
		10 => "1001000000000001",
		11 => "1010001000000000",
		12 => "1101000001000000",
		13 => "0110000001111000",
		14 => "1010001010000000",
		15 => "0110000001010000",
		16 => "0001000001000010",
		17 => "1000000000000010",
		18 => "1001000000000010",
		19 => "1010000001000010",
		20 => "1011000001000010",
		21 => "1100000001000010",
		22 => "1101000000000001",
		23 => "1111000001000000",
		41024 => "0000000000000100",
		
		OTHERS => "0000000000000001");

begin
    Mem_rDat <= Memory_Data(to_integer(unsigned(Mem_rAdd)));

    Memory_write: process(Mem_w, Mem_wAdd, Clk)
    begin 
        if (Mem_W = '1' and rising_edge(clk)) then 
            Memory_Data(to_integer(unsigned(Mem_wAdd))) <= Mem_wDat;
        end if;
    end process;

end architecture;

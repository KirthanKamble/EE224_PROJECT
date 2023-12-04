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
		0  => "1010000001000000",
		1  => "1010001000000000",
		2  => "1010010001000000",
		3  => "1010011001000001",
		4  => "1010100001000000",
		5  => "1010101001000001",
		6  => "1010110001000000",
		7  => "1000000011110001",
		8  => "1001000011110001",
		9  => "1010000001000000",
		10 => "1010001000000000",
		11 => "1011000001000000",
		12 => "0110000001111000",
		13 => "1010001010000000",
		14 => "0110000001010000",
		15 => "0001000001000010",
		16 => "1000000000000010",
		17 => "1001000000000010",
		18 => "1010000001000010",
		19 => "1011000001000010",
		20 => "1100000001000010",
		21 => "1101000000000001",
		22 => "1111000001000000",
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

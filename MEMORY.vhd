library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity MEMORY is
    port (
        Mem_Add : in std_logic_vector(15 downto 0);
        Mem_Dat : out std_logic_vector(15 downto 0);

        Mem_W_Add : in std_logic_vector(15 downto 0);
        Mem_W_Dat : in std_logic_vector(15 downto 0);
        Mem_W     : in std_logic
    );
end entity MEMORY;

architecture rtl of MEMORY is

    type mem_unit is array (65535 downto 0) of std_logic_vector(15 downto 0);
    
    signal Memory_Data : mem_unit;

begin
    Mem_Dat <= Memory_Data(to_integer(Mem_Add));

    Memory_write: process(Mem_W, Mem_W_Add, Mem_W_Dat)
    begin 
        if Mem_W = 1 then 
            Memory_Data(to_integer(Mem_W_Add)) <= Mem_W_Dat;
        end if;
    end process;

end architecture;
library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity Testbench;

architecture Test of Testbench is
component IITBCPU is
    port (
        clk : in std_logic;
		  deb : out integer;
		  deb2: out std_logic_vector(15 downto 0)
    );
end component IITBCPU;

signal clk: std_logic := '0';
signal deb: integer;
signal deb2 : std_logic_vector(15 downto 0);
begin
	IITBCPU_1 : IITBCPU port map(clk,deb, deb2);
	
process
begin
	clk <= not clk;
	wait for 100ns;
end process;

end architecture;

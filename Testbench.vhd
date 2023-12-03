library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity Testbench;

architecture Test of Testbench is
component IITBCPU is
    port (
        clk : in std_logic;
		  reset : in std_logic;
		  deb : out integer;
		  deb2: out std_logic_vector(15 downto 0);
		  IR1 : out std_logic_vector(15 downto 0);
		  T3_1: out std_logic_vector(15 downto 0);
		  Mem_rDat1 : out std_logic_vector(15 downto 0);
		  rga1 : out std_logic_vector(15 downto 0);
		  rb1 : out std_logic_vector(15 downto 0);
		  rc1 : out std_logic_vector(15 downto 0)
    );
end component IITBCPU;

signal clk: std_logic := '0';
signal reset: std_logic :='1';
signal deb: integer;
signal deb2: std_logic_vector(15 downto 0);
signal IR1 : std_logic_vector(15 downto 0);
signal T3_1 : std_logic_vector(15 downto 0);
signal Mem_rDat1 : std_logic_vector(15 downto 0);
signal rga1 : std_logic_vector(15 downto 0);
signal rb1 : std_logic_vector(15 downto 0);
signal rc1 : std_logic_vector(15 downto 0);

begin
	IITBCPU_1 : IITBCPU port map(clk, reset, deb,deb2,IR1, T3_1, Mem_rDat1, rga1, rb1, rc1);
	
process
begin
	clk <= not clk;
	wait for 100ns;
end process;

process
begin
	reset <= not reset;
	wait for 5000ns;
end process;

end architecture;

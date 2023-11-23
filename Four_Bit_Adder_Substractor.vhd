library ieee;
use ieee.std_logic_1164.all;

library work;
use work.Gates.all;

entity FOUR_BIT_ADDER_SUBSTRACTOR is
	port(A : in std_logic_vector (3 downto 0);
		 B : in std_logic_vector (3 downto 0);
	     M : in std_logic;
	     S : out std_logic_vector(3 downto 0);
	     Co: out std_logic);
end entity FOUR_BIT_ADDER_SUBSTRACTOR;

architecture Struct of FOUR_BIT_ADDER_SUBSTRACTOR is

	signal C_par : std_logic;

	component FULL_ADDER is
		port (
			A,B,Ci: in std_logic;
			S,Co  : out std_logic
		);
	end component FULL_ADDER;

begin
	C_par <= M; --instanciate M to C_par to be used in addition/subatraction

    add_instance: for i in 0 to 3 generate 
        add_bit: FULL_ADDER port map (A=>A(i), 
                                      B=>(M xor B(i)), 
                                      Ci=>C_par, 
                                      S=>C(i), 
                                      Co=>C_par);
    end generate add_instance;
end Struct;

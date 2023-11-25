library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        alu_A : in std_logic_vector(15 downto 0);
        alu_B : in std_logic_vector(15 downto 0);
        instr : in integer;
        alu_C : out std_logic_vector(15 downto 0)
    );
end entity ALU;

architecture rtl of ALU is

    function perform_addition(A, B : std_logic_vector (15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
		variable C_par       : std_logic := '0';
		variable G, P        : std_logic;
    begin
			add_instance: for i in 0 to 15 loop
								G := A(i) and B(i);
								P := A(i) xor B(i);
								temp_result(i) := P xor C_par;
								C_par := G or (P and C_par);
			end loop add_instance;						
         return temp_result;
    end function;

    function perform_subtraction(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
		variable C_par       : std_logic := '1';
		variable G, P        : std_logic;
    begin
            sub_instance: for i in 0 to 15 loop
							  G := A(i) and (not B(i));
							  P := A(i) xor (not B(i));
							  temp_result(i) := P xor C_par;
							  C_par := G or (P and C_par);
		    end loop sub_instance;						  
        return temp_result;
    end function;

    function perform_multiplication(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
		variable product     : std_logic_vector(7 downto 0);
		variable A_par       : std_logic_vector(3 downto 0) := A(3 downto 0);
		variable B_par       : std_logic_vector(3 downto 0) := B(3 downto 0);
    begin
        outer: for i in 0 to 3 loop 
		   inner: for j in 0 to 3 loop
				product(i+j) := product(i+j) xor (A(i) and B(j)) ;
			end loop inner;
		  end loop outer;
		  
		  temp_result := "00000000" & product;
		return temp_result;
    end function;

    function perform_and(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        and_instance: for i in 0 to 15 loop
								temp_result(i) := A(i) and B(i);
		  end loop and_instance;	
        return temp_result(15 downto 0);
    end function;

    function perform_or(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        or_instance: for i in 0 to 15 loop
								temp_result(i) := A(i) or B(i);
			end loop or_instance;
        return temp_result(15 downto 0);
    end function;

    function perform_imp(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        imp_instance: for i in 0 to 15 loop
								temp_result(i) := (not A(i)) or B(i);
			end loop imp_instance;
        return temp_result(15 downto 0);
    end function;

    function perform_LHI(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
		  variable A_par       : std_logic_vector(8 downto 0) := A(8 downto 0);
		  variable B_par       : std_logic_vector(6 downto 0) := B(6 downto 0);
    begin
					  temp_result := A_par & B_par;
        return temp_result(15 downto 0);
    end function;

     function perform_LLI(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
		  variable A_par       : std_logic_vector(8 downto 0) := A(8 downto 0);
		  variable B_par       : std_logic_vector(6 downto 0) := B(6 downto 0);
    begin
					  temp_result := B_par & A_par;
        return temp_result(15 downto 0);
    end function;
    
begin 
    with instr select
        alu_C <= perform_addition(alu_A, alu_B)       when 1,
                 perform_subtraction (alu_A, alu_B)   when 2,
                 perform_multiplication(alu_A, alu_B) when 3,
                 perform_and(alu_A, alu_B)            when 4,
                 perform_or(alu_A, alu_B)	      when 5,
                 perform_imp(alu_A, alu_B)	      when 6,
                 perfomr_LHI(alu_A, alu_B)	      when 7,
	         perfomr_LLI(alu_A, alu_B)	      when 8;


end architecture;

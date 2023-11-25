library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
    port (
        alu_A : in std_logic_vector(15 downto 0);
        alu_B : in std_logic_vector(15 downto 0);
        instr : in integer;
        alu_C : out std_logic_vector(15 downto 0);
        C, Z  : out std_logic
    );
end entity ALU;

architecture rtl of ALU is

    function perform_addition(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
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
        variable product     : std_logic_vector(7 downto 0) := "00000000";
	variable AB0,AB1,AB2,AB3 : std_logic_vector(3 downto 0);
    begin
	k1: for i in 0 to 3 loop:
	begin
		AB0(i) <= A(i) and B(0);
		AB1(i) <= A(i) and B(1);
		AB2(i) <= A(i) and B(2);
		AB3(i) <= A(i) and B(3);
	end loop k1;

	temp_result(0) := AB0(0);
	temp_result(1) := AB0(1) or AB1(0);
	temp_result(2) := (AB0(1) and AB1(0)) or AB0(2) or AB1(1) or AB2(0);
	temp_result(3) := (AB0(1) and AB1(0) and AB0(2) and AB1(1) and AB2(0)) or AB0(3) or AB1(2) or AB2(1) or AB3(0);
	temp_result(4) := (AB0(1) and AB1(0) and AB0(2) and AB1(1) and AB2(0) and AB0(3) and AB1(2) and AB2(1) and AB3(0)) or AB1(3) or AB2(2) or AB3(1);
	temp_result(5) := (AB0(1) and AB1(0) and AB0(2) and AB1(1) and AB2(0) and AB0(3) and AB1(2) and AB2(1) and AB3(0) and AB1(3) and AB2(2) and AB3(1)) or AB2(3) or AB3(2);
	temp_result(6) := (AB0(1) and AB1(0) and AB0(2) and AB1(1) and AB2(0) and AB0(3) and AB1(2) and AB2(1) and AB3(0) and AB1(3) and AB2(2) and AB3(1) and AB2(3) and AB3(2)) or AB3(3);
	temp_result(7) := AB0(1) and AB1(0) and AB0(2) and AB1(1) and AB2(0) and AB0(3) and AB1(2) and AB2(1) and AB3(0) and AB1(3) and AB2(2) and AB3(1) and AB2(3) and AB3(2) and AB3(3);
	temp_result(15 downto 8) := "00000000";
        --outer: for i in 0 to 3 loop 
        --   inner: for j in 0 to 3 loop
        --        product(i+j) := product(i+j) xor (A(i) and B(j));
        --    end loop inner;
        --end loop outer;
        
        --temp_result := "00000000" & product;
        return temp_result;
    end function;    

    function perform_and(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        and_instance: for i in 0 to 15 loop
            temp_result(i) := A(i) and B(i);
        end loop and_instance;
        return temp_result;
    end function;    

    function perform_or(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        or_instance: for i in 0 to 15 loop
            temp_result(i) := A(i) or B(i);
        end loop or_instance;
        return temp_result;
    end function;    

    function perform_imp(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        imp_instance: for i in 0 to 15 loop
            temp_result(i) := (not A(i)) or B(i);
        end loop imp_instance;
        return temp_result;
    end function;    

    function perform_LLI(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
        variable A_par       : std_logic_vector(8 downto 0) := A(8 downto 0);
        variable B_par       : std_logic_vector(6 downto 0) := B(6 downto 0);
    begin
        temp_result := A_par & B_par;
        return temp_result;
    end function;    

    function perform_LHI(A, B : std_logic_vector(15 downto 0)) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
        variable A_par       : std_logic_vector(8 downto 0) := A(8 downto 0);
        variable B_par       : std_logic_vector(6 downto 0) := B(6 downto 0);
    begin
        temp_result := B_par & A_par;
        return temp_result;
    end function;    

    function carry_flag(A, B: std_logic_vector(15 downto 0); M: std_logic) return std_logic is
        variable result : std_logic := M;
        variable G, P   : std_logic;
    begin 
        add_instance: for i in 0 to 15 loop 
            G := A(i) and B(i);
            P := A(i) xor B(i);
            result := G or (P and result);
        end loop add_instance;
        return result;
    end function;    

    function z_flag(A, B: std_logic_vector(15 downto 0)) return std_logic is
        variable result : std_logic;
        variable subtraction : std_logic_vector(15 downto 0) := perform_subtraction(A, B);
    begin
        z_instance: if subtraction = "0000000000000000" generate
                        result := '1';
                    else 
                        result := '0'; 
                    end generate z_instance;
    
        return result;
    end function;    
  
begin 
    with instr select
        alu_C <= perform_addition(alu_A, alu_B)       when 1,
                 perform_subtraction (alu_A, alu_B)   when 2,
                 perform_multiplication(alu_A, alu_B) when 3,
                 perform_and(alu_A, alu_B)            when 4,
                 perform_or(alu_A, alu_B)	          when 5,
                 perform_imp(alu_A, alu_B)	          when 6,
                 perfomr_LHI(alu_A, alu_B)	          when 7,
	             perfomr_LLI(alu_A, alu_B)	          when 8;

    with instr select 
        C <= carry_flag(alu_A, alu_B, '0') when 1,
             carry_flag(alu_A, alu_B, '1') when 2,
             '0' when others;
             
    with instr select 
        Z <= z_flag(alu_A, alu_B) when 2,
             '0' when others;

end architecture;

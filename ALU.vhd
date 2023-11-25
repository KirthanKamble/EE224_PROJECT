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

    component ADDER_16_BIT is
        port (
            data_A : in std_logic_vector (15 downto 0);
            data_B : in std_logic_vector (15 downto 0);
            M      : in std_logic;
            data_C : out std_logic_vector (15 downto 0)
        );
    end component ADDER_16_BIT;

    component Multiplier is 
        port (
            data_A : in std_logic_vector (15 downto 0);
            data_B : in std_logic_vector (15 downto 0);
            data_C : out std_logic_vector (15 downto 0)
        );
    end component Multiplier;

    component AND_16_BIT is
        port (
            data_A : in std_logic_vector (15 downto 0);
            data_B : in std_logic_vector (15 downto 0);
            data_C : out std_logic_vector (15 downto 0)
        );
    end component AND_16_BIT;

    component OR_16_BIT is
        port (
            data_A : in std_logic_vector (15 downto 0);
            data_B : in std_logic_vector (15 downto 0);
            data_C : out std_logic_vector (15 downto 0)
        );
    end component OR_16_BIT;

    component IMP_16_BIT is
        port (
            data_A : in std_logic_vector (15 downto 0);
            data_B : in std_logic_vector (15 downto 0);
            data_C : out std_logic_vector (15 downto 0)
        );
    end component IMP_16_BIT;

    function perform_addition(A, B : std_logic_vector) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        ADDER_16_BIT_inst: ADDER_16_BIT port map (A, B, '0', temp_result);
        return temp_result;
    end function;

    function perform_subtraction(A, B : std_logic_vector) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        ADDER_16_BIT_inst: ADDER_16_BIT port map (A, B, '1', temp_result);
        return temp_result;
    end function;

    function perform_multiplication(A, B : std_logic_vector) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        Multiplier_inst: Multiplier port map (A, B, temp_result);
        return temp_result(15 downto 0);
    end function;

    function perform_and(A, B : std_logic_vector) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        and_inst: AND_16_BIT port map (A, B, temp_result);
        return temp_result(15 downto 0);
    end function;

    function perform_or(A, B : std_logic_vector) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        or_inst: OR_16_BIT port map (A, B, temp_result);
        return temp_result(15 downto 0);
    end function;

    function perform_imp(A, B : std_logic_vector) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        imp_inst: IMP_16_BIT port map (A, B, temp_result);
        return temp_result(15 downto 0);
    end function;

    function perform_concat(A, B : std_logic_vector) return std_logic_vector is
        variable temp_result : std_logic_vector(15 downto 0);
    begin
        coancat_inst: conacat port map (A, B, temp_result);
        return temp_result(15 downto 0);
    end function;
    
begin 
    with instr select
        alu_C <= perform_addition    	(alu_A, alu_B) when 1,
                 perform_subtraction	(alu_A, alu_B) when 2,
                 perform_multiplication(alu_A, alu_B) when 3,
                 perform_and				(alu_A, alu_B) when 4,
                 perform_or				(alu_A, alu_B)	when 5,
                 perform_imp 				(alu_A, alu_B)	when 6,
                 perfomr_concat 			(alu_A, alu_B)	when 7;

end architecture;
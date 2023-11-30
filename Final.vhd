
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity trial_check is
    port (
        S : in state;
        IR: in std_logic_vector(15 downto 0)
    );
end entity trial_check;

architecture rtl of trial_check is

    signal IR : std_logic_vector(15 downto 0) := (others => '0');
    signal T1, T2, T3 : std_logic_vector(15 downto 0);
    signal C_flag, Z_flag : std_logic;

    type state is (S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);

    type register_memory_unit is array(7 downto 0) of std_logic_vector(15 downto 0);
    signal register_memory : register_memory_unit := (others => "0000000000000000");

    type core_memory_unit is array(65535 downto 0) of std_logic_vector(15 downto 0);
    signal core_memory : core_memory_unit;

    signal trash : std_logic_vector(15 downto 0);

    component ALU is
        port (
            alu_A : in std_logic_vector(15 downto 0);
            alu_B : in std_logic_vector(15 downto 0);
            instr : in integer;
            alu_C : out std_logic_vector(15 downto 0);
            C, Z  : out std_logic
        );
    end component ALU;
	 
	 signal alu_a : std_logic_vector(15 downto 0);
	 signal alu_b : std_logic_vector(15 downto 0);
	 signal alu_c : std_logic_vector(15 downto 0);
	 signal instr : natural range 1 to 8 := 0;
	 signal C, Z  : std_logic;
	 
	 signal update_location : std_logic_vector(2 downto 0);
	 signal decision : std_logic_vector(15 downto 0);
	 signal sign_extended_Imm : std_logic_vector(15 downto 0);
	 signal shifted_sign_extended : std_logic_vector(15 downto 0); 
	 signal new_IP : std_logic_vector(15 downto 0);
	 signal branch_jump : std_logic_vector(15 downto 0);



begin

ALU_1 : ALU port map(alu_a, alu_b, instr, alu_c, C, Z);

state_process : process(S)
	begin
	case S is 
		when S1 =>
         update_ip : if ((IR(15 downto 14) = "11") or (IR(15 downto 12) = "0001")) then
								alu_a <= register_memory(7);
								alu_b <= std_logic_vector(to_unsigned(0, 16));
								instr := 1;
								alu_c <= T3;
								C     <= trash(0);
								Z     <= trash(1);
			
                     else
								alu_a <= register_memory(7);
								alu_b <= std_logic_vector(to_unsigned(2, 16));
								instr := 1;
								alu_c <= T3;
								C     <= trash(0);
								Z     <= trash(1);
                        
                     end if update_ip;
			IR <= core_memory(to_unsigned(register_memory(7)));
            

        when S2 => 
            
            T2 <= register_memory(to_unsigned(IR(8 downto 6)));
            register_memory(7) <= T3;
				T1 <= register_memory(to_unsigned(IR(11 downto 9)));
		  
		  when S3 =>
				update_condition: if (IR(15) = 1) then 
                                update_location <= IR(11 downto 9);
                              
										elsif (IR(15 downto 12) = "0001") then
                                update_location <= IR(8 downto 6);
                              
										elsif (IR(15) = 0) then
                                update_location <= IR(5 downto 3);
                              
										end if update_condition;
            
				register_memory(to_unsigned(update_location)) <= T3;

        when S4 =>
				decision_condition: if (IR(15 downto 12) = "0110") then
													decision <= T2;
										  elsif (IR(15 downto 14) = "10") then
													decision <= "00000000" & IR(8 downto 0);
										  elsif (IR(15 downto 12) = "0001") then 
													decision <= "0000000000" & IR(5 downto 0);
										  end if decision_condition;
				updation: 
					if ((IR(15) and IR(14)) or ((not IR(14)) and IR(13) and (not IR(12)))) then
							alu_a <= T1;
							alu_b <= decision;
							instr := 2;
							alu_c <= T3;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif ((not (IR(15) or IR(14) or IR(12)))) then
							alu_a <= T1;
							alu_b <= decision;
							instr := 1;
							alu_c <= T3;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15) and (not IR(14)) and IR(12)) then
							alu_a <= T1;
							alu_b <= decision;
							instr := 8;
							alu_c <= T3;
							C     <= C_flag;
							Z     <= Z_flag;
			   	
					elsif (IR(15) and (not IR(14)) and (not IR(12))) then
							alu_a <= T1;
							alu_b <= decision;
							instr := 7;
							alu_c <= T3;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "0011") then
							alu_a <= T1;
							alu_b <= decision;
							instr := 3;
							alu_c <= T3;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "1010") then
							alu_a <= T1;
							alu_b <= decision;
							instr := 5;
							alu_c <= T3;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "0100") then
							alu_a <= T1;
							alu_b <= decision;
							instr := 4;
							alu_c <= T3;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "1001") then
							alu_a <= T1;
							alu_b <= decision;
							instr := 6;
							alu_c <= T3;
							C     <= C_flag;
							Z     <= Z_flag;
               
					end if updation;
        

        when S5 =>
            
				sign_extended_Imm <= "0000000000" & IR(5 downto 0);
				alu_a <= sign_extended_Imm;
				alu_b <= T2;
				instr := 1;
				alu_c <= T3;
				C     <= trash(0);
				Z     <= trash(1);

        when S6 => 
				shifted_sign_extended <= "000000000" & IR(5 downto 0) & "0";
				alu_b <= sign_extended_Imm;
				alu_a <= register_memory(7);
				instr := 1;
				alu_c <= T3;
				C     <= trash(0);
				Z     <= trash(1);


        when S7 => 
            
            decision: if (IR(15 downto 13) = "110") then
                        new_IP <= T3;
                      elsif (IR(15 downto 12) = "1111") then 
                        new_IP <= register_memory(to_unsigned(IR(8 downto 6)));
                      end if decision;
            apply_decision: register_memory(7) <= new_IP;

        when S8 => 
            mem_data_retrive: T3 <= core_memory(to_unsigned(T3));

        when S9 =>
            mem_data_retrive: T1 <= core_memory(to_unsigned(T3));

        when S10 => 
            branch_condition: if (Z_flag = 1) then
                                 branch_jump <= "000000000" & IR(5 downto 0) & "0";
                              else
                                 branch_jump <= "0000000000000010"; --std_logic_vector(to_unsigned(2, 16));
                              end if branch_condition;
										
				alu_a <= register_memory(7);
				alu_b <= branch_jump;
				instr := 1;
				alu_c <= T3;
				C     <= trash(0);
				Z     <= trash(1);
		 
	end case;
	
end process state_process;
       
end architecture;

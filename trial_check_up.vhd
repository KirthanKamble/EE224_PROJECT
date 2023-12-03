
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

begin

state_trans : process(S)
	begin
	case S is 
		when S1 =>
         update_ip : if ((IR(15 downto 14) = "11") or (IR(15 downto 12) = "0001")) then
								alu_instance: ALU port map (register_memory(7), std_logic_vector(to_unsigned(0, 16)), 1, T3, trash(0), trash(0));
                     else generate
                        alu_instance: ALU port map (register_memory(7), std_logic_vector(to_unsigned(2, 16)), 1, T3, trash(0), trash(0)); --THIS PORT MAPPING SEEMS SUS
                     end generate update_ip;
			IR <= core_memory(to_unsigned(register_memory(7)));
            

        when S2 => 
            T1 <= register_memory(to_unsigned(IR(11 downto 9)));
            T2 <= register_memory(to_unsigned(IR(8 downto 6)));
            register_memory(7) <= T3;

        
		  
		  when S3 =>
            
				signal update_location : std_logic_vector(2 downto 0);
            
				update_condition: if (IR(15) = 1) then 
                                update_location <= IR(11 downto 9);
                              
										elsif (IR(15 downto 12) = "0001") then
                                update_location <= IR(8 downto 6);
                              
										elsif (IR(15) = 0) then
                                update_location <= IR(5 downto 3);
                              
										end if update_condition;
            
				register_memory(to_unsigned(update_location)) <= T3;

        when S4 =>
				signal decision : std_logic_vector(15 downto 0);
				decision_condition: if (IR(15 downto 12) = "0110") then
													decision <= T2;
										  elsif (IR(15 downto 14) = "10") then
													decision <= "00000000" & IR(8 downto 0);
										  elsif (IR(15 downto 12) = "0001") then 
													decision <= "0000000000" & IR(5 downto 0);
										  end if decision_condition;
				updation: 
					if ((IR(15) and IR(14)) or ((not IR(14)) and IR(13) and (not IR(12)))) generate
							update_instance:  ALU port map (T1, decision, 2, T3, C_flag, Z_flag); -- subtraction 
					
					elsif ((not (IR(15) or IR(14) or IR(12)))) generate
							update_instance:  ALU port map (T1, decision, 1, T3, C_flag, Z_flag); -- add
					
					elsif (IR(15) and (not IR(14)) and IR(12)) generate
							update_instance:  ALU port map (T1, decision, 8, T3, C_flag, Z_flag); -- LLI
			   	
					elsif (IR(15) and (not IR(14)) and (not IR(12))) generate 
							update_instance:  ALU port map (T1, decision, 7, T3, C_flag, Z_flag); -- LHI
					
					elsif (IR(15 downto 12) = "0011") generate
							update_instance:  ALU port map (T1, decision, 3, T3, C_flag, Z_flag); -- multiplication
					
					elsif (IR(15 downto 12) = "1010") generate
							update_insatance:  ALU port map (T1, decision, 5, T3, C_flag, Z_flag); -- or
					
					elsif (IR(15 downto 12) = "0100") generate
							update_instance:  ALU port map (T1, decision, 4, T3, C_flag, Z_flag); -- and
					
					elsif (IR(15 downto 12) = "1001") generate
							update_instance:  ALU port map (T1, decision, 6, T3, C_flag, Z_flag); -- imp 
               
					end generate updation;
        

        when S5 =>
            signal sign_extended_Imm : std_logic_vector(15 downto 0);
				sign_exteded_Imm <= "0000000000" & IR(5 downto 0);
            start: ALU port map (sign_extended_Imm, T2, 1, T3, trash(0), trash(1));

        when S6 => 
            signal shifted_sign_extended : std_logic_vector(15 downto 0); 
				signal shifted_sign_extendeed <= "000000000" & IR(5 downto 0) & "0";
            alu: ALU port map (register_memory(7), shifted_sign_extended, 1, T3, trash(0), trash(0));

        when S7 => 
            signal new_IP : std_logic_vector(15 downto 0);
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
            signal branch_jump : std_logic_vector(15 downto 0);
            branch_condition: if (Z_flag = 1) then
                                 branch_jump <= "000000000" & IR(5 downto 0) & "0";
                              else
                                 branch_jump <= "0000000000000010"; --std_logic_vector(to_unsigned(2, 16));
                              end if branch_condition;
            braching: ALU port map (register_memory(7), branch_jump, 1, T3);
		 
	end case;
	
end process state_trans;
       
end architecture;

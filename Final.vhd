library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity IITBCPU is
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
end entity IITBCPU;

architecture rtl of IITBCPU is

    signal IR : std_logic_vector(15 downto 0) := "0000000000000000";
    signal T1, T2, T3 : std_logic_vector(15 downto 0);
    signal C_flag, Z_flag : std_logic := '0';
	 signal trash : std_logic_vector(1 downto 0);


    type state is (Rest, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10);
    signal FSM_state : state := Rest ;

    component ALU is
        port (
            alu_A : in std_logic_vector(15 downto 0);
            alu_B : in std_logic_vector(15 downto 0);
            instr : in natural range 1 to 8;
            alu_C : out std_logic_vector(15 downto 0);
            C, Z  : out std_logic
        );
    end component ALU;
	 
	 signal alu_a : std_logic_vector(15 downto 0);
	 signal alu_b : std_logic_vector(15 downto 0);
	 signal alu_c : std_logic_vector(15 downto 0);
	 signal instr : natural range 1 to 8;
	 signal C, Z  : std_logic;
	 
	 component REG_FILE is
    port (
        A1 : in std_logic_vector (2 downto 0);
        A2 : in std_logic_vector (2 downto 0);
        A3 : in std_logic_vector (15 downto 0);
        A4 : in std_logic_vector (2 downto 0);

        D1 : out std_logic_vector (15 downto 0);
        D2 : out std_logic_vector (15 downto 0);
        D3 : out std_logic_vector (15 downto 0);
        D4 : in std_logic_vector  (15 downto 0);
		  
		  ra : out std_logic_vector (15 downto 0);
		  rb : out std_logic_vector (15 downto 0);
		  rc : out std_logic_vector (15 downto 0);

        RF_W : in std_logic;
        RF_IP: in std_logic;
		  clk  : in std_logic;
		  rst  : in std_logic
    );
	end component REG_FILE;
	
	signal rA1 : std_logic_vector (2 downto 0);
	signal rA2 : std_logic_vector (2 downto 0);
	signal wA4 : std_logic_vector (2 downto 0);
	signal iA3 : std_logic_vector (15 downto 0);
	signal rD1 : std_logic_vector (15 downto 0);
   signal rD2 : std_logic_vector (15 downto 0);
   signal iD3 : std_logic_vector (15 downto 0);
   signal wD4 : std_logic_vector (15 downto 0);
   signal RF_W : std_logic := '0';
   signal RF_IP: std_logic := '0';
	signal rst  : std_logic;
	
	signal ra : std_logic_vector (15 downto 0);
	signal rb : std_logic_vector (15 downto 0);
   signal rc : std_logic_vector (15 downto 0);
	
	
	component MEMORY is
    port (
        Mem_rAdd : in  std_logic_vector(15 downto 0);
        Mem_rDat : out std_logic_vector(15 downto 0);

        Mem_wAdd : in std_logic_vector(15 downto 0);
        Mem_wDat : in std_logic_vector(15 downto 0);
        Mem_w    : in std_logic;
		  clk      : in std_logic
    );
	end component MEMORY;
	
	signal Mem_rAdd : std_logic_vector(15 downto 0);
   signal Mem_rDat : std_logic_vector(15 downto 0);
   signal Mem_wAdd : std_logic_vector(15 downto 0);
   signal Mem_wDat : std_logic_vector(15 downto 0);
   signal Mem_w    : std_logic := '0';
	 
	signal update_location       : std_logic_vector( 2 downto 0);
	signal decision              : std_logic_vector(15 downto 0);
	signal sign_extended_Imm     : std_logic_vector(15 downto 0);
	signal shifted_sign_extended : std_logic_vector(15 downto 0); 
	signal new_IP                : std_logic_vector(15 downto 0);
	signal branch_jump           : std_logic_vector(15 downto 0);
	signal reg_select            : std_logic_vector(15 downto 0);

begin

ALU_1      : ALU port map(alu_a, alu_b, instr, alu_c, C, Z);
REG_FILE_1 : REG_FILE port map(rA1, rA2, iA3, wA4, rD1, rD2, iD3, wD4, ra, rb, rc, RF_W, RF_IP, clk, rst);
Memory_1   : MEMORY port map(Mem_rAdd, Mem_rDat, Mem_wAdd, Mem_wDat, Mem_w, clk);
deb2       <=    id3;
IR1        <=    IR;
T3_1       <=    T3;
Mem_rDat1  <=    Mem_rDat;
rga1      <=  ra;
rb1 <= rb;
rc1 <= rc;  
 --state_process : process(FSM_state) 
--	begin
--	case FSM_state is 
--		when S1 =>
--				deb <= 1;
--            update_ip : if (IR(15 downto 14) = "11") then
--								alu_a <= iD3;
--								alu_b <= std_logic_vector(to_unsigned(0, 16));
--								instr <= 1;
--								alu_c <= T3;
--								C     <= trash(0);
--								Z     <= trash(1);
--			
--                     else
--								alu_a <= iD3;
--								alu_b <= std_logic_vector(to_unsigned(1, 16));
--								instr <= 1;
--								alu_c <= T3;
--								C     <= trash(0);
--								Z     <= trash(1);
--                        
--                     end if update_ip;
--			   Mem_rAdd <= iD3;
--				IR <= Mem_rDat;
--				Mem_w <= '0';
--				RF_IP <= '0';
--				RF_w  <= '0';
--            
--
--        when S2 => 
--				deb <= 2;
--				rA1 <= IR(8 downto 6);
--            T2  <= rD1;
--            rA2 <= IR(11 downto 9);
--			   T1  <= rD2;
--				RF_IP <= '1';
--				iA3 <= T3;
--				Mem_w <= '0';
--				RF_w  <= '0';
--		  
--		  when S3 =>
--				deb <= 3;
--				update_condition: if (IR(15) = '1') then 
--                                update_location <= IR(11 downto 9);
--                              
--										elsif (IR(15 downto 12) = "0001") then
--                                update_location <= IR(8 downto 6);
--                              
--										elsif (IR(15) = '0') then
--                                update_location <= IR(5 downto 3); 
--										end if update_condition;
--            
--				RF_W <= '1';
--				Mem_w <= '0';
--				RF_IP <= '0';
--				wA4  <= update_location;
--				wD4  <= T3;
--
--        when S4 =>
--				deb <= 4;
--				decision_condition: if (IR(15 downto 12) = "0110") then
--													decision <= T2;
--										  elsif (IR(15 downto 14) = "10") then
--													decision <= "0000000" & IR(8 downto 0);
--									     elsif (IR(15 downto 12) = "0001") then 
--													decision <= "0000000000" & IR(5 downto 0);
--								        end if decision_condition;
--				updation: 
--					if ((IR(15 downto 14) = "11") or (IR(14 downto 12) = "010")) then
--							alu_a <= T1;
--							alu_b <= decision;
--							instr <= 2;
--							alu_c <= T3;
--							C     <= C_flag;
--							Z     <= Z_flag;
--					
--					elsif ((IR(15) = '0') or (IR(14) = '1') or (IR(12) = '1')) then
--							alu_a <= T1;
--							alu_b <= decision;
--							instr <= 1;
--							alu_c <= T3;
--							C     <= C_flag;
--							Z     <= Z_flag;
--					
--					elsif ((IR(15 downto 14) = "10") and (IR(12) = '1')) then
--							alu_a <= T1;
--							alu_b <= decision;
--							instr <= 8;
--							alu_c <= T3;
--							C     <= C_flag;
--							Z     <= Z_flag;
--			   	
--					elsif ((IR(15 downto 14) = "10") and (IR(12) = '0')) then
--							alu_a <= T1;
--							alu_b <= decision;
--							instr <= 7;
--							alu_c <= T3;
--							C     <= C_flag;
--							Z     <= Z_flag;
--					
--					elsif (IR(15 downto 12) = "0011") then
--							alu_a <= T1;
--							alu_b <= decision;
--							instr <= 3;
--							alu_c <= T3;
--							C     <= C_flag;
--							Z     <= Z_flag;
--					
--					elsif (IR(15 downto 12) = "1010") then
--							alu_a <= T1;
--							alu_b <= decision;
--							instr <= 5;
--							alu_c <= T3;
--							C     <= C_flag;
--							Z     <= Z_flag;
--					
--					elsif (IR(15 downto 12) = "0100") then
--							alu_a <= T1;
--							alu_b <= decision;
--							instr <= 4;
--							alu_c <= T3;
--							C     <= C_flag;
--							Z     <= Z_flag;
--					
--					elsif (IR(15 downto 12) = "1001") then
--							alu_a <= T1;
--							alu_b <= decision;
--							instr <= 6;
--							alu_c <= T3;
--							C     <= C_flag;
--							Z     <= Z_flag;
--               
--					end if updation;
--				Mem_w <= '0';
--				RF_IP <= '0';
--				RF_w  <= '0';
--        
--
--        when S5 =>
--				deb <= 5;
--				sign_extended_Imm <= "0000000000" & IR(5 downto 0);
--				alu_a <= sign_extended_Imm;
--				alu_b <= T2;
--				instr <= 1;
--				alu_c <= T3;
--				C     <= trash(0);
--				Z     <= trash(1);
--				Mem_w <= '0';
--				RF_IP <= '0';
--				RF_w  <= '0';
--
--        when S6 => 
--				deb <= 6;
--				shifted_sign_extended <= "000000000" & IR(5 downto 0) & "0";
--				alu_b <= sign_extended_Imm;
--				alu_a <= iD3;
--				instr <= 1;
--				alu_c <= T3;
--				C     <= trash(0);
--				Z     <= trash(1);
--				Mem_w <= '0';
--				RF_IP <= '0';
--				RF_w  <= '0';
--
--        when S7 => 
--				deb <= 7;
--            decision: if (IR(15 downto 13) = "110") then
--                        new_IP <= T3;
--                      elsif (IR(15 downto 12) = "1111") then
--								rA2 <= IR(8 downto 6);
--                        new_IP <= rD2;
--                      end if decision;
--            RF_IP <= '1';
--				Mem_w <= '0';
--				RF_w  <= '0';
--				iA3 <= new_IP;
--
--        when S8 => 
--				deb <= 8;
--            Mem_rAdd <= T3;
--				T3 <= Mem_rDat;
--				Mem_w <= '0';
--				RF_IP <= '0';
--				RF_w  <= '0';
--
--        when S9 =>
--				deb <= 9;
--				Mem_w <= '1';
--				RF_IP <= '0';
--				RF_w  <= '0';
--				Mem_wAdd <= T3;
--            Mem_wDat <= T1;
--
--        when S10 => 
--				deb <= 10;
--            branch_condition: if (Z_flag = '1') then
--                                 branch_jump <= "000000000" & IR(5 downto 0) & "0";
--                              else
--                                 branch_jump <= "0000000000000010"; --std_logic_vector(to_unsigned(2, 16));
--                              end if branch_condition;
--										
--				alu_a <= iD3;
--				alu_b <= branch_jump;
--				instr <= 1;
--				alu_c <= T3;
--				C     <= trash(0);
--				Z     <= trash(1);
--				Mem_w <= '0';
--				RF_IP <= '0';
--				RF_w  <= '0';
--		 
--	end case;	
--end process state_process;
--
--state_trans_process : process(clk)
--    begin 
--	 FSM_State <= next_FSM_State;
--	 if (rising_edge(clk)) then 
--		 case FSM_state is
--			  when S1 =>
--					if (((not IR(15)) or (not IR(14)) or (not IR(12))) = '1') then 
--						 next_FSM_state <= S2;
--					elsif ((IR(15) and IR(14) and IR(12)) = '1') then
--						 next_FSM_state <= S3;
--					end if;
--
--			  when S2 => 
--					if ((not IR(15) or ((not IR(13) and ((not IR(14) or (not IR(12))))))) = '1') then 
--						 next_FSM_state <= S4;
--					elsif (IR(15 downto 13) = "101") then 
--						 next_FSM_state <= S5; 
--					end if;
--
--			  when S3 => 
--					if (IR(15 downto 12) = "1101") then 
--						 next_FSM_state <= S6;
--					elsif (IR(15 downto 12) = "1111") then 
--						 next_FSM_state <= S7;
--					elsif (((not IR(15)) or (IR(13) and (not IR(12))) or ((not IR(14)) and (not IR(13)))) = '1') then 
--						 next_FSM_state <= S1;
--					end if;
--
--			  when S4 => 
--					if (IR(15 downto 12) = "1100") then
--						 next_FSM_state <= S10; 
--					elsif (((not IR(14)) or ((not IR(13))and (not IR(12)))) = '1') then 
--						 next_FSM_state <= S3; 
--					end if;
--
--			  when S5 =>
--					if (IR(15 downto 12) = "1010") then 
--						 next_FSM_state <= S8;
--					elsif (IR(15 downto 12) = "1011") then 
--						 next_FSM_state <= S9;
--					end if;
--
--			  when S6 =>
--					next_FSM_state <= S7;
--
--			  when S7 => 
--					next_FSM_state <= S1; 
--
--			  when S8 =>
--					next_FSM_state <= S3; 
--
--			  when S9 => 
--					next_FSM_state <= S1; 
--
--			  when S10 =>
--					next_FSM_state <= S7;
--						 
--		 end case;
--	end if;
--end process state_trans_process;

state_process : process(FSM_state, clk, reset) 
variable next_FSM_state : state;
	begin
	next_FSM_state := FSM_state;
	case FSM_state is 
		when Rest =>
				Mem_w <= '0';
				RF_IP <= '1';
				RF_w  <= '0';
				iA3   <= "0000000000000000";
				IR    <= "0000000000000000";
				rst   <= '1';
				
				if (reset = '0') then
				next_FSM_state := S1;
				else
				next_FSM_state := Rest;
				end if;
		
		when S1 =>
				Mem_rAdd <= iD3;
				IR <= Mem_rDat;
				Mem_w <= '0';
				RF_IP <= '0';
				RF_w  <= '0';
				rst   <= '0';
				deb <= 1;
            update_ip : if (IR(15 downto 14) = "11") then
								alu_a <= iD3;
								alu_b <= std_logic_vector(to_unsigned(0, 16));
								instr <= 1;
								T3 <= alu_c;
								C     <= trash(0);
								Z     <= trash(1);
			
                     else
								alu_a <= iD3;
								alu_b <= std_logic_vector(to_unsigned(1, 16));
								instr <= 1;
								T3 <= alu_c;
								C     <= trash(0);
								Z     <= trash(1);
                        
                     end if update_ip;
			   
            
				if (((not IR(15)) or (not IR(14)) or (not IR(12))) = '1' and reset = '0') then 
						 next_FSM_state := S2;
				elsif (((IR(15) and IR(14) and IR(12)) = '1') and reset = '0') then
						 next_FSM_state := S3;
				elsif (reset = '1') then
						 next_FSM_state := Rest;
				end if;

        when S2 => 
				deb <= 2;
				rst   <= '0';
				rA1 <= IR(8 downto 6);
            T2  <= rD1;
            rA2 <= IR(11 downto 9);
			   T1  <= rD2;
				RF_IP <= '1';
				iA3 <= T3;
				Mem_w <= '0';
				RF_w  <= '0';
				
				if (((not IR(15) or ((not IR(13) and ((not IR(14) or (not IR(12))))))) = '1') and reset = '0') then 
						 next_FSM_state := S4;
				elsif ((IR(15 downto 13) = "101") and reset = '0') then 
						 next_FSM_state := S5;
				elsif (reset ='1') then
						next_FSM_state  := Rest;
				end if;
		  
		  when S3 =>
				deb <= 3;
				rst   <= '0';
				update_condition: if (IR(15) = '1') then 
                                update_location <= IR(11 downto 9);
                              
										elsif (IR(15 downto 12) = "0001") then
                                update_location <= IR(8 downto 6);
                              
										elsif (IR(15) = '0') then
                                update_location <= IR(5 downto 3); 
										end if update_condition;
            
				if (IR(15 downto 12) = "1010") then
					reg_select <= T1;
				else
					reg_select <= T3;
				end if;
				
				RF_W  <= '1';
				Mem_w <= '0';
				RF_IP <= '0';
				wA4   <= update_location;
				wD4   <= reg_select;
				
				if ((IR(15 downto 12) = "1101") and reset = '0') then 
						 next_FSM_state := S6;
					elsif ((IR(15 downto 12) = "1111")  and reset = '0') then 
						 next_FSM_state := S7;
					elsif ((((not IR(15)) or (IR(13) and (not IR(12))) or ((not IR(14)) and (not IR(13)))) = '1') and reset = '0') then 
						 next_FSM_state := S1;
					elsif(reset = '1') then
						 next_FSM_state := Rest;
					end if;

       
       when S4 =>
				deb <= 4;
				rst   <= '0';
				decision_condition: if ((((not IR(15)) and (IR(14) or IR(13) or (not IR(12)))) or (IR(14) and (not IR(12)))) = '1') then
													decision <= T2;
										  elsif (IR(15 downto 14) = "10") then
													decision <= "0000000" & IR(8 downto 0);
									     elsif (IR(15 downto 12) = "0001") then 
													decision <= "0000000000" & IR(5 downto 0);
								        end if decision_condition;
				updation: 
					if ((IR(15 downto 12) = "0010") or (IR(15 downto 12) = "1100")) then
							alu_a <= T1;
							alu_b <= decision;
							instr <= 2;
							T3 <= alu_c;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif ((IR(15 downto 12) = "0000") or (IR(15 downto 12) = "0001")) then
							alu_a <= T1;
							alu_b <= decision;
							instr <= 1;
							T3 <= alu_c;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "1001") then
							alu_a <= T1;
							alu_b <= decision;
							instr <= 8;
							T3 <= alu_c;
							C     <= C_flag;
							Z     <= Z_flag;
			   	
					elsif (IR(15 downto 12) = "1000") then
							alu_a <= T1;
							alu_b <= decision;
							instr <= 7;
							T3 <= alu_c;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "0011") then
							alu_a <= T1;
							alu_b <= decision;
							instr <= 3;
							T3 <= alu_c;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "0101") then
							alu_a <= T1;
							alu_b <= decision;
							instr <= 5;
							T3 <= alu_c;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "0100") then
							alu_a <= T1;
							alu_b <= decision;
							instr <= 4;
							T3    <= alu_c;
							C     <= C_flag;
							Z     <= Z_flag;
					
					elsif (IR(15 downto 12) = "0110") then
							alu_a <= T1;
							alu_b <= decision;
							instr <= 6;
							T3    <= alu_c;
							C     <= C_flag;
							Z     <= Z_flag;
              
					end if updation;
				Mem_w <= '0';
				RF_IP <= '0';
				RF_w  <= '0';
				
				if ((IR(15 downto 12) = "1100")  and reset = '0') then
						 next_FSM_state := S10; 
				elsif ((((not IR(15)) or ((not IR(14))and (not IR(13)))) = '1') and reset = '0') then 
						 next_FSM_state := S3; 
				elsif(reset = '1') then
						 next_FSM_state := Rest;
				end if;
        when S5 =>
				deb <= 5;
				rst   <= '0';
				sign_extended_Imm <= "0000000000" & IR(5 downto 0);
				alu_a <= sign_extended_Imm;
				alu_b <= T2;
				instr <= 1;
				T3 <= alu_c;
				C     <= trash(0);
				Z     <= trash(1);
				Mem_w <= '0';
				RF_IP <= '0';
				RF_w  <= '0';
				
				if ((IR(15 downto 12) = "1010") and reset = '0') then 
						 next_FSM_state := S8;
				elsif ((IR(15 downto 12) = "1011") and reset = '0') then 
						 next_FSM_state := S9;
				elsif(reset = '1') then
						 next_FSM_state := Rest;
				end if;

        when S6 => 
				deb <= 6;
				rst   <= '0';
				shifted_sign_extended <= "000000000" & IR(5 downto 0) & "0";
				alu_b <= sign_extended_Imm;
				alu_a <= iD3;
				instr <= 1;
				T3 <= alu_c;
				C     <= trash(0);
				Z     <= trash(1);
				Mem_w <= '0';
				RF_IP <= '0';
				RF_w  <= '0';
				
				if (reset = '0') then
					next_FSM_state := S7;
				elsif(reset = '1') then
						 next_FSM_state := Rest;
				end if;


        when S7 => 
				deb <= 7;
				rst   <= '0';
            decision: if (IR(15 downto 13) = "110") then
                        new_IP <= T3;
                      elsif (IR(15 downto 12) = "1111") then
								rA2 <= IR(8 downto 6);
                        new_IP <= rD2;
                      end if decision;
            RF_IP <= '1';
				Mem_w <= '0';
				RF_w  <= '0';
				iA3 <= new_IP;
				
				if (reset = '0') then
					next_FSM_state := S1;
				elsif(reset = '1') then
						 next_FSM_state := Rest;
				end if;

        when S8 => 
				deb <= 8;
				rst   <= '0';
            Mem_rAdd <= T3;
				T1 <= Mem_rDat;
				Mem_w <= '0';
				RF_IP <= '0';
				RF_w  <= '0';
				
				if (reset = '0') then
					next_FSM_state := S3;
			   elsif(reset = '1') then
					next_FSM_state := Rest;
				end if;	

        when S9 =>
				deb <= 9;
				rst   <= '0';
				Mem_w <= '1';
				RF_IP <= '0';
				RF_w  <= '0';
				Mem_wAdd <= T3;
            Mem_wDat <= T1;
				
				if (reset = '0') then
					next_FSM_state := S1;
				elsif(reset = '1') then
					next_FSM_state := Rest;
				end if;	

        when S10 => 
				deb <= 10;
				rst   <= '0';
            branch_condition: if (Z_flag = '1') then
                                 branch_jump <= "000000000" & IR(5 downto 0) & "0";
                              else
                                 branch_jump <= "0000000000000010"; --std_logic_vector(to_unsigned(2, 16));
                              end if branch_condition;
										
				alu_a <= iD3;
				alu_b <= branch_jump;
				instr <= 1;
				T3 <= alu_c;
				C     <= trash(0);
				Z     <= trash(1);
				Mem_w <= '0';
				RF_IP <= '0';
				RF_w  <= '0';
				
				if (reset = '0') then
					next_FSM_state := S7;
				elsif(reset = '1') then
						 next_FSM_state := Rest;
				end if;
		 
	end case;	
	
	if (rising_edge(clk)) then 
	FSM_State <= next_FSM_State;
	end if;
end process state_process;
     
end architecture;

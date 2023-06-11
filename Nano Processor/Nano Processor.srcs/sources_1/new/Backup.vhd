----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2023 11:54:45 AM
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Instruction_Decoder is
    Port ( InstructionBus : in STD_LOGIC_VECTOR (11 downto 0);
           RegisterEnable : out STD_LOGIC_VECTOR (2 downto 0);
           LoadSelect : out STD_LOGIC ;
           ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0);
           RegisterSelectA : out STD_LOGIC_VECTOR (2 downto 0);
           RegisterSelectB : out STD_LOGIC_VECTOR (2 downto 0);
           Add_Sub_Select : out STD_LOGIC;
           RegForJump : in STD_LOGIC_VECTOR (3 downto 0);
           JumpFlag : out STD_LOGIC;
           JumpAddress : out STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC_VECTOR
           );
end Instruction_Decoder;

architecture Behavioral of Backup is

signal Operation : STD_LOGIC_VECTOR (1 downto 0);
signal Reg_A,Reg_B : STD_LOGIC_VECTOR (2 downto 0);
signal Input_Data : STD_LOGIC_VECTOR (3 downto 0);
signal Input_Line_Number : STD_LOGIC_VECTOR ( 2 downto 0);
signal Type_of_Jump , Add_Compare : STD_LOGIC;


begin
    process(Operation,Reg_A,Reg_B, RegForJump ,Input_Data,Input_Line_Number,Type_of_Jump,Add_Compare)
    begin 
    JumpFlag<='0';
    RegisterEnable <= "000";
    
   
    if Operation = "10" then --MOVE
        ImmediateValue <= Input_Data;
        RegisterEnable <= Reg_A;
        LoadSelect <= '1';
    
    
    elsif Operation = "00" then --ADD
    
        if Add_Compare = '0' then
                Add_Sub_Select <= '0';
                RegisterSelectA <= Reg_A;
                RegisterSelectB <= Reg_B;
                RegisterEnable <= Reg_A;
                LoadSelect <= '0';
                
        else
               RegisterSelectA <= Reg_A;
               RegisterSelectB <= Reg_B;
        end if;
        
        
                          
                
       
                
    elsif Operation = "01" then --NEG
                RegisterSelectA <= "000";
                RegisterSelectB <= Reg_A;
                
                RegisterEnable <= Reg_A;
                Add_Sub_Select <= '1';
                LoadSelect <= '0';
        
    
    
    elsif Operation = "11" then --JUMP
               RegisterSelectA <= Reg_A;
               if Type_of_Jump = '0' then -- IF R= 0 then jump
                   if (RegForJump = "0000") then 
                        JumpFlag <= '1';
                        JumpAddress <=  Input_Line_Number;        
                   end if;
              else -- IF R /= 0 then jump
                    if (RegForJump /= "0000") then
                        JumpFlag <= '1';
                        JumpAddress <=  Input_Line_Number;
                    end if;
              end if;    
        end if;
        
    
        
        

    end process;
    
    Operation <= InstructionBus(11 downto 10);
    Reg_A <= InstructionBus(9 downto 7);
    Reg_B <= InstructionBus(6 downto 4);
    Input_Data <= InstructionBus(3 downto 0);
    Input_Line_Number <= InstructionBus(2 downto 0);
    Type_of_Jump <= InstructionBus(6);
    Add_Compare <= InstructionBus(0);
    

end Behavioral;
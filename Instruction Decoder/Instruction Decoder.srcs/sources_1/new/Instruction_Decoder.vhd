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
           LoadSelect : out STD_LOGIC;
           ImmediateValue : out STD_LOGIC_VECTOR (3 downto 0);
           RegisterSelectA : out STD_LOGIC_VECTOR (2 downto 0);
           RegisterSelectB : out STD_LOGIC_VECTOR (2 downto 0);
           Add_Sub_Select : out STD_LOGIC;
           RegForJump : in STD_LOGIC_VECTOR (3 downto 0);
           JumpFlag : out STD_LOGIC;
           JumpAddress : out STD_LOGIC_VECTOR (2 downto 0));
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

begin

process (InstructionBus)
begin

-- Set the jump flag to 0 and jump address to undefined by default
 JumpFlag <= '0';
 JumpAddress <= "UUU";

-- MOVI Instruction
if (InstructionBus(11 downto 10) = "10") then

    -- Sample Instruction : 1 0 R R R 0 0 0 d d d d

    RegisterEnable <= InstructionBus (9 downto 7);
    LoadSelect <= '0';
    ImmediateValue <= InstructionBus( 3 downto 0);
    
    -- Unused values set to undefined
    RegisterSelectA <= "UUU";
    RegisterSelectB <= "UUU";
    Add_Sub_Select <= 'U';


-- Add Instruction
elsif (InstructionBus(11 downto 10) = "00") then
    
    -- Sample Instruction : 0 0 Ra Ra Ra Rb Rb Rb 0 0 0 0

    -- Register A will store the output
    RegisterEnable <= InstructionBus (9 downto 7);
    
    -- Set Load select to 1 to allow Register to store output of 4 bit adder
    LoadSelect <= '1';
    
    -- Set the Immediate Value to undefined
    ImmediateValue <= "UUUU";
    
    -- Register for MUX A is represented by the bits 9 downto 7
    RegisterSelectA <= InstructionBus (9 downto 7);
    
    -- Register for MUX B is represented by the bits 6 downto 4
    RegisterSelectB <= InstructionBus (6 downto 4);
    
    -- Set the Add_Sub_Select to allow for addition
    -- Here 0 - Addtion, 1 - Subtraction
    Add_Sub_Select <= '0';
    
    
-- Negate Instruction
elsif (InstructionBus(11 downto 10) = "01") then
    
    -- Sample Instruction : 0 1 R R R 0 0 0 0 0 0 0

    -- Register RRR will store the output
    RegisterEnable <= InstructionBus (9 downto 7);
    
    -- Set Load select to 1 to allow Register to store output of 4 bit adder
    LoadSelect <= '1';
    
    -- Set immediate value to undefined since it is not needed
    ImmediateValue <= "UUUU";
    
    -- Register R0 is hardcoded to 0000
    RegisterSelectA <= "000";
    
    -- Register
    RegisterSelectB <= InstructionBus (9 downto 7);
    
    -- Set the Add_Sub_Select to allow for subtraction
    -- Here 0 - Addtion, 1 - Subtraction
    Add_Sub_Select <= '1';
        
        
-- Jump Instruction
elsif (InstructionBus(11 downto 10) = "11") then
    
    -- Sample Instruction : 1 1 R R R 0 0 0 0 d d d
    
    -- To check if the value in register RRR is zero,
    -- we will load it to 8 way mux A
    -- This will also provide it as an input to the instruction decoder
    
    -- Set the Register Enable to Undefined since it will not be needed
    RegisterEnable <= "UUU";
    
    -- Set the LoadSelect also to undefined since it is also not used
    LoadSelect <= 'U';
    
    -- Set immediate value to undefined since it is not needed
    ImmediateValue <= "UUUU";
    
    -- Register R0 is hardcoded to 0000
    RegisterSelectA <= "000";
    
    -- We don't need a register loaded in the 8 way mux B
    RegisterSelectB <= "UUU";
    
    -- Set the Add_Sub_Select to undefined since we don't need it to perform a calculation
    Add_Sub_Select <= 'U';
    
    -- Check if the RegForJump is 0000
    if (RegForJump = "0000") then
        JumpFlag <= '1';
        -- Jump Address is represented by 3 bits from (2 downto 0)
        JumpAddress <= InstructionBus(2 downto 0);
        
    -- In the case that RegForJump is not 0000, JumpFlag must be set to 0 and JumpAddress to undefined
    -- This is done by default at the start of the process, so no need to redo it
    
    end if;
    

end if;

end process;

end Behavioral;
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
           JumpCheck : in STD_LOGIC;
           JumpFlag : out STD_LOGIC;
           JumpAddress : out STD_LOGIC_VECTOR (2 downto 0)
           );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

component Decoder_2_to_4
    Port ( I : in STD_LOGIC_VECTOR (1 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Instruction : STD_LOGIC_VECTOR (3 downto 0);

signal MOVI : STD_LOGIC;
signal ADD : STD_LOGIC;
signal NEG : STD_LOGIC;
signal JZR : STD_LOGIC;

begin

Decoder_2_to_4_0 : Decoder_2_to_4
    port map(
        I => InstructionBus(11 downto 10),
        EN => '1',
        Y => Instruction
    );
    
    
MOVI <= Instruction(2);
ADD <= Instruction(0);
NEG <= Instruction(1);
JZR <= Instruction(3);

LoadSelect <= ADD OR NEG;

RegisterEnable <= InstructionBus(9 downto 7);

RegisterSelectA <= InstructionBus(9 downto 7);
RegisterSelectB <= InstructionBus(6 downto 4);

ImmediateValue <= InstructionBus(3 downto 0);

Add_Sub_Select <= InstructionBus(10);

JumpFlag <= JZR AND JumpCheck;
JumpAddress <= InstructionBus(2 downto 0);


end Behavioral;
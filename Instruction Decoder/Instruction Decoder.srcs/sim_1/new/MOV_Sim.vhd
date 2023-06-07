----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2023 12:00:26 PM
-- Design Name: 
-- Module Name: MOV_Sim - Behavioral
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

entity MOV_Sim is
--  Port ( );
end MOV_Sim;

architecture Behavioral of MOV_Sim is

component Instruction_Decoder

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

end component;

signal InstructionBus : STD_LOGIC_VECTOR (11 downto 0) := "101000001010";
signal RegisterEnable : STD_LOGIC_VECTOR (2 downto 0);
signal LoadSelect : STD_LOGIC;
signal ImmediateValue : STD_LOGIC_VECTOR (3 downto 0);
signal RegisterSelectA : STD_LOGIC_VECTOR (2 downto 0);
signal RegisterSelectB : STD_LOGIC_VECTOR (2 downto 0);
signal Add_Sub_Select : STD_LOGIC := '0';
signal RegForJump : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal JumpFlag : STD_LOGIC := '0';
signal JumpAddress : STD_LOGIC_VECTOR (2 downto 0);

begin

UUT : Instruction_Decoder PORT MAP (
    InstructionBus => InstructionBus,
    RegisterEnable => RegisterEnable,
    LoadSelect => LoadSelect,
    ImmediateValue => ImmediateValue,
    RegisterSelectA => RegisterSelectA,
    RegisterSelectB => RegisterSelectB,
    Add_Sub_Select => Add_Sub_Select,
    RegForJump => RegForJump,
    JumpFlag => JumpFlag,
    JumpAddress => JumpAddress
);


process
begin

-- Load 010 to R1
InstructionBus <= "100010000010";
wait for 100ns;

-- Load 010 to R2
InstructionBus <= "100100000010";
wait for 100ns;

-- Add R1 and R2 and save to R1
InstructionBus <= "000010100000";
wait for 100ns;

-- Testing the Jump Instruction
InstructionBus <= "110000000001";
wait;



end process;


end Behavioral;

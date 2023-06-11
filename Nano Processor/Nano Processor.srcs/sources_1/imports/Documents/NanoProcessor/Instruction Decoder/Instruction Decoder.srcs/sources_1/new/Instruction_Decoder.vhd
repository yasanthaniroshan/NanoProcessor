
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


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
    
  
-- OUTPUT OF THE DECODER IS MAPPED TO EACH INSTRUCTION SIGNAL
-- EACH SIGNAL IS 1 IF THE INSTRUCTION IS ACTIVE
-- E.G. WHEN MOVI INSTRUCION IS ACTIVE, MOVI='1', ADD='0', NEG='0', JZR='0'
MOVI <= Instruction(2);
ADD <= Instruction(0);
NEG <= Instruction(1);
JZR <= Instruction(3);


-- LOAD SELECT SHOULD BE ONE ONLY FOR ADD AND NEG INSTRUCTIONS
LoadSelect <= ADD OR NEG;

-- SET THE REGISTER ENABLE TO GET THE 9,8,7, BITS OF THE INSTRUCTION WHEN NOT THE JZR INSTRUCTION
-- WHEN JZR INSTRUCTION IS ENABLED SET THE REGISTER ENABLE TO R0 TO ENSURE UNNECESSARY WRITE OPERATIONS
-- DONT HAPPEN
RegisterEnable <= InstructionBus(9 downto 7) when (JZR = '0') else "000";


-- SET THE REGISTER FOR FIRST MUX (A) TO THE 9,8,7, BITS AND SECOND MUX (B) TO THE 6,5,4 BITS 
-- OF THE INSTRUCTION WHEN NOT THE NEG INSTRUCTION
-- IN THE CASE OF THE NEG INSTRUCTION, LOAD R0 WHICH IS HARDCODED TO 000 TO TH FIRST MUX (a)
-- AND SET THE REGISTER FOR SECOND MUX (B) TO THE 9,8,7 BITS OF THE INSTRUCTION
RegisterSelectA <= InstructionBus(9 downto 7) when (NEG = '0') else "000";
RegisterSelectB <= InstructionBus(6 downto 4) when (NEG = '0') else InstructionBus(9 downto 7);


-- SET THE IMMEDIATE VALUE TO THE 3,2,1,0 BUS OF THE INSTRUCTION WHEN THE MOVE INSTRUCTION IS EXECUTED
ImmediateValue <= InstructionBus(3 downto 0) when (MOVI = '1') else "0000";

-- SET THE ADD SUBTRACT SELECT TO THE 10TH BIT OF THE INSTRUCTION
-- THIS WILL ENSURE 0 - ADDITION AND 1 - SUBTRACTION
Add_Sub_Select <= InstructionBus(10);

-- SET THE JUMP FLAG WHEN JUMPCHECK AND JZR ARE BOTH ACTIVE
JumpFlag <= JZR AND JumpCheck;

-- SET THE JUMP ADDRESS TO THE LAST THREE BITS OF THE INSTRUCTION DECODER
JumpAddress <= InstructionBus(2 downto 0);


end Behavioral;
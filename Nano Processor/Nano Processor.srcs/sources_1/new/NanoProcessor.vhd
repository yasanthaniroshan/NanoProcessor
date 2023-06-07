----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2023 10:20:58 PM
-- Design Name: 
-- Module Name: NanoProcessor - Behavioral
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

entity NanoProcessor is
    Port (
        InstructionBusTemp : in STD_LOGIC_VECTOR (11 downto 0);
        JumpFlagTemp : out STD_LOGIC;
        JumpAddressTemp : out STD_LOGIC_VECTOR (2 downto 0)
    );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

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


component mux_8_way_4_bit
    Port ( RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           Reg_0 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_1 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_2 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_3 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_4 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_5 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_6 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_7 : in STD_LOGIC_VECTOR (3 downto 0);
           Mux_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component mux_2_way_4_bit
    Port ( IN_0 : in STD_LOGIC_VECTOR (3 downto 0);
           IN_1 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           Mux_out : out STD_LOGIC_VECTOR (3 downto 0));
end component;



component RegBank
    Port ( RegSel : in STD_LOGIC_VECTOR (2 downto 0);
       Clk : in STD_LOGIC;
       En : in STD_LOGIC;
       Data_IN : in STD_LOGIC_VECTOR(3 downto 0);
       Data_Bus_0 : out STD_LOGIC_VECTOR (3 downto 0);
       Data_Bus_1 : out STD_LOGIC_VECTOR (3 downto 0);
       Data_Bus_2 : out STD_LOGIC_VECTOR (3 downto 0);
       Data_Bus_3 : out STD_LOGIC_VECTOR (3 downto 0);
       Data_Bus_4 : out STD_LOGIC_VECTOR (3 downto 0);
       Data_Bus_5 : out STD_LOGIC_VECTOR (3 downto 0);
       Data_Bus_6 : out STD_LOGIC_VECTOR (3 downto 0);
       Data_Bus_7 : out STD_LOGIC_VECTOR (3 downto 0));
end component;


component Add_Sub
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           M : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           C_out : out STD_LOGIC;
           Zero_Flag : out STD_LOGIC
           );
end component;


signal InstructionBus : STD_LOGIC_VECTOR (11 downto 0);
signal RegisterEnable : STD_LOGIC_VECTOR (2 downto 0);
signal LoadSelect : STD_LOGIC;
signal ImmediateValue  : STD_LOGIC_VECTOR (3 downto 0);
signal RegisterSelectA, RegisterSelectB : STD_LOGIC_VECTOR (2 downto 0);
signal AddSubSelect : STD_LOGIC;
signal DataBus0, DataBus1, DataBus2, DataBus3, DataBus4, DataBus5, DataBus6, DataBus7 : STD_LOGIC_VECTOR (3 downto 0);
signal JumpFlag : STD_LOGIC;
signal JumpAddress : STD_LOGIC_VECTOR (2 downto 0);


       
       
signal RegSel : STD_LOGIC_VECTOR ( 2 downto 0);
signal Clk : STD_LOGIC;
signal RegBankEnable : STD_LOGIC;
signal RegInput : STD_LOGIC_VECTOR (3 downto 0);

signal MuxAOut, MuxBOut : STD_LOGIC_VECTOR (3 downto 0);

signal AddSubOut : STD_LOGIC_VECTOR (3 downto 0);


signal OverflowFlag, ZeroFlag : STD_LOGIC;



begin

Instruction_Decoder_0 : Instruction_Decoder
    port map (
       InstructionBus => InstructionBus,
       RegisterEnable => RegisterEnable,
       LoadSelect => LoadSelect,
       ImmediateValue => ImmediateValue,
       RegisterSelectA => RegisterSelectA,
       RegisterSelectB => RegisterSelectB,
       Add_Sub_Select => AddSubSelect,
       RegForJump => MuxAOut,
       JumpFlag => JumpFlag
    );
    

Register_Bank : RegBank
    port map (
        RegSel => RegSel,
        Clk => Clk,
        En => RegBankEnable,
        Data_IN => RegInput,
        Data_Bus_0 => DataBus0,
        Data_Bus_1 => DataBus1,
        Data_Bus_2 => DataBus2,
        Data_Bus_3 => DataBus3,
        Data_Bus_4 => DataBus4,
        Data_Bus_5 => DataBus5,
        Data_Bus_6 => DataBus6,
        Data_Bus_7 => DataBus7
    );
    
    
Add_Sub_Component : Add_Sub
    port map (
        A => MuxAOut, 
        B => MuxBOut, 
        M => AddSubSelect,
        S => AddSubOut,
        C_out => OverflowFlag,
        Zero_Flag => ZeroFlag
    );

Mux_8_Way_A : mux_8_way_4_bit
    port map (
      RegSel => RegSel,
      Reg_0 => DataBus0,
      Reg_1 => DataBus1,
      Reg_2 => DataBus2,
      Reg_3 => DataBus3,
      Reg_4 => DataBus4,
      Reg_5 => DataBus5,
      Reg_6 => DataBus6,
      Reg_7 => DataBus7,
      Mux_out => MuxAOut
    );
    
    
Mux_8_Way_B : mux_8_way_4_bit
        port map (
          RegSel => RegSel,
          Reg_0 => DataBus0,
          Reg_1 => DataBus1,
          Reg_2 => DataBus2,
          Reg_3 => DataBus3,
          Reg_4 => DataBus4,
          Reg_5 => DataBus5,
          Reg_6 => DataBus6,
          Reg_7 => DataBus7,
          Mux_out => MuxBOut
        );
               
Load_Select_Mux : mux_2_way_4_bit

port map (
    IN_0 => ImmediateValue,
    IN_1 => AddSubOut,
    Sel => LoadSelect,
    Mux_out => RegInput
);

JumpFlagTemp <= JumpFlag;
JumpAddressTemp <= JumpAddress;


end Behavioral;

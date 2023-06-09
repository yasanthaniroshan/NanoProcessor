

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity NanoProcessor is
    Port (
        Clk_In : in STD_LOGIC;
        Reset : in STD_LOGIC;
        OverflowFlag : out STD_LOGIC;
        ZeroFlag : out STD_LOGIC;
        seg: out STD_LOGIC_VECTOR (6 downto 0);
        led : out STD_LOGIC_VECTOR (11 downto 0)
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
       Reset : in STD_LOGIC;
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

component ProgramROM
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           O : out STD_LOGIC_VECTOR (11 downto 0));    
end component;

component mux_2_way_3_bit
    Port ( IN_0 : in STD_LOGIC_VECTOR (2 downto 0);
           IN_1 : in STD_LOGIC_VECTOR (2 downto 0);
           Sel : in STD_LOGIC;
           Mux_out : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Adder_3_bit 

    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           B : in STD_LOGIC_VECTOR (2 downto 0);
           C_in : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (2 downto 0);
           C_out : out STD_LOGIC);

end component;


component ProgramCounter

    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           NextAddress : in STD_LOGIC_VECTOR (2 downto 0);
           MemorySelect : out STD_LOGIC_VECTOR (2 downto 0));

end component;

component Slow_Clk
    Port ( Slow_Clk_in : in STD_LOGIC;
           Slow_Clk_out : out STD_LOGIC);
end component;

-- Get the values for the 7 segment display
component LUT_16_7
    Port ( I : in STD_LOGIC_VECTOR (3 downto 0);
       O : out STD_LOGIC_VECTOR (6 downto 0));
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
signal Slow_Clk_in : STD_LOGIC;
signal RegBankEnable : STD_LOGIC := '1';
signal RegInput : STD_LOGIC_VECTOR (3 downto 0);

signal MuxAOut, MuxBOut : STD_LOGIC_VECTOR (3 downto 0);

signal AddSubOut : STD_LOGIC_VECTOR (3 downto 0);


signal MemorySelect : STD_LOGIC_VECTOR (2 downto 0);
signal Adder3BitOutput : STD_LOGIC_VECTOR (2 downto 0);
signal NewInstructionAddress : STD_LOGIC_VECTOR (2 downto 0);



-- Delete this, only for testing
signal testSignal : STD_LOGIC := '1';



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
       JumpFlag => JumpFlag,
       JumpAddress => JumpAddress
    );
    

Register_Bank : RegBank
    port map (
        RegSel => RegisterEnable,
        Clk => Clk,
        En => RegBankEnable,
        Reset => Reset,
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
      RegSel => RegisterSelectA,
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
          RegSel => RegisterSelectB,
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

ProgramROM_0 : ProgramROM
port map (
    I => MemorySelect,
    O => InstructionBus
);

Mux_2_way_3_bit_0 : mux_2_way_3_bit
port map (
    IN_0 => Adder3BitOutput,
    IN_1 => JumpAddress,
    Sel => JumpFlag,
    Mux_out => NewInstructionAddress
);

Adder_3_bit_0 : Adder_3_bit 
port map (
    A => MemorySelect,
    B => "001",
    C_in => '0',
    S => Adder3BitOutput
);

Program_Counter : ProgramCounter
port map (
    Clk => Clk,
    Reset => Reset,
    NextAddress => NewInstructionAddress,
    MemorySelect => MemorySelect
);

Slow_Clock : Slow_Clk
    Port map ( Slow_Clk_In => Clk_In,
           Slow_Clk_Out => Clk
           );
           
           
SevenSegLUT : LUT_16_7 
 port map(
    I => AddSubOut,
    O => seg
 );
 
 led(11 downto 8) <= DataBus1;
 led(7 downto 4) <= DataBus2;
 led(3 downto 0) <= RegInput;
           

end Behavioral;

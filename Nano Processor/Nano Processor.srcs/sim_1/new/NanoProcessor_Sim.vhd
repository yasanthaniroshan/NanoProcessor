library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NanoProcessor_Sim is
    --port();
end NanoProcessor_Sim;

architecture sim of NanoProcessor_Sim is

  component NanoProcessor is
    Port (
      InstructionBusTemp : in STD_LOGIC_VECTOR (11 downto 0);
      JumpFlagTemp : out STD_LOGIC;
      JumpAddressTemp : out STD_LOGIC_VECTOR ( 2 downto 0)
     );
  end component;

  signal InstructionBus : STD_LOGIC_VECTOR (11 downto 0);
  signal RegisterEnable : STD_LOGIC_VECTOR (2 downto 0);
  signal LoadSelect : STD_LOGIC;
  signal ImmediateValue : STD_LOGIC_VECTOR (3 downto 0);
  signal RegisterSelectA, RegisterSelectB : STD_LOGIC_VECTOR (2 downto 0);
  signal AddSubSelect : STD_LOGIC;
  signal RegForJump : STD_LOGIC_VECTOR (3 downto 0);
  signal JumpFlag : STD_LOGIC;
  signal JumpAddress : STD_LOGIC_VECTOR (2 downto 0);
  signal RegSel : STD_LOGIC_VECTOR (2 downto 0);
  signal Clk : STD_LOGIC;
  signal RegBankEnable : STD_LOGIC;
  signal RegInput : STD_LOGIC_VECTOR (3 downto 0);
  signal OverflowFlag, ZeroFlag : STD_LOGIC;
  
begin

  UUT : NanoProcessor
    port map (
      InstructionBusTemp => InstructionBus
    );

  -- Clock generation process
  process
  begin
    Clk <= '0';
    wait for 10 ns;
    Clk <= '1';
    wait for 10 ns;
  end process;

  -- Stimulus process
  process
  begin
  
    -- Load an instruction
    InstructionBus <= "100010000101"; -- 1 0 R R R 0 0 0 d d d d
    wait for 20 ns;
    InstructionBus <= "100100000001";
    wait for 20 ns;
    InstructionBus <= "000010100000";
    wait for 20 ns;
    
    

  end process;

end sim;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NanoProcessorSim is
    --port();
end NanoProcessorSim;

architecture sim of NanoProcessorSim is

  component NanoProcessor is
    Port (
      InstructionBusTemp : in STD_LOGIC_VECTOR (11 downto 0);
      Clk_In : in STD_LOGIC;
      JumpFlagTemp : out STD_LOGIC;
      JumpAddressTemp : out STD_LOGIC_VECTOR ( 2 downto 0);
      AddSubOutTemp : out STD_LOGIC_VECTOR (3 downto 0)
     );
  end component;

  signal InstructionBus : STD_LOGIC_VECTOR (11 downto 0);
  signal Clk, JumpFlag : STD_LOGIC;
  signal JumpAddress : STD_LOGIC_VECTOR (2 downto 0);
  signal AddSubOut : STD_LOGIC_VECTOR (3 downto 0);

  
begin

  UUT : NanoProcessor
    port map (
      InstructionBusTemp => InstructionBus,
      Clk_In => Clk,
      JumpFlagTemp => JumpFlag,
      JumpAddressTemp => JumpAddress,
      AddSubOutTemp => AddSubOut
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
    
    -- Loading 0000 into Register R1
    InstructionBus <= "100010000000"; -- 1 0 R R R 0 0 0 d d d d
    wait for 100 ns;
    InstructionBus <= "100100000001";
    wait for 100 ns;
    InstructionBus <= "000100100000";
    wait for 100 ns;
    
    -- Testing the Jump Instruction
    InstructionBus <= "110010000001"; -- 1 1 R R R 0 0 0 0 d d d
    wait for 100 ns;
    
    

  end process;

end sim;

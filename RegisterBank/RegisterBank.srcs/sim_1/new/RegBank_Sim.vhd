library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegBank_tb is
end RegBank_tb;

architecture Behavioral of RegBank_tb is
    -- Component declaration
    component RegBank
        Port ( 
            RegSel : in STD_LOGIC_VECTOR (2 downto 0);
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
            Data_Bus_7 : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Signal declarations
    signal RegSel_sig : STD_LOGIC_VECTOR(2 downto 0);
    signal Clk_sig : STD_LOGIC := '0';
    signal En_sig : STD_LOGIC;
    signal Reset_sig : STD_LOGIC;
    signal Data_IN_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_Bus_0_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_Bus_1_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_Bus_2_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_Bus_3_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_Bus_4_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_Bus_5_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_Bus_6_sig : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_Bus_7_sig : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate the RegBank component
    uut: RegBank
        port map(
            RegSel => RegSel_sig,
            Clk => Clk_sig,
            En => En_sig,
            Reset => Reset_sig,
            Data_IN => Data_IN_sig,
            Data_Bus_0 => Data_Bus_0_sig,
            Data_Bus_1 => Data_Bus_1_sig,
            Data_Bus_2 => Data_Bus_2_sig,
            Data_Bus_3 => Data_Bus_3_sig,
            Data_Bus_4 => Data_Bus_4_sig,
            Data_Bus_5 => Data_Bus_5_sig,
            Data_Bus_6 => Data_Bus_6_sig,
            Data_Bus_7 => Data_Bus_7_sig
        );

process
    begin
        -- Initialize inputs
        RegSel_sig <= "001";
        En_sig <= '0';
        Reset_sig <= '0';
        Data_IN_sig <= "0000";

        -- Wait for a few clock cycles
        wait for 10 ns;

        -- Apply stimulus
        RegSel_sig <= "001";  -- Select register 1
        En_sig <= '1';
        Data_IN_sig <= "1100";
        wait for 200 ns;
        
        Reset_sig <= '1';
        wait;

        -- Apply stimulus for other registers
        -- ...

        -- End simulation
        wait;
    end process;
    
process 
begin
    Clk_sig <= NOT(clk_sig);
    wait for 5ns;
end process;

end Behavioral;

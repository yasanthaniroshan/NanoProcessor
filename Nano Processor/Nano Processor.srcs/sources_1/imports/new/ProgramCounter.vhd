
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ProgramCounter is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           NextAddress : in STD_LOGIC_VECTOR (2 downto 0);
           MemorySelect : out STD_LOGIC_VECTOR (2 downto 0) := "000");
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin

process (Clk) begin
    if rising_edge(Clk) then
        if (Reset = '1') then
            MemorySelect <= "000";
        else
            MemorySelect <= NextAddress;
        end if;
    
    end if;
end process;



end Behavioral;

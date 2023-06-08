


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Creating 4-bit register with Enable 
entity Reg is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           En : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end Reg;

--Defining architecture of register
architecture Behavioral of Reg is

begin
    process (Clk) begin
        if (rising_edge(Clk)) then -- respond when clock rises
            if Reset = '1' then
                Q <= "0000";
            elsif En = '1' then -- Enable should be set
                Q <= D;
            end if;
        end if;
end process;



end Behavioral;

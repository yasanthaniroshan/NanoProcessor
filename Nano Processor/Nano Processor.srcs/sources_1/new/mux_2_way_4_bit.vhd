
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_2_way_4_bit is
Port ( IN_0 : in STD_LOGIC_VECTOR (3 downto 0);
       IN_1 : in STD_LOGIC_VECTOR (3 downto 0);
       Sel : in STD_LOGIC;
       Mux_out : out STD_LOGIC_VECTOR (3 downto 0));
end mux_2_way_4_bit;

architecture Behavioral of mux_2_way_4_bit is

begin

process (IN_0,IN_1,Sel)
    begin
    
    if (Sel = '0') then
        Mux_out <= IN_0;
    elsif (Sel = '1') then
        Mux_out <= IN_1;
    end if;

end process;
end Behavioral;

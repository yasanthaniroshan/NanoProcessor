library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_2_way_3_bit is
Port ( IN_0 : in STD_LOGIC_VECTOR (2 downto 0);
       IN_1 : in STD_LOGIC_VECTOR (2 downto 0);
       Sel : in STD_LOGIC;
       Mux_out : out STD_LOGIC_VECTOR (2 downto 0));
end mux_2_way_3_bit;

architecture Behavioral of mux_2_way_3_bit is

begin
    Mux_out <= IN_0 when (Sel = '0') else IN_1;
end Behavioral;

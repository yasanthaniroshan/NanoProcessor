
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_8_way_4_bit is
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
end mux_8_way_4_bit;

architecture Behavioral of mux_8_way_4_bit is

begin
process(RegSel)
    begin
    case RegSel is
        when "000" =>
            Mux_out <= Reg_0;
        when "001" =>
            Mux_out <= Reg_1;
        when "010" =>
            Mux_out <= Reg_2;
        when "011" =>
            Mux_out <= Reg_3;
        when "100" =>
            Mux_out <= Reg_4;
        when "101" =>
            Mux_out <= Reg_5;
        when "110" =>
            Mux_out <= Reg_6;
        when "111" =>
            Mux_out <= Reg_7;
        when others =>
            Mux_out <= "0000"; -- this case will never occur
            
    end case;
end process;


end Behavioral;

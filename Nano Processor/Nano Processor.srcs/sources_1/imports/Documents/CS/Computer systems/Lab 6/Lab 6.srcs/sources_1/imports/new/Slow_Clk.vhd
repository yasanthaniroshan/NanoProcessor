
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Slow_Clk is
    Port ( Slow_Clk_in : in STD_LOGIC;
           Slow_Clk_out : out STD_LOGIC:='1');
end Slow_Clk;

architecture Behavioral of Slow_Clk is
signal count :integer := 1;
signal clk_status : std_logic := '0';
begin
    process (Slow_Clk_in) begin
        if (rising_edge(Slow_Clk_in)) then
            count <= count +1;
--          if(count = 1) then 
          if(count = 10000000) then
                clk_status <= not clk_status;
                Slow_Clk_out <= clk_status;
                count <= 1;
            end if;
       end if;
    end process;
end Behavioral;

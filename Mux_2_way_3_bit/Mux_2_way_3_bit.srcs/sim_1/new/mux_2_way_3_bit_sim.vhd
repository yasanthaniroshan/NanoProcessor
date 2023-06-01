----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2023 10:57:16 AM
-- Design Name: 
-- Module Name: mux_2_way_3_bit_sim - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_2_way_3_bit_sim is
--  Port ( );
end mux_2_way_3_bit_sim;

architecture Behavioral of mux_2_way_3_bit_sim is

component mux_2_way_3_bit
Port ( IN_0 : in STD_LOGIC_VECTOR (2 downto 0);
       IN_1 : in STD_LOGIC_VECTOR (2 downto 0);
       Sel : in STD_LOGIC;
       Mux_out : out STD_LOGIC_VECTOR (2 downto 0));
end component;

signal Bus_0,Bus_1,Mux_out : STD_LOGIC_VECTOR(2 downto 0);
signal selection : STD_LOGIC;

begin

UUT : mux_2_way_3_bit PORT MAP
(
    IN_0 => Bus_0,
    IN_1 => Bus_1,
    Sel => selection,
    Mux_out => Mux_out
);

process
    begin
        Bus_0 <= "101";
        Bus_1 <= "110";
        selection <= '1';
        
        Wait for 20 ns;
        
        Bus_0 <= "101";
        Bus_1 <= "110";
        selection <= '0';
        
        Wait for 20 ns;
    
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2023 10:40:24 AM
-- Design Name: 
-- Module Name: mux_3_way_2_bit - Behavioral
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

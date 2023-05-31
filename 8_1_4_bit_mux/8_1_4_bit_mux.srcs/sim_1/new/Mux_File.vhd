----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2023 01:58:19 PM
-- Design Name: 
-- Module Name: Mux_File - Behavioral
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

entity Mux_File is
-- Port()
end Mux_File;


architecture Behavioral of Mux_File is

component mux_8_way_4_bit

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
       
end component;

signal Reg_0, Reg_1, Reg_2, Reg_3, Reg_4, Reg_5, Reg_6, Reg_7 : std_logic_vector (3 downto 0) := "1010";
signal Mux_out : std_logic_vector ( 3 downto 0);
signal RegSel : std_logic_vector (2 downto 0);

begin

UUT: mux_8_way_4_bit PORT MAP (
    RegSel => RegSel,
    Reg_0 => Reg_0,
    Reg_1 => Reg_1,
    Reg_2 => Reg_2,
    Reg_3 => Reg_3,
    Reg_4 => Reg_4,
    Reg_5 => Reg_5,
    Reg_6 => Reg_6,
    Reg_7 => Reg_7,
    Mux_out => Mux_out
);

process
begin
    Reg_1 <= "1111";
    RegSel <= "001";
    
    wait for 100 ns;
    
    
end process;


end Behavioral;

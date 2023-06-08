----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 10:53:50 PM
-- Design Name: 
-- Module Name: AU_7seg_sim - Behavioral
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

entity AU_7seg_sim is
--  Port ( );
end AU_7seg_sim;

architecture Behavioral of AU_7seg_sim is
component AU_7_seg 
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           Clk : in STD_LOGIC;
           RegSel : in STD_LOGIC;
           S_LED : out STD_LOGIC_VECTOR (3 downto 0);
           Zero : out STD_LOGIC;
           Carry : out STD_LOGIC;
           S_7seg : out STD_LOGIC_VECTOR (6 downto 0);
           Anode : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal A,S,Anode : STD_LOGIC_VECTOR(3 downto 0) :="0000";
signal S_7seg : STD_LOGIC_VECTOR (6 downto 0);
signal RegSel, Clk , Zero , Carry : STD_LOGIC := '0';

begin

UUT: AU_7_seg
        PORT MAP (
            A => A,
            S_LED => S,
            RegSel => RegSel,
            Clk => Clk,
            Zero => Zero,
            Carry => Carry,
            S_7seg =>S_7seg,
            Anode => Anode
        );

process
begin
    Clk <= NOT(Clk);
    wait for 2ns;
end process;

process 
begin
    A <= "0010";
    RegSel <= '1';
    wait for 100ns;
    RegSel <= '0';
    A <= "0001";
    wait for 100ns;
    A <= "0100";
    RegSel <= '1';
    wait for 100ns;
    A <= "1010";
    RegSel <= '1';
    wait for 100ns;
    A <= "1110";
    RegSel <= '1';
    wait for 100ns;
end process;
end Behavioral;

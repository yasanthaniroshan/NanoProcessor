----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2023 04:59:47 PM
-- Design Name: 
-- Module Name: RCA_4 - Behavioral
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

entity RCA_4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           C_in : in STD_LOGIC;
           M : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           C_out : out STD_LOGIC;
           Zero_Flag : out STD_LOGIC
           );
end RCA_4;

architecture Behavioral of RCA_4 is

component FA
 port (
 A: in std_logic;
 B: in std_logic;
 C_in: in std_logic;
 S: out std_logic;
 C_out: out std_logic);
 end component;

 SIGNAL FA0_S, FA0_C, FA1_S, FA1_C, FA2_S, FA2_C, FA3_S, FA3_C  : std_logic;
 SIGNAL B_new : std_logic_vector (3 downto 0);
 SIGNAL S_Sig : std_logic_vector (3 downto 0);
begin


    FA_0 : FA
        port map (
            A => A(0),
            B => B(0),
            C_in => M, ----Since M is 1 in substraction and M is 0 in addition 
            S => S_Sig(0),
            C_Out => FA0_C);
    FA_1 : FA
        port map (
            A => A(1),
            B => B(1),
            C_in => FA0_C,
            S => S_Sig(1),
            C_Out => FA1_C);
            
    FA_2 : FA
        port map (
            A => A(2),
            B => B(2),
            C_in => FA1_C,
            S => S_Sig(2),
            C_Out => FA2_C);
    FA_3 : FA
        port map (
            A => A(3),
            B => B(3),
            C_in => FA2_C,
            S => S_Sig(3),
            C_Out => C_out);
            
Zero_Flag <= NOT (S_Sig(0) OR S_Sig(1) OR S_Sig(2) OR S_Sig(3));
S <= S_Sig;

end Behavioral;

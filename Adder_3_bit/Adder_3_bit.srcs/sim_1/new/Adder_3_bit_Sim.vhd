----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2023 02:44:59 PM
-- Design Name: 
-- Module Name: Add_Sub_Sim - Behavioral
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

entity Add_Sub_Sim is
--  Port ( );
end Add_Sub_Sim;

architecture Behavioral of Add_Sub_Sim is

Component Adder_3_bit 

    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           B : in STD_LOGIC_VECTOR (2 downto 0);
           C_in : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (2 downto 0);
           C_out : out STD_LOGIC
           );

end component;

Signal A,B,S : std_logic_vector (2 downto 0);
Signal C_in, C_out : std_logic;

begin

UUT : Adder_3_bit PORT MAP(
    A => A,
    B => B,
    C_in => C_in,
    S => S,
    C_out => C_out
);

process
begin

    A <= "011";
    B <= "001";
    C_in <= '0';
    wait for 100ns;

end process;




end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/23/2023 12:10:27 PM
-- Design Name: 
-- Module Name: RegBank - Behavioral
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

entity RegBank is
    Port ( RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           En : in STD_LOGIC;
           Data_IN : in STD_LOGIC_VECTOR(3 downto 0);
           Data_OUT : out STD_LOGIC_VECTOR (3 downto 0));
end RegBank;

architecture Behavioral of RegBank is

component Reg
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;


component Decoder_3_to_8
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal data_signal : STD_LOGIC_VECTOR(3 DOWNTO 0);
signal regsel_signal : STD_LOGIC_VECTOR(7 DOWNTO 0);

begin

Decoder_3_to_8_0 : Decoder_3_to_8
    port map(
        I => RegSel,
        En => En,
        Y => regsel_signal
    );
    
Reg_0 : Reg
    port map(
       D => Data_IN,
       En => regsel_signal(0),
       Clk => Clk,
       Q => Data_OUT
    );
    
Reg_1 : Reg
    port map(
       D => Data_IN,
       En => regsel_signal(1),
       Clk => Clk,
       Q => Data_OUT
    );
    
Reg_2 : Reg
        port map(
           D => Data_IN,
           En => regsel_signal(2),
           Clk => Clk,
           Q => Data_OUT
        );
        
Reg_3 : Reg
            port map(
               D => Data_IN,
               En => regsel_signal(3),
               Clk => Clk,
               Q => Data_OUT
            );

Reg_4 : Reg
    port map(
       D => Data_IN,
       En => regsel_signal(4),
       Clk => Clk,
       Q => Data_OUT
    );
    
    
Reg_5 : Reg
        port map(
           D => Data_IN,
           En => regsel_signal(5),
           Clk => Clk,
           Q => Data_OUT
        );
        
Reg_6 : Reg
            port map(
               D => Data_IN,
               En => regsel_signal(6),
               Clk => Clk,
               Q => Data_OUT
            );
            
Reg_7 : Reg
                port map(
                   D => Data_IN,
                   En => regsel_signal(7),
                   Clk => Clk,
                   Q => Data_OUT
                );

end Behavioral;

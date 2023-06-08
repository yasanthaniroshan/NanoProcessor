library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LUT_8_3 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           O : out STD_LOGIC_VECTOR (11 downto 0));
end LUT_8_3;

architecture Behavioral of LUT_8_3 is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
 
 signal sevenSegment_ROM : rom_type := (
 "101010101010", ---0
 "101010101010", ---1
 "101010101010", ---2
 "101010101010", ---3
 "101010101010", ---4
 "101010101010", ---5
 "101010101010", ---6
 "101010101010" ---7
 );


begin

O <= sevenSegment_ROM(to_integer(unsigned(I)));


end Behavioral;

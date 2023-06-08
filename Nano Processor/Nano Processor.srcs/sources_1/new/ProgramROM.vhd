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

entity ProgramROM is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           O : out STD_LOGIC_VECTOR (11 downto 0));
end ProgramROM;

architecture Behavioral of ProgramROM is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);
 
 signal sevenSegment_ROM : rom_type := (
 "100010000010", ---0
 "100100000001", ---1
 "010100000000", ---2
 "000010100000", ---3
 "110010000111", ---4
 "110000000011", ---5
 "101010101010", ---6
 "101010101010" ---7
 );


begin

process(I)

begin
    O <= sevenSegment_ROM(to_integer(unsigned(I)));
end process;


end Behavioral;

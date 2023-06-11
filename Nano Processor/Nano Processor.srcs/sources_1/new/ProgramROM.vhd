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

-- GET THE SUM OF ALL THE NUMBERS FROM 1 TO 3
-- FIRST LOAD 1,2,3 INTO REGISTERS
-- THEN ADD EACH OF THE REGISTERS TO GET THE SUM
 
 signal sevenSegment_ROM : rom_type := (
  "100010000001", -- LOAD 1 INTO R1
  "100100000010", -- LOAD 2 INTO R2
  "100110000011", -- LOAD 3 INTO R3
  "101110000000", -- LOAD 0 INTO R7
  "001110010000", -- ADD R7 AND R1
  "001110100000", -- ADD R7 AND R2
  "001110110000", -- ADD R7 AND R3
  "000000000000"  -- EMPTY INSTRUCTION !
 );



begin

process(I)

begin
    O <= sevenSegment_ROM(to_integer(unsigned(I)));
end process;


end Behavioral;

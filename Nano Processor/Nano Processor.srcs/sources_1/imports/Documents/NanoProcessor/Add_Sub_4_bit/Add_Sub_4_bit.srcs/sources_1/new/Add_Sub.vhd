
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Add_Sub is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           M : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           C_out : out STD_LOGIC;
           Zero_Flag : out STD_LOGIC
           );
end Add_Sub;

architecture Behavioral of Add_Sub is

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
        B => B_new(0),
        C_in => M, ---- Since M is 1 in substraction and M is 0 in addition 
        S => S_Sig(0),
        C_Out => FA0_C);
FA_1 : FA
    port map (
        A => A(1),
        B => B_new(1),
        C_in => FA0_C,
        S => S_Sig(1),
        C_Out => FA1_C);
        
FA_2 : FA
    port map (
        A => A(2),
        B => B_new(2),
        C_in => FA1_C,
        S => S_Sig(2),
        C_Out => FA2_C);
FA_3 : FA
    port map (
        A => A(3),
        B => B_new(3),
        C_in => FA2_C,
        S => S_Sig(3),
        C_Out => C_out);

-- GET THE MODIFIED INPUT TO B BY XOR WITH M
-- THIS WILL INVERT EACH BIT WHEN THE NEG INSTRUCTION IS RUN
B_new(0) <= B(0) XOR M;
B_new(1) <= B(1) XOR M;
B_new(2) <= B(2) XOR M;
B_new(3) <= B(3) XOR M;

-- ZERO FLAG IS SET WHEN ALL THE BITS OF S ARE 0
Zero_Flag <= NOT (S_Sig(0) OR S_Sig(1) OR S_Sig(2) OR S_Sig(3));
S <= S_Sig;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADD4 is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Ci : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Co : out STD_LOGIC);
end ADD4;

architecture Behavioral of ADD4 is

component full_add is
    Port (A, B, Ci : in std_logic;
    Co, S : out std_logic );
    
end component;
signal C1, C2, C3: std_logic;
begin
A0 : full_add port map (A=>A(0),
                        B=>B(0),
                        Ci=>Ci,
                        S=>S(0),
                        Co=>C1);         
                        
A1 : full_add port map (A=>A(1),
                        B=>B(1),
                        Ci=>C1,
                        S=>S(1),
                        Co=>C2);                                                                        
                        
A2 : full_add port map (A=>A(2),
                        B=>B(2),
                        Ci=>C2,
                        S=>S(2),
                        Co=>C3);                         

A3 : full_add port map (A=>A(3),
                        B=>B(3),
                        Ci=>C3,
                        S=>S(3),
                        Co=>Co); 


end Behavioral;

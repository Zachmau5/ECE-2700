library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_add is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           Co : out STD_LOGIC;
           s : out STD_LOGIC);
end full_add;

architecture Behavioral of full_add is

begin
s <= (A xor B xor Ci);
Co <= (A and B) or (Ci and A) or (Ci and B);

end Behavioral;

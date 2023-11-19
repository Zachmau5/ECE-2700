library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;
entity Ex_OR is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           x_out : out STD_LOGIC_VECTOR (7 downto 0));
end EX_OR;

architecture Behavioral of EX_OR is

begin

    x_out <= a xor b;
end Behavioral;

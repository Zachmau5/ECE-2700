library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ADD8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ci : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Co : out STD_LOGIC);
end ADD8;

architecture Structural of ADD8 is
component full_add is 
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Ci : in STD_LOGIC;
           S : out STD_LOGIC;
           Co : out STD_LOGIC);
end component full_add;

signal C: STD_LOGIC_VECTOR(6 downto 0);
begin
    bit0:full_add port map(A(0),B(0),Ci,S(0),C(0));
    bit1:full_add port map(A(1),B(1),c(0),S(1),C(1));
    bit2:full_add port map(A(2),B(2),C(1),S(2),C(2));
    bit3:full_add port map(A(3),B(3),C(2),S(3),C(3));
    bit4:full_add port map(A(4),B(4),C(3),S(4),C(4));
    bit5:full_add port map(A(5),B(5),C(4),S(5),C(5));
    bit6:full_add port map(A(6),B(6),C(5),S(6),C(6));
    bit7:full_add port map(A(7),B(7),c(6),S(7),Co);
    

end Structural;

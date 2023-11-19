
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity HOLD is
  Port (X: in std_logic_vector(7 downto 0);
       Xo: out std_logic_vector(7 downto 0));
end HOLD;

architecture Behavioral of HOLD is
begin
  Xo <= X; -- Simply pass the input X to the output Xo
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LOAD is
  Port (Y : in std_logic_vector(7 downto 0);
       Y_out: out std_logic_vector(7 downto 0));
end LOAD;

architecture Behavioral of LOAD is
begin
  -- Just pass the input Y to the output Y_out
  Y_out <= Y;
end Behavioral;


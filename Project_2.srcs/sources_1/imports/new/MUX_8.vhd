
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity MUX_8 is
    port(I0,I1,I2,I3,I4: in std_logic_vector(7 downto 0);
        OP: in std_logic_vector(2 downto 0);
        alu_mux_out: out std_logic_vector(7 downto 0));
end MUX_8;

architecture Behavioral of MUX_8 is
--constant op_addnc: std_logic_vector(2 downto 0) := "000";
--constant op_addwc: std_logic_vector(2 downto 0) := "001";
--constant op_xor: std_logic_vector(2 downto 0) := "010";
--constant op_load: std_logic_vector(2 downto 0) := "011";
--constant op_hold: std_logic_vector(2 downto 0) := "100";  
begin


alu_mux_out <= I0 when OP= "000" else
     I1 when OP= "001" else
     I2 when OP= "010" else
     I3 when OP = "011" else
     I4 ;
     
     


end Behavioral;
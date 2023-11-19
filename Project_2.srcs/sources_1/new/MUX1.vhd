----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 12:23:44 PM
-- Design Name: 
-- Module Name: MUX1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX1 is
  Port (I0,I1: in std_logic;
  Ci: in std_logic;
  OP: in std_logic_vector(2 downto 0);
  Y: out std_logic );
end MUX1;

architecture Behavioral of MUX1 is

begin
Y <= I0 when OP ="000" else
    I1 when OP ="001" else 
    Ci;

end Behavioral;

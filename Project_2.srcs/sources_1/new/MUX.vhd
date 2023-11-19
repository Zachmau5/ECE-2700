----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2023 06:56:52 PM
-- Design Name: 
-- Module Name: MUX - Behavioral
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

entity MUX is
    Port ( I0 : in STD_LOGIC_VECTOR (7 downto 0);
           I1 : in STD_LOGIC_VECTOR (7 downto 0);
           fetch : in STD_LOGIC;
           fetch_out : out STD_LOGIC_VECTOR (7 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
fetch_out <= I0 when fetch = '0' else I1;


end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/06/2023 09:05:37 PM
-- Design Name: 
-- Module Name: MUX_B - Behavioral
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

entity MUX_B is
  Port (
        mux_IB: in std_logic_vector(7 downto 0);
        MUX_B_OUT: out std_logic_vector(7 downto 0);
        mux_sel: in std_logic);
end MUX_B;

architecture Behavioral of MUX_B is

begin
MUX_B_OUT <=mux_IB when mux_sel = '1' else
            "ZZZZZZZZ" when mux_sel ='0';
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/09/2023 12:11:01 AM
-- Design Name: 
-- Module Name: ALU_MUX_2 - Behavioral
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

entity ALU_MUX_2 is
 Port ( alu_mux_2_out: out std_logic_vector(7 downto 0);
        alu_mux_2_in: in std_logic_vector( 7 downto 0);
        alu_mux_2_sig: in std_logic 
 );
end ALU_MUX_2;

architecture Behavioral of ALU_MUX_2 is

begin
alu_mux_2_out <= alu_mux_2_in when alu_mux_2_sig ='1' else
    "ZZZZZZZZ" when alu_mux_2_sig='0';
end Behavioral;

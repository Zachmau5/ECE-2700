----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2023 09:12:00 PM
-- Design Name: 
-- Module Name: MUX_BUFFER - Behavioral
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

entity MUX_BUFFER is
    Port (
        rd    : in  std_logic;                  -- Read enable signal
        wr    : in  std_logic;
        accum_in: in std_logic_vector(7 downto 0);                  -- Write enable signal
        mem_data  : inout std_logic_vector(7 downto 0); -- Bi-directional data bus
        buf   : out std_logic_vector(7 downto 0)    -- Buffered output
    );
end MUX_BUFFER;

architecture Behavioral of MUX_BUFFER is

    -- Tri-state buffer logic
begin
mem_data <= accum_in when wr ='1' AND rd='0' else
    "ZZZZZZZZ" when wr = '0' AND rd ='1' else
    "ZZZZZZZZ";
buf <= mem_data;

end Behavioral;

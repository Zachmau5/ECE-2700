library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- for arithmetic functions

entity ADDRESS_BUS is
    Port (
        inc_pc, ld_pc, ld_mar, fetch, clk: in std_logic;
        address_in: in std_logic_vector(7 downto 0);
        addr_b: out std_logic_vector(7 downto 0)
    );
end ADDRESS_BUS;

architecture Behavioral of ADDRESS_BUS is
signal MAR: std_logic_vector(7 downto 0);
signal PC: unsigned(7 downto 0);
begin

-- Multiplexer for selecting the address output based on the fetch signal
addr_b <=std_logic_vector(PC) when fetch = '1' else
               MAR when fetch = '0';

-- Process for PC
Process(clk)
begin
    if rising_edge(clk) then
        if ld_pc='1' then
            PC<=unsigned(address_in);
        elsif inc_pc='1' then
             PC<= PC+1;
        else
             PC<= PC;
        end if;
    end if;
end process;
-- Process for MAR
process(clk)
begin
    if rising_edge(clk) then
        if ld_mar='1' then 
            MAR <= address_in; -- Load MAR with address_in_address when ld_mar is asserted
        else
            MAR<=MAR;
        end if;
    end if;
end process;

end Behavioral;

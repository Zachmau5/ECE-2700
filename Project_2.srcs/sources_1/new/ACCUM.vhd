library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity ACCUM is
    Port (
        clk     : in  STD_LOGIC;             -- Clock input
        rst     : in  STD_LOGIC;             -- Reset input
        enable  : in  STD_LOGIC;             -- Enable signal
        D       : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input
        Q       : out STD_LOGIC_VECTOR(7 downto 0)  -- 8-bit output for the sum
    );
end ACCUM;

architecture Behavioral of ACCUM is
    signal Q_sum : std_logic_vector(7 downto 0);
begin
    Q <= Q_sum;

    process(clk, rst)
    begin
        if rst = '1' then
            Q_sum <= (others => '0'); 
        elsif rising_edge(clk) then
            if enable = '1' then
                Q_sum <= D; -- Load the D into Q_sum when enabled
            else
                Q_sum <= Q_sum; -- Hold the current value of Q_sum
            end if;
        end if;
    end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ACCUM_TB is
end ACCUM_TB;

architecture Behavioral of ACCUM_TB is

    component ACCUM
        Port (
            clk     : in  STD_LOGIC;
            rst     : in  STD_LOGIC;
            enable  : in  STD_LOGIC;
            D       : in  STD_LOGIC_VECTOR(7 downto 0);
            Q       : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    constant clk_period : time := 10 ns;


    signal clk_TB     : STD_LOGIC := '0';
    signal rst_TB     : STD_LOGIC := '0';
    signal enable_TB  : STD_LOGIC := '0';
    signal D_TB       : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    signal Q_TB       : STD_LOGIC_VECTOR(7 downto 0);

begin

    uut: ACCUM port map (
        clk => clk_TB,
        rst => rst_TB,
        enable => enable_TB,
        D => D_TB,
        Q => Q_TB
    );

    clk_process : process
    begin
        clk_TB <= '0';
        wait for clk_period;
        clk_TB <= '1';
        wait for clk_period;
    end process;

    tb_process: process
    begin
        -- Reset the accumulator
        rst_TB <= '1';
        wait for clk_period*2; -- Wait for two clock cycles
        rst_TB <= '0';

        -- Test case 1: Load a value into the accumulator
        D_TB <= "00001111";
        enable_TB <= '1'; -- Enable the accumulator
        wait for clk_period; 

        -- Check the output
        assert Q_TB = "00001111"
        report "Test case 1 failed: Q_TB does not match expected value 00001111"
        severity error;

        -- Test case 2: Hold the current value
        enable_TB <= '0'; -- Disable the accumulator
        wait for clk_period; 

        -- Check the output
        assert Q_TB = "00001111"
        report "Test case 2 failed: Q_TB does not hold the value 00001111"
        severity error;

        -- Test case 3: Reset the accumulator
        rst_TB <= '1';
        wait for clk_period; 
        rst_TB <= '0';

        -- Check the output
        assert Q_TB = "00000000"
        report "Test case 3 failed: Q_TB does not reset to 00000000"
        severity error;


        wait;
    end process;

end Behavioral;

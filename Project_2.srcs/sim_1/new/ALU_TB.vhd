library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- For arithmetic functions with Signed or Unsigned values

entity ALU_TB is
--  Port ( );
end ALU_TB;

architecture Behavioral of ALU_TB is
    component ALU is
        Port (
            Aa : in std_logic_vector(7 downto 0);
            Ba : in std_logic_vector(7 downto 0);
            OPa : in std_logic_vector(2 downto 0);
            ALU_OUT : out std_logic_vector(7 downto 0);
            Coa : out std_logic;
            Cia : in std_logic
        );
    end component;

    -- Descriptive Signal Declaration 
    signal Aa_TB : std_logic_vector(7 downto 0);
    signal Ba_TB : std_logic_vector(7 downto 0);
    signal OPa_TB : std_logic_vector(2 downto 0);
    signal ALU_OUT_TB : std_logic_vector(7 downto 0);
    signal Coa_TB : std_logic;
    signal Cia_TB : std_logic := '0'; -- Assuming a default value for carry-in

    -- Test vectors
    type op_code_array is array (0 to 4) of std_logic_vector(2 downto 0);
    constant op_code_vec: op_code_array := ("000", "001", "010", "011", "100");
    type a_input_array is array (0 to 3) of std_logic_vector(7 downto 0);
    constant a_vec: a_input_array := (X"00", X"7F", X"9A", X"6B"); 
    type b_input_array is array (0 to 3) of std_logic_vector(7 downto 0);
    constant b_vec: b_input_array := (X"00", X"81", X"65", X"8F"); 
    type ci_input_array is array (0 to 3) of std_logic;
    constant ci_vec: ci_input_array := ('1', '0', '1', '1'); 

begin
    -- Instantiate the Unit Under Test (UUT)
    UUT: ALU port map (
        Aa => Aa_TB,
        Ba => Ba_TB,
        OPa => OPa_TB,
        ALU_OUT => ALU_OUT_TB,
        Coa => Coa_TB,
        Cia => Cia_TB
    );

    -- Test bench process
    tb_process: process
    begin
        -- Apply test vectors
        for mm in 0 to 4 loop
            OPa_TB <= op_code_vec(mm);
            for ii in 0 to 3 loop
                Aa_TB <= a_vec(ii);
                for jj in 0 to 3 loop
                    Ba_TB <= b_vec(jj);
                    for kk in 0 to 3 loop
                        Cia_TB <= ci_vec(kk);
                        wait for 10 ns; 
                    end loop;
                end loop;
            end loop;
        end loop;
        wait; -- Finish the simulation
    end process tb_process;

end Behavioral;
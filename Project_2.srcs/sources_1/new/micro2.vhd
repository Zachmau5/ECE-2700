library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity MICRO2 is
    Port ( 
    clk : in STD_LOGIC;                            
    rst : in STD_LOGIC;                             
    rd : in STD_LOGIC;          
    wr : in STD_LOGIC;          
    fetch : in STD_LOGIC;       
    ld_pc : in STD_LOGIC;       
    ld_mar : in STD_LOGIC;                        
    inc_pc : in STD_LOGIC;                          
    op : in STD_LOGIC_VECTOR (2 downto 0);          
    addr : out STD_LOGIC_VECTOR (7 downto 0);       
    data : inout STD_LOGIC_VECTOR (7 downto 0));    
end micro2;

architecture Behavioral of micro2 is

component ALU is
    Port ( Aa : in STD_LOGIC_VECTOR (7 downto 0);
           Ba : in STD_LOGIC_VECTOR (7 downto 0);
           OPa : in STD_LOGIC_VECTOR (2 downto 0);
           ALU_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           Coa : out STD_LOGIC;
           Cia : in STD_LOGIC);
end component ALU;

component ACCUM is
    Port (
        clk     : in  STD_LOGIC;             
        rst     : in  STD_LOGIC;             
        enable  : in  STD_LOGIC;             
        D       : in  STD_LOGIC_VECTOR(7 downto 0); 
        Q       : out STD_LOGIC_VECTOR(7 downto 0)  
    );
end component ACCUM;

    signal Aa: std_logic_vector (7 downto 0);
    signal Ba: std_logic_vector (7 downto 0);
    signal ALU_out:  std_logic_vector( 7 downto 0);
    signal Coa:  std_logic;
    signal Cia: std_logic;
    signal alu_s: STD_LOGIC_VECTOR(7 downto 0);
    signal OPa: std_logic_vector(2 downto 0);
    signal internal_bus_s: std_logic_vector(7 downto 0);
    signal pc_s: std_logic_vector(7 downto 0);
    signal mar_s: std_logic_vector(7 downto 0);
    signal accum_s: std_logic_vector(7 downto 0);


begin
U0:ALU port map (Aa,Ba,OPa,ALU_OUT,Coa,Cia);
U1:ACCUM port map(
CLK=>CLK,
Rst=>RST,
enable =>'1',
D=> ALU_out,
Q=>accum_s);
    process(clk, rst)
    begin
        if rst = '1' then
            pc_s <= "00000000";
        elsif rising_edge(clk) then
            if ld_pc = '1' then
                pc_s <= internal_bus_s;
            elsif inc_pc = '1' then
                pc_s <= STD_LOGIC_VECTOR(unsigned(pc_s) + 1);
            end if;
        end if;   
    end process;
--MAR
mar_s<= internal_bus_s when ld_mar ='1' else "00000000";
--MUX_B
addr <= pc_s when fetch ='1' else mar_s;

--WR/RD buff
data<= accum_s when wr='1' else "ZZZZZZZZ";
internal_bus_s<= data when rd='1' else "ZZZZZZZZ";

Cia<=Coa when rising_edge(clk);

OPa <= OP;
Aa <= accum_s;
Ba <= internal_bus_s;


end Behavioral;


--Commented out components from previous iterations. I tried to interconnect everything and could not get signals to work without aspects of proj 3.
--keeping in case applicable for proj 3.
--component MUX_BUFFER is
--    Port (
--        rd    : in  std_logic;
--        wr    : in  std_logic;
--        accum_in: in std_logic_vector(7 downto 0);
--        mem_data  : inout std_logic_vector(7 downto 0);
--        buf   : out std_logic_vector(7 downto 0)
--    );
--end component MUX_BUFFER;


--component ALU_MUX_2 is
-- Port ( alu_mux_2_out: out std_logic_vector(7 downto 0);
--        alu_mux_2_in: in std_logic_vector( 7 downto 0);
--        alu_mux_2_sig: in std_logic
-- );
--end component ALU_MUX_2;

--component MUX_B is
--  Port (
--        mux_IB: in std_logic_vector(7 downto 0);
--        MUX_B_OUT: out std_logic_vector(7 downto 0);
--        mux_sel: in std_logic);
--end component MUX_B;

--component ADDRESS_BUS is
--    Port (
--        inc_pc, ld_pc, ld_mar, fetch, clk: in std_logic;
--        address_in: in std_logic_vector(7 downto 0);
--        addr_b: out std_logic_vector(7 downto 0)
--    );
--end component ADDRESS_BUS;

--signal user_input_s: std_logic_vector(7 downto 0);
--signal alu_mux_2_s: std_logic_vector(7 downto 0);
--signal Carry_s: std_logic;
--signal accum_data: std_logic_vector( 7 downto 0);
--signal mux_b_s: std_logic_vector(7 downto 0);


--U0: ALU port map(
--        A =>Accum_s,
--        B => internal_bus_s,
--        OP => op_code_s,
--        ALU_OUT => alu_s,
--        Co => Carry_s,
--        Ci => Carry_s
--);

--U1: ACCUM port map(
--    clk => clk,
--    rst => rst,
--    enable => '1',
--    D => alu_s,
--    Q => accum_data
--);


--U2: MUX_BUFFER port map(
--    rd => rd,
--    wr => wr,
--    accum_in=> accum_data,
--    mem_data => internal_bus_s,
--    buf => internal_bus_s
--);

--U3: ADDRESS_BUS port map(
--    inc_pc=> inc_pc,
--    ld_pc=> ld_pc,
--    ld_mar => ld_mar,
--    fetch => fetch,
--    clk => clk,
--    address_in => alu_mux_2_s,
--    addr_b=>addr
--    );
--U4: MUX_B port map (
--        mux_IB => internal_bus_s,
--        MUX_B_OUT => mux_b_s,
--        mux_sel =>ld_mar

--);
--U5: ALU_MUX_2 port map (
--        alu_mux_2_out => alu_mux_2_s,
--        alu_mux_2_in => internal_bus_s,
--        alu_mux_2_sig =>ld_mar
-- );

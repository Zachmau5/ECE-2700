library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( Aa : in STD_LOGIC_VECTOR (7 downto 0);
           Ba : in STD_LOGIC_VECTOR (7 downto 0);
           OPa : in STD_LOGIC_VECTOR (2 downto 0);
           ALU_OUT : out STD_LOGIC_VECTOR (7 downto 0);
           Coa : out STD_LOGIC;
           Cia : in STD_LOGIC);
end ALU;

architecture behavioral of ALU is

component ADD8 is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           Ci : in STD_LOGIC;
           S : out STD_LOGIC_VECTOR (7 downto 0);
           Co : out STD_LOGIC);

end component ADD8;

component EX_OR is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           x_out : out STD_LOGIC_VECTOR (7 downto 0));
end component EX_OR;

component MUX1 is
  Port (I0,I1: in std_logic;
  Ci: in std_logic;
  OP: in std_logic_vector(2 downto 0);
  Y: out std_logic );
end component MUX1;


component MUX_8 is
    port(I0,I1,I2,I3,I4: in std_logic_vector(7 downto 0);
        OP: in std_logic_vector(2 downto 0);
        alu_mux_out: out std_logic_vector(7 downto 0));
end component MUX_8;

signal Xor_s, Yo, ADD8_S, ADD8_NC_S, M : std_logic_vector(7 downto 0);
signal Xo: std_logic_vector(7 downto 0);
signal Ci_s,Co_s : std_logic;
signal ALU_C0_s: std_logic;        
signal result: std_logic_vector( 7 downto 0);


begin
U0: ADD8 port map (
    A => Aa,
    B => Ba,
    Ci => '0',         
    S => ADD8_NC_S,     
    Co => Ci_s         
);
U1 : ADD8 port map (
    A => Aa,
    B => Ba,
    Ci => Cia,
    S => ADD8_S,
    Co => Co_s  
);

U2 : Ex_Or port map (
    A=>Aa,
    B=>Ba,
    X_out=>Xor_s
); 
                                   
U3: MUX1 port map(
    I0=>Ci_s,
    I1 =>Co_s,
    OP => OPa,
    Ci=>Cia,
    Y=>ALU_C0_s
);

U4: MUX_8 port map (
    I0=>ADD8_NC_S,
    I1=>ADD8_S,
    I2=>Xor_s,
    I3=>Ba,
    I4=>Aa,
    OP=>OPa,
    alu_mux_out=>result
);
    ALU_Out <= result;
    Coa <= ALU_C0_s;
end behavioral;

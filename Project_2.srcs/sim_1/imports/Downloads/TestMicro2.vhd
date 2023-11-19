library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TestMicro2 is
--  Port ( );
end TestMicro2;

architecture Behavioral of TestMicro2 is
  component micro2 is
    Port ( clk : in STD_LOGIC;
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
  end component;
  
  signal clk,rst,rd,wr,fetch,ld_pc,ld_mar,inc_pc: std_logic;
  signal op: std_logic_vector(2 downto 0);
  signal addr, data: std_logic_vector(7 downto 0);
  
  -- opcode definitions
  constant add:  std_logic_vector(2 downto 0) := "000";
  constant addc: std_logic_vector(2 downto 0) := "001";
  constant exor: std_logic_vector(2 downto 0) := "010";
  constant load: std_logic_vector(2 downto 0) := "011";
  constant hold: std_logic_vector(2 downto 0) := "100";
begin

  uut: micro2 port map(clk=>clk, rst=>rst, rd => rd, wr=>wr,
                       fetch=>fetch, ld_pc=>ld_pc, ld_mar=>ld_mar,
                       inc_pc=>inc_pc, op=>op, addr=>addr, data=>data);

  -- clock process
process
begin
	clk <= '0';
	wait for 10ns;
	for i in 1 to 80 loop
		clk <= not clk;
		wait for 5ns;
	end loop;
	wait;
end process;

-- Stimulus process
process
begin		
	rst <= '1';
	-- PC = 00, LDI  9E
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 5ns; rst <= '0'; wait for 6ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= load;
	data <= "10011110"; wait for 10ns;
	
	-- PC = 02, ADDI AA (A = 48, C=1)
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= add;
	data <= "10101010"; wait for 10ns;

	-- PC = 04, STO  3F
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '1'; op <= hold;
	data <= "00111111"; wait for 10ns;
	-- data should be "01001000"
	rd <= '0'; wr <= '1'; fetch <= '0'; inc_pc <= '0'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "ZZZZZZZZ"; wait for 5ns;
	assert data = "01001000" report "incorrect data value"; wait for 5ns;

	-- PC = 06, ADC  3F (A = 91, C = 0)
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '1'; op <= hold;
	data <= "00111111"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '0'; inc_pc <= '0'; ld_pc <= '0'; ld_mar <= '0'; op <= addc;
	data <= "01001000"; wait for 10ns;
	-- PC = 08, STO  3F
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '1'; op <= hold;
	data <= "00111111"; wait for 10ns;
	-- data should be "10010001"
	rd <= '0'; wr <= '1'; fetch <= '0'; inc_pc <= '0'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "ZZZZZZZZ"; wait for 5ns; 
	assert data = "10010001" report "incorrect data value"; wait for 5ns;

	-- PC = 0A ADCI 7B (A = 0C, C = 1)
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= addc;
	data <= "01111011"; wait for 10ns;

	-- PC = 0C, XOR  3F (A = 9D, C = 1)
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '1'; op <= hold;
	data <= "00111111"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '0'; inc_pc <= '0'; ld_pc <= '0'; ld_mar <= '0'; op <= exor;
	data <= "10010001"; wait for 10ns;

	-- PC = 0E, ADCI 4A (A = E8, C = 0)
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= addc;
	data <= "01001010"; wait for 10ns;

	-- PC = 10, STO  3E
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '1'; op <= hold;
	data <= "00111110"; wait for 10ns;
	-- data should be "11101000"
	rd <= '0'; wr <= '1'; fetch <= '0'; inc_pc <= '0'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "ZZZZZZZZ"; wait for 5ns; 
	assert data = "11101000" report "incorrect data value"; wait for 5ns;

	-- PC = 12, LD   3F
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '1'; op <= hold;
	data <= "00111111"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '0'; inc_pc <= '0'; ld_pc <= '0'; ld_mar <= '0'; op <= load;
	data <= "10010001"; wait for 10ns;

	-- PC = 14, XORI FF
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= exor;
	data <= "11111111"; wait for 10ns;

	-- PC = 16, ADD  3E (C =1)
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '1'; op <= hold;
	data <= "00111110"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '0'; inc_pc <= '0'; ld_pc <= '0'; ld_mar <= '0'; op <= add;
	data <= "11101000"; wait for 10ns;

	-- PC = 18, JC   28
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '0'; ld_pc <= '1'; ld_mar <= '0'; op <= hold;
	data <= "00101000"; wait for 5ns;
	assert addr = x"19" report "incorrect address value"; wait for 5ns;

	-- PC = 28, ADDI 01
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= add;
	data <= "00000001"; wait for 5ns;
	assert addr = x"29" report "incorrect address value"; wait for 5ns;

	-- PC = 2A, STO 3E
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '1'; op <= hold;
	data <= "00111110"; wait for 10ns;
	-- data should be 57
	rd <= '0'; wr <= '1'; fetch <= '0'; inc_pc <= '0'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "ZZZZZZZZ"; wait for 5ns;
	assert data = "01010111" report "incorrect data value"; wait for 5ns;

	-- PC = 2C, JMP 12
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 10ns;
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '1'; ld_mar <= '0'; op <= hold;
	data <= "00010010"; wait for 10ns;

	-- PC = 12
	rd <= '1'; wr <= '0'; fetch <= '1'; inc_pc <= '1'; ld_pc <= '0'; ld_mar <= '0'; op <= hold;
	data <= "XXXXXXXX"; wait for 5ns;
	assert addr = x"12" report "incorrect address value"; wait for 5ns;
	wait;
end process;

end Behavioral;

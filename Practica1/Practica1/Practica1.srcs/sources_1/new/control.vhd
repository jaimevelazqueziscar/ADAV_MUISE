LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY control IS 
  PORT (
     reset, clk    : in std_logic;
     validacion    : in std_logic;
     flags         : in  std_logic_vector(7 downto 0);
     control_mux1  : out std_logic;
     control_mux2  : out std_logic_vector(3 downto 0);
     control_mux3  : out std_logic;
     control_mux4  : out std_logic_vector(2 downto 0);
     control_mux_r1 : out std_logic;
     control_mux_r2 : out std_logic_vector(1 downto 0);
     control_mux_r3 : out std_logic;
     control_mux_r4 : out std_logic;
     flag_sv1       : out std_logic;
     flag_sv2       : out std_logic;
     flag_sv3       : out std_logic;
     flag_sv4       : out std_logic;
     comandos      : out std_logic_vector(7 downto 0);
     fin           : out std_logic );
END control;

ARCHITECTURE behavioral OF control IS
    
    type state_type is (idle, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10);
    signal state_reg, state_next : state_type;
    
    signal control_mux1_reg, control_mux3_reg, control_mux1_next, control_mux3_next, control_mux_r1_reg, control_mux_r1_next, control_mux_r3_reg,
    control_mux_r3_next, control_mux_r4_reg, control_mux_r4_next, flag_sv1_reg, flag_sv1_next, flag_sv2_reg, flag_sv2_next, flag_sv3_reg, flag_sv3_next,
    flag_sv4_reg, flag_sv4_next, fin_next, fin_reg : std_logic;

    signal control_mux2_reg, control_mux2_next : std_logic_vector(3 downto 0);
    signal control_mux4_reg, control_mux4_next : std_logic_vector(2 downto 0);
    signal control_mux_r2_reg, control_mux_r2_next : std_logic_vector(1 downto 0);

begin  

process(clk)
begin

    if (reset = '0') then
        state_reg <= idle;
        control_mux1_reg <= '0';
        control_mux2_reg <= "0000";
        control_mux3_reg <= '0';
        control_mux4_reg <= "000";
        control_mux_r1_reg <= '0';
        control_mux_r2_reg <= "00";
        control_mux_r3_reg <= '0';
        control_mux_r4_reg <= '0';
        flag_sv1_reg <= '0';
        flag_sv2_reg <= '0';
        flag_sv3_reg <= '0';
        flag_sv4_reg <= '0';
        fin_reg <= '0';

    elsif(clk'event and clk='1') then
        state_reg <= state_next;
        control_mux1_reg <= control_mux1_next;
        control_mux2_reg <= control_mux2_next;
        control_mux3_reg <= control_mux3_next;
        control_mux4_reg <= control_mux4_next;
        control_mux_r1_reg <= control_mux_r1_next;
        control_mux_r2_reg <= control_mux_r2_next;
        control_mux_r3_reg <= control_mux_r3_next;
        control_mux_r4_reg <= control_mux_r4_next;
        flag_sv1_reg <= flag_sv1_next;
        flag_sv2_reg <= flag_sv2_next;
        flag_sv3_reg <= flag_sv3_next;
        flag_sv4_reg <= flag_sv4_next;
        fin_reg <= fin_next;
    end if;
end process;


process(state_reg, validacion)

begin

    control_mux1_next <= control_mux1_reg;
    control_mux2_next <= control_mux2_reg;
    control_mux3_next <= control_mux3_reg;
    control_mux4_next <= control_mux4_reg;
    control_mux_r1_next <= control_mux_r1_reg;
    control_mux_r2_next <= control_mux_r2_reg;
    control_mux_r3_next <= control_mux_r3_reg;
    control_mux_r4_next <= control_mux_r4_reg;
    flag_sv1_next <= flag_sv1_reg;
    flag_sv2_next <= flag_sv2_reg;
    flag_sv3_next <= flag_sv3_reg;
    flag_sv4_next <= flag_sv4_reg;
    fin_next <= fin_reg;


case state_reg is

    when idle =>
    control_mux1_next <= '0';
            control_mux2_next <= "0000";
            control_mux3_next <= '0';
            control_mux4_next <= "000";
            control_mux_r1_next <= '0';
            control_mux_r2_next <= "00";
            control_mux_r3_next <= '1';
            control_mux_r4_next <= '0';  
            flag_sv1_next <= '0';
            flag_sv2_next <= '0';
            flag_sv3_next <= '0';
            flag_sv4_next <= '0';
        state_next <= t0;

    when t0 =>
        control_mux1_next <= '0';
        control_mux2_next <= "0000";
        control_mux3_next <= '0';
        control_mux4_next <= "000";
        control_mux_r1_next <= '1';
        control_mux_r2_next <= "00";
        control_mux_r3_next <= '1';
        control_mux_r4_next <= '1';  
        flag_sv1_next <= '0';
        flag_sv2_next <= '0';
        flag_sv3_next <= '0';
        flag_sv4_next <= '0'; 
        fin_next <= '0';
        state_next <= t1;       
       
   when t1 =>
        control_mux2_next <= "0001";     
        control_mux4_next <= "000";
        control_mux_r1_next <= '1';
        control_mux_r3_next <= '0';
        control_mux_r4_next <= '1';
        state_next <= t2;
        
   when t2 =>
        control_mux1_next <= '1';
        control_mux2_next <= "0010";     
        control_mux3_next <= '0';
        control_mux4_next <= "001";
        control_mux_r2_next <= "01";
        control_mux_r3_next <= '1';
        state_next <= t3;
        
   when t3 =>
        control_mux1_next <= '0';
        control_mux2_next <= "0011";
        control_mux3_next <= '1';
        control_mux4_next <= "010";
        state_next <= t4;
        
    when t4 =>
        control_mux1_next <= '1';
        control_mux2_next <= "0100";
        control_mux3_next <= '0';
        control_mux4_next <= "011";
        flag_sv1_next <= '1';
        state_next <= t5;    
        
    when t5 =>
        control_mux1_next <= '0';
        control_mux2_next <= "0101";
        control_mux3_next <= '1';
        control_mux4_next <= "010";
        flag_sv1_next <= '0';
        state_next <= t6;
        
    when t6 =>
        control_mux1_next <= '1';
        control_mux2_next <= "0110";
        control_mux3_next <= '0';
        control_mux4_next <= "100";
        flag_sv2_next <= '1';
        state_next <= t7;
        
    when t7 =>
        control_mux1_next <= '0';
        control_mux2_next <= "0111";
        control_mux3_next <= '1';
        control_mux4_next <= "010";
        flag_sv2_next <= '0';
        state_next <= t8;
        
    when t8 =>
        control_mux1_next <= '1';
        control_mux2_next <= "1000";
        control_mux_r1_next <= '0';
        control_mux_r2_next <= "10";
        flag_sv3_next <= '1';
        state_next <= t9;
        
    when t9 =>
        flag_sv3_next <= '0';
        control_mux3_next <= '0';
        control_mux4_next <= "101";
        control_mux_r2_next <= "01";
        state_next <= t10;
        
    when t10 =>
        flag_sv4_next <= '1';
        fin_next <= '1';
        state_next <= idle;

                   
 end case;
 end process;

control_mux1 <= control_mux1_next;
control_mux2 <= control_mux2_next;
control_mux3 <= control_mux3_next;
control_mux4 <= control_mux4_next;
control_mux_r1 <= control_mux_r1_next;
control_mux_r2 <= control_mux_r2_next;
control_mux_r3 <= control_mux_r3_next;
control_mux_r4 <= control_mux_r4_next;
flag_sv1 <= flag_sv1_next;
flag_sv2 <= flag_sv2_next;
flag_sv3 <= flag_sv3_next;
flag_sv4 <= flag_sv4_next;
fin <= fin_next;


end behavioral;
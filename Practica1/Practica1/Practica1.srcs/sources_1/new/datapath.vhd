LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_signed.all;

ENTITY datapath IS 
  PORT (
     reset, clk    : in std_logic;
     comandos      : in std_logic_vector(7 downto 0);
     entradas      : in std_logic_vector(23 downto 0);  --8 bits enteros y 16 fraccionarios
     control_mux1  : in std_logic;
     control_mux2  : in std_logic_vector(3 downto 0);
     control_mux3  : in std_logic;
     control_mux4  : in std_logic_vector(2 downto 0);
     control_mux_r1 : in std_logic;
     control_mux_r2 : in std_logic;
     control_mux_r3 : in std_logic;
     control_mux_r4 : in std_logic;
     flag_sv1       : in std_logic;
     flag_sv2       : in std_logic;
     flag_sv3       : in std_logic;
     flag_sv4       : in std_logic;
     salidas       : out std_logic_vector(23 downto 0);  
     flags         : out std_logic_vector(7 downto 0));
END datapath;

ARCHITECTURE behavior OF datapath IS
	CONSTANT b1 : std_logic_vector (23 downto 0) := "00000000" & "00000100" & "11000000"; -- = 0.018563 = "0000 0000. 0000 0100 1100 0000"
	CONSTANT b2 : std_logic_vector (23 downto 0) := "00000000" & "00010011" & "00000010";
	CONSTANT b3 : std_logic_vector (23 downto 0) := "00000000" & "00011100" & "10000011";
	CONSTANT b4 : std_logic_vector (23 downto 0) := "00000000" & "00010011" & "00000010";
	CONSTANT b5 : std_logic_vector (23 downto 0) := "00000000" & "00000100" & "11000000";
	--CONSTANT neg_a1 : std_logic_vector (23 downto 0) := 1;
	CONSTANT neg_a2 : std_logic_vector (23 downto 0) := "00000001" & "10010010" & "00000101";
	CONSTANT neg_a3 : std_logic_vector (23 downto 0) := "11111110" & "10111001" & "01110010";
	CONSTANT neg_a4 : std_logic_vector (23 downto 0) := "00000000" & "01111100" & "00000001";
	CONSTANT neg_a5 : std_logic_vector (23 downto 0) := "11111111" & "11101100" & "01111111"; -- negativo se extiende con 0
	
	SIGNAL sv1, sv2, sv3, sv4, salidas_reg, salidas_next : std_logic_vector(23 downto 0);
	SIGNAL sv1_comb, sv2_comb, sv3_comb, sv4_comb : std_logic_vector(23 downto 0);
	
	signal s_r_1, s_r_2, s_r_3, s_r_4, m1_out, m2_out, m3_out, m4_out, mult_out, sum_out, reg1, reg2, reg3, reg4 : std_logic_vector(23 downto 0);
	signal mult_out_aux : std_logic_vector(47 downto 0);
	
	
component mux2 port (
        a, b : in std_logic_vector(23 downto 0); 
        s : in std_logic;
        m2_out : out std_logic_vector(23 downto 0)
    );
end component;
	
component mux6 port (
        a, b, c, d, e, f : in std_logic_vector(23 downto 0); 
        s : in std_logic_vector(2 downto 0);
        m6_out : out std_logic_vector(23 downto 0) 
      ); 
end component;
    
component mux9 port (
        a, b, c, d, e, f, g, h, i : in std_logic_vector(23 downto 0); 
        s : in std_logic_vector(3 downto 0);
        m9_out : out std_logic_vector(23 downto 0) 
      );
end component;
	
component FF port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        a : in std_logic_vector(23 downto 0);
        b : out std_logic_vector(23 downto 0)
      );
end component;	

component RippleCarry_23to0 port (
        a : in STD_LOGIC_VECTOR (23 downto 0);
        b : in STD_LOGIC_VECTOR (23 downto 0);
        s : out STD_LOGIC_VECTOR (23 downto 0)

);
end component;

BEGIN 
	  -- generacion de registros
      Proc_seq : PROCESS (reset, clk)
      BEGIN
           IF reset='0' THEN
                sv1 <= (others => '0');    
                sv2 <= (others => '0'); 
                sv3 <= (others => '0'); 
                sv4 <= (others => '0');    -- (…)
           ELSIF (clk'event AND clk='1') THEN
             salidas_reg <= salidas_next;
             sv1 <= sv1_comb;   
             sv2 <= sv2_comb; 
             sv3 <= sv3_comb;   
             sv4 <= sv4_comb;
           END IF; 
      END PROCESS;
	  
	  flags <= (others => '0'); -- no hay flags en este caso
		
M1 : mux2 port map (
          a => s_r_4,
          b => s_r_3,
          s => control_mux1,
          m2_out => m1_out
      ); 
      
      		
M2 : mux9 port map (
        a => b1,
        b => b2,
        c => neg_a2,
        d => b3,
        e => neg_a3,
        f => b4,
        g => neg_a4,
        h => b5,
        i => neg_a5,
        s => control_mux2,
        m9_out => m2_out
    ); 

mult_out_aux <= m1_out * m2_out;
mult_out <= mult_out_aux(39 downto 16);   

    
M3 : mux2 port map (
        a => s_r_1,
        b => s_r_2,
        s => control_mux3,
        m2_out => m3_out
    );
    
M4 : mux6 port map (
        a => sv1,
        b => sv2,
        c => s_r_1,
        d => sv3,
        e => sv4,
        f => s_r_2,
        s => control_mux4,
        m6_out => m4_out
    );
 
FA : RippleCarry_23to0 port map (
        a => m3_out,
        b => m4_out,
        s => sum_out
    );
    
--sum_out <= m3_out + m4_out;

MR1 : mux2 port map (
        a => s_r_1,
        b => mult_out,
        s => control_mux_r1,
        m2_out => reg1
    );
    
MR2 : mux2 port map (
        a => sum_out,
        b => mult_out,
        s => control_mux_r2,
        m2_out => reg2
    );


MR3 : mux2 port map (
    a => sum_out,
    b => s_r_3,
    s => control_mux_r3,
    m2_out => reg3
    );
    
MR4 : mux2 port map (
    a => entradas,
    b => s_r_4,
    s => control_mux_r4,
    m2_out => reg4
    );

FF1 : FF port map (
    clk => clk,
    reset => reset,
    a => reg1,
    b => s_r_1
    );
	  
FF2 : FF port map (
    clk => clk,
    reset => reset,
    a => reg2,
    b => s_r_2
    );

FF3 : FF port map (
    clk => clk,
    reset => reset,
    a => reg3,
    b => s_r_3
    );
    
FF4 : FF port map (
    clk => clk,
    reset => reset,
    a => reg4,
    b => s_r_4
    );	


sv1_comb <= s_r_2 when flag_sv1 = '1' else sv1;
sv2_comb <= s_r_2 when flag_sv2 = '1' else sv2;
sv3_comb <= s_r_2 when flag_sv3 = '1' else sv3;
sv4_comb <= s_r_2 when flag_sv4 = '1' else sv4;

salidas_next <= sum_out when control_mux_r3 = '0' else salidas_reg;
salidas <= salidas_reg;   
  
END behavior;

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY top IS 
  PORT (
     reset, clk      : in std_logic;
     validacion      : in std_logic;
     data_in         : in std_logic_vector(23 downto 0); 
     ack_in          : out std_logic;
     ack_out         : in std_logic;
     data_out        : out std_logic_vector(23 downto 0);  
     valid_out       : out std_logic );
END top;


ARCHITECTURE behavior OF top IS

COMPONENT datapath IS 
  PORT (
     reset, clk    : in std_logic;
  comandos      : in std_logic_vector(7 downto 0);
  entradas      : in std_logic_vector(23 downto 0);  --8 bits enteros y 16 fraccionarios
  control_mux1  : in std_logic;
  control_mux2  : in std_logic_vector(3 downto 0);
  control_mux3  : in std_logic;
  control_mux4  : in std_logic_vector(2 downto 0);
  control_mux_r1 : in std_logic;
  control_mux_r2 : in std_logic_vector(1 downto 0);
  control_mux_r3 : in std_logic;
  control_mux_r4 : in std_logic;
  flag_sv1       : in std_logic;
  flag_sv2       : in std_logic;
  flag_sv3       : in std_logic;
  flag_sv4       : in std_logic;
  salidas       : out std_logic_vector(23 downto 0);  
  flags         : out std_logic_vector(7 downto 0));
END component;

COMPONENT control IS 
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
END component;

COMPONENT interfaz_entrada IS 
  PORT (
     reset           : in std_logic;
     validacion      : in std_logic;
     data_in         : in std_logic_vector(23 downto 0); 
     ack_in          : out std_logic;
     entradas        : out std_logic_vector(23 downto 0) ); 
END component;

COMPONENT interfaz_salida IS 
  PORT (
     reset           : in std_logic;
     fin             : in std_logic;
     salidas         : in std_logic_vector(23 downto 0);  
     ack_out         : in std_logic;
     data_out        : out std_logic_vector(23 downto 0);  
     valid_out       : out std_logic );
END component;


  SIGNAL entradas, salidas : std_logic_vector(23 downto 0);
  SIGNAL comandos, flags : std_logic_vector(7 downto 0);
  SIGNAL fin : std_logic;

    signal control_mux1_aux, control_mux3_aux, control_mux_r1_aux, control_mux_r3_aux, control_mux_r4_aux, flag_sv1_aux, flag_sv2_aux, flag_sv3_aux, flag_sv4_aux : std_logic;

    signal control_mux2_aux : std_logic_vector(3 downto 0);
    signal control_mux4_aux : std_logic_vector(2 downto 0);
    signal control_mux_r2_aux : std_logic_vector(1 downto 0);

  
BEGIN  


U1 : datapath 
     PORT MAP (
     reset => reset,
     clk => clk, 
     comandos => comandos, 
     entradas => entradas,
     control_mux1 => control_mux1_aux,
     control_mux2 => control_mux2_aux,
     control_mux3 => control_mux3_aux,
     control_mux4 => control_mux4_aux,
     control_mux_r1 => control_mux_r1_aux,
     control_mux_r2 => control_mux_r2_aux,
     control_mux_r3 => control_mux_r3_aux,
     control_mux_r4 => control_mux_r4_aux,
     flag_sv1 => flag_sv1_aux,
     flag_sv2 => flag_sv2_aux,     
     flag_sv3 => flag_sv3_aux,    
     flag_sv4 => flag_sv4_aux,  
     salidas => salidas, 
     flags => flags);

U2 : control 
     PORT MAP (
     reset => reset, 
     clk => clk, 
     validacion => validacion, 
     comandos => comandos, 
     control_mux1 => control_mux1_aux,
     control_mux2 => control_mux2_aux,
     control_mux3 => control_mux3_aux,
     control_mux4 => control_mux4_aux,
     control_mux_r1 => control_mux_r1_aux,
     control_mux_r2 => control_mux_r2_aux,
     control_mux_r3 => control_mux_r3_aux,
     control_mux_r4 => control_mux_r4_aux,
     flag_sv1 => flag_sv1_aux,
     flag_sv2 => flag_sv2_aux,     
     flag_sv3 => flag_sv3_aux,    
     flag_sv4 => flag_sv4_aux,  
     flags => flags, 
     fin => fin );

U3 : interfaz_entrada  
     PORT MAP (
     reset => reset, 
     validacion => validacion, 
     ack_in => ack_in,
     data_in => data_in, 
     entradas => entradas );

U4 : interfaz_salida  
     PORT MAP (reset => reset, 
     fin => fin, 
     salidas => salidas, 
     ack_out => ack_out,
     data_out => data_out, 
     valid_out => valid_out );

	 
END behavior;

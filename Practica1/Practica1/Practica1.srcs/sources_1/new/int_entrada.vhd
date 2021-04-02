LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY interfaz_entrada IS 
  PORT (
     reset, clk    : in std_logic;
     validacion    : in std_logic;
     data_in       : in std_logic_vector(23 downto 0); 
     ack_in        : out std_logic;
     entradas      : out std_logic_vector(23 downto 0) ); 
END interfaz_entrada;

ARCHITECTURE behavior OF interfaz_entrada IS



BEGIN  
      Proc_Captura : PROCESS (reset, clk)
      BEGIN
           IF reset='0' THEN
                entradas <= (others => '0');
           ELSIF (clk'event AND clk='1') THEN
                --entradas <= data_in;
                IF validacion = '1' THEN  
                    entradas <= data_in;
                    ack_in <= '1';
                    -- generar se�al ack_in
                END IF;
           END IF; 
      END PROCESS;
END behavior;

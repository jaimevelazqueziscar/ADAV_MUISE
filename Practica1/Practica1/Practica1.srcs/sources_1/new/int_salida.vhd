LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY interfaz_salida IS 
  PORT (
     reset, clk      : in std_logic;
     fin             : in std_logic;
     salidas         : in std_logic_vector(23 downto 0);  
     ack_out         : in std_logic;
     data_out        : out std_logic_vector(23 downto 0);  
     valid_out       : out std_logic );
END interfaz_salida;

ARCHITECTURE behavior OF interfaz_salida IS

type state_type is (idle, send_data, stop);
    signal state_reg, state_next : state_type;

BEGIN  
      Proc_Entrega : PROCESS (reset, clk)
           BEGIN
           IF reset='0' THEN
                data_out <= (others => '0');    
                valid_out <= '0';
           ELSIF (clk'event AND clk='1') THEN
                IF fin = '1' THEN  
                     data_out <= salidas;
                     valid_out <= '1';
				ELSE
					 valid_out <= '0';
                END IF;
           END IF; 
      END PROCESS;
END behavior;

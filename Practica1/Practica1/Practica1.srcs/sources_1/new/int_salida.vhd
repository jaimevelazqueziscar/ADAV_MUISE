LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY interfaz_salida IS 
  PORT (
     reset           : in std_logic;
     fin             : in std_logic;
     salidas         : in std_logic_vector(23 downto 0);  
     ack_out         : in std_logic;
     data_out        : out std_logic_vector(23 downto 0);  
     valid_out       : out std_logic );
END interfaz_salida;

ARCHITECTURE behavior OF interfaz_salida IS

BEGIN  
      Proc_Entrega : PROCESS (reset, fin, ack_out)
           BEGIN
           IF reset='0' THEN
                data_out <= (others => '0');    
                valid_out <= '0';
           elsif fin = '1' THEN  
                data_out <= salidas;
                valid_out <= '1';
		   end if;
		   IF reset='0' THEN
                data_out <= (others => '0');    
                valid_out <= '0';
		   elsif ack_out = '1' then
                valid_out <= '0';
           END IF; 
      END PROCESS;
END behavior;

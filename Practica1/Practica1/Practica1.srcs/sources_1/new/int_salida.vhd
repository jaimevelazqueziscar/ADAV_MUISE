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
     valid_out       : out std_logic;
     fin_out         : out std_logic );
END interfaz_salida;

ARCHITECTURE behavior OF interfaz_salida IS

signal last_salidas : std_logic_vector(23 downto 0);
signal last_valid_out : std_logic;

BEGIN  
  Proc_Entrega : PROCESS (reset, fin, last_salidas, salidas, ack_out, last_valid_out)
       BEGIN
       IF reset='0' THEN
            data_out <= (others => '0');    
            last_valid_out <= '0';
            valid_out <= '0';
            last_salidas <= (others => '0');
       elsif (fin = '1' and last_salidas /= "111111111111111111111011" and salidas /= "000000000000000000000000") THEN  
            data_out <= salidas;
            valid_out <= '1';
            last_valid_out <= '1';
            last_salidas <= salidas;
       else
            valid_out <= last_valid_out;
            last_valid_out <= '0';
            last_salidas <= salidas;
            data_out <= salidas;
       end if;
       if ack_out = '1' then
            valid_out <= '0';
       else
            valid_out <= last_valid_out;     
       end if;
  end process;
      
fin_out <= fin;

END behavior;

library STD;
use STD.textio.all;                     -- basic I/O
library IEEE;
use IEEE.std_logic_1164.all;            -- basic logic types
use IEEE.std_logic_textio.all;          -- I/O for logic types

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

ENTITY tb_top IS 
END tb_top;


ARCHITECTURE behavior OF tb_top IS

COMPONENT top IS 
  PORT (
     reset, clk      : in std_logic;
       validacion      : in std_logic;
       data_in         : in std_logic_vector(23 downto 0); 
       ack_in          : out std_logic;
       ack_out         : in std_logic;
       data_out        : out std_logic_vector(23 downto 0);  
       valid_out       : out std_logic;
       fin             : out std_logic );
END component;

  SIGNAL reset, clk : std_logic;
  SIGNAL data_in, data_out : std_logic_vector(23 downto 0);
  SIGNAL validacion, fin : std_logic;
  SIGNAL valid_out, ack_out, ack_in : std_logic;
  
  CONSTANT period : time := 10 ns;

  FILE f_out : TEXT IS OUT "C:\Users\jaymy\ADAV_MUISE\f_out1.txt";    -- ES PREFERIBLE PONER LA DIRECCCION COMPLETA!!
  
BEGIN  
      -- RESET
      Proc_reset : PROCESS 
	  BEGIN
           reset <= '0', '1' after 302 ns; 
		   wait;
      END PROCESS;

      -- UNIT UNDER TEST
      UUT : top 
      PORT MAP (
      reset => reset, 
      clk => clk, 
      validacion => validacion, 
      data_in => data_in,
      ack_in => ack_in,
      ack_out => ack_out, 
      data_out => data_out, 
      valid_out => valid_out,
      fin => fin );
	 
	 
	  -- CLK
      Proc_clk : PROCESS 
	  BEGIN
           clk <= '0', '1' after period/2; 
		   wait for period;
      END PROCESS;
	  
	  
	  -- INPUT DATA
      Proc_gen_data : PROCESS 
	  BEGIN
	       data_in <= (others => '0');   validacion <= '0';
		   wait for 100*period;
	 
	       data_in <= "00000001" & "00000000" & "00000000";     validacion <= '1';
		   wait for 10*period;
		   if ack_in = '1' then
		      data_in <= (others => '0');
              validacion <= '0';
           end if;
           wait;
      END PROCESS;
	 

	  -- OUTPUT DATA
      Proc_save_data : PROCESS (fin, valid_out)
	    variable v_data_out : bit_vector(23 downto 0);
	    variable v_linea : line;
	  BEGIN
   	       if (valid_out'event and valid_out='1') then
                ack_out <= '1' after 20 ns;
                v_data_out := To_BitVector(data_out);
                WRITE(v_linea, v_data_out);
                WRITELINE(f_out, v_linea);
		   elsif (valid_out'event and valid_out='0') then
		      if valid_out = '0' then
			        ack_out <= '0' after 2 ns;
		       end if;
		   end if;
      END PROCESS;

		 
END behavior;

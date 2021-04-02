----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2019 11:53:52
-- Design Name: 
-- Module Name: mux5 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux3 is
Port (  a, b, c : in std_logic_vector(23 downto 0); 
        s : in std_logic_vector(1 downto 0);
        m3_out : out std_logic_vector(23 downto 0) 
      ); 
end mux3;

architecture Behavioral of mux3 is

begin

m3_out <=   a when (s = "00") else
            b when (s = "01") else
            c;


end Behavioral;

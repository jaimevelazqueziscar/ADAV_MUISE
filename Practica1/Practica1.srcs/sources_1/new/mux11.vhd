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

entity mux11 is
Port (  a, b, c, d, e, f, g, h, i, j, k : in std_logic_vector(23 downto 0); 
        s : in std_logic_vector(3 downto 0);
        m11_out : out std_logic_vector(23 downto 0) 
      ); 
end mux11;

architecture Behavioral of mux11 is

begin

m11_out <=   a when (s = "0000") else
            b when (s = "0001") else
            c when (s = "0010") else
            d when (s = "0011") else
            e when (s = "0100") else
            f when (s = "0101") else
            g when (s = "0110") else
            h when (s = "0111") else
            i when (s = "1000") else
            j when (s = "1001") else
            f;


end Behavioral;

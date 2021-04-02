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

entity mux6 is
Port (  a, b, c, d, e, f : in std_logic_vector(23 downto 0); 
        s : in std_logic_vector(2 downto 0);
        m6_out : out std_logic_vector(23 downto 0) 
      ); 
end mux6;

architecture Behavioral of mux6 is

begin

m6_out <=   a when (s = "000") else
            b when (s = "001") else
            c when (s = "010") else
            d when (s = "011") else
            e when (s = "100") else
            f;


end Behavioral;

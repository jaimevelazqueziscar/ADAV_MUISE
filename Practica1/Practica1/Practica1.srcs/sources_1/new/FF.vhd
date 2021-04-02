----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.12.2019 12:32:02
-- Design Name: 
-- Module Name: FF_1_2 - Behavioral
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

entity FF is
    Port (  clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            a : in std_logic_vector(23 downto 0);
            b : out std_logic_vector(23 downto 0));
end FF;

architecture Behavioral of FF is

begin

process(clk, reset)
begin
    if (reset = '0') then
        b <= (others => '0');
    elsif(clk'event and clk='1') then
        b <= a;
    end if;
end process;

end Behavioral;

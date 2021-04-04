----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2021 17:32:30
-- Design Name: 
-- Module Name: RippleCarry_23to0 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RippleCarry_23to0 is
    Port ( a : in STD_LOGIC_VECTOR (23 downto 0);
           b : in STD_LOGIC_VECTOR (23 downto 0);
           s : out STD_LOGIC_VECTOR (23 downto 0));
end RippleCarry_23to0;

architecture Behavioral of RippleCarry_23to0 is

signal c01, c12, c23, c34, c45, c56, c67, c78, c89, c910, c1011, c1112, c1213, c1314, c1415, c1516, c1617, c1718, c1819, c1920, c2021, c2122, c2223, c_out : std_logic;


component FA port (
       A : in STD_LOGIC;
       B : in STD_LOGIC;
       Cin : in STD_LOGIC;
       S : out STD_LOGIC;
       Cout : out STD_LOGIC);
end component;

begin

FA0 : FA port map (
          A => a(0),
          B => b(0),
          Cin => '0',
          S => s(0),
          Cout => c01
      );
      
FA1 : FA port map (
        A => a(1),
        B => b(1),
        Cin => c01,
        S => s(1),
        Cout => c12
    );
    
FA2 : FA port map (
              A => a(2),
              B => b(2),
              Cin => c12,
              S => s(2),
              Cout => c23
          );
          
FA3 : FA port map (
                    A => a(3),
                    B => b(3),
                    Cin => c23,
                    S => s(3),
                    Cout => c34
                );
                
FA4 : FA port map (
                          A => a(4),
                          B => b(4),
                          Cin => c34,
                          S => s(4),
                          Cout => c45
                      );
                      
FA5 : FA port map (
                                A => a(5),
                                B => b(5),
                                Cin => c45,
                                S => s(5),
                                Cout => c56
                            );
                            
FA6 : FA port map (
      A => a(6),
      B => b(6),
      Cin => c56,
      S => s(6),
      Cout => c67
  );
  
FA7 : FA port map (
            A => a(7),
            B => b(7),
            Cin => c67,
            S => s(7),
            Cout => c78
        );
        
FA8 : FA port map (
                  A => a(8),
                  B => b(8),
                  Cin => c78,
                  S => s(8),
                  Cout => c89
              );
              
FA9 : FA port map (
                        A => a(9),
                        B => b(9),
                        Cin => c89,
                        S => s(9),
                        Cout => c910
                    );
                    
FA10 : FA port map (
                              A => a(10),
                              B => b(10),
                              Cin => c910,
                              S => s(10),
                              Cout => c1011
                          );
                          
FA11 : FA port map (
                                    A => a(11),
                                    B => b(11),
                                    Cin => c1011,
                                    S => s(11),
                                    Cout => c1112
                                );
                                
FA12 : FA port map (
                                          A => a(12),
                                          B => b(12),
                                          Cin => c1112,
                                          S => s(12),
                                          Cout => c1213
                                      );
                                      
FA13 : FA port map (
    A => a(13),
    B => b(13),
    Cin => c1213,
    S => s(13),
    Cout => c1314
);

FA14 : FA port map (
          A => a(14),
          B => b(14),
          Cin => c1314,
          S => s(14),
          Cout => c1415
      );
      
FA15 : FA port map (
                A => a(15),
                B => b(15),
                Cin => c1415,
                S => s(15),
                Cout => c1516
            );
            
FA16 : FA port map (
                      A => a(16),
                      B => b(16),
                      Cin => c1516,
                      S => s(16),
                      Cout => c1617
                  );
                  
FA17 : FA port map (
                            A => a(17),
                            B => b(17),
                            Cin => c1617,
                            S => s(17),
                            Cout => c1718
                        );
                        
FA18 : FA port map (
                                  A => a(18),
                                  B => b(18),
                                  Cin => c1718,
                                  S => s(18),
                                  Cout => c1819
                              );
                              
FA19 : FA port map (
                                        A => a(19),
                                        B => b(19),
                                        Cin => c1819,
                                        S => s(19),
                                        Cout => c1920
                                    );
                                    
FA20 : FA port map (
      A => a(20),
      B => b(20),
      Cin => c1920,
      S => s(20),
      Cout => c2021
  );
  
FA21 : FA port map (
            A => a(21),
            B => b(21),
            Cin => c2021,
            S => s(21),
            Cout => c2122
        );
        
FA22 : FA port map (
                  A => a(22),
                  B => b(22),
                  Cin => c2122,
                  S => s(22),
                  Cout => c2223
              );
              
FA23 : FA port map (
                        A => a(23),
                        B => b(23),
                        Cin => c2223,
                        S => s(23),
                        Cout => c_out
                    );
           
    

end Behavioral;

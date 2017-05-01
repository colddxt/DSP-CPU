----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2017 12:53:17 PM
-- Design Name: 
-- Module Name: Register_File - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register_File is
            Port (Clock        : in std_logic;
                  Sel_Wr       : in std_logic;
                  Reg_Sel_A    : in std_logic_vector(4 downto 0);
                  Reg_Sel_B    : in std_logic_vector(4 downto 0); 
                  Reg_Sel_C    : in std_logic_vector(4 downto 0);
                  Reg_Sel_Wr   : in std_logic_vector(4 downto 0);
                  Reg_A        : out std_logic_vector(31 downto 0);
                  Reg_B        : out std_logic_vector(31 downto 0);
                  Reg_C        : out std_logic_vector(31 downto 0);
                  Reg_Wr       : in std_logic_vector(31 downto 0));
end Register_File;

architecture Behavioral of Register_File is
type Reg_Word is Array(0 to 15) of std_logic_vector(31 downto 0);
signal RegA, RegB, RegC : std_logic_vector(31 downto 0);
signal Reg_Wd : Reg_Word := (

        "00000000000000000000000000000000", 
        "00000000000000000000000000000001", 
        "00000000000000000000000000000001",
        "00000000000000000000000000000000",
        "00000000000000000000000000001011",
        "00000000000000000000000000000011",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",  --7
        "00000000000000000000000000000000",
        "00000000000000000000000000000011",
        "00000000000000000000000000000011",
        "00000000000000000000000000000101",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000010",
        "00000000000000000000000000000010");
begin
REGISTER_FILEs: PROCESS (Clock)
begin
    if rising_edge(Clock) then
        case Reg_Sel_A is
            when "00000" =>
                Reg_A <= Reg_wd(0);
            when "00001" =>
                Reg_A <= Reg_wd(1);
            when "00010" =>
                Reg_A <= Reg_wd(2);
            when "00011" =>
                Reg_A <= Reg_wd(3);
            when "00100" =>
                Reg_A <= Reg_wd(4);
            when "00101" =>
                Reg_A <= Reg_wd(5);
            when "00110" =>
                Reg_A <= Reg_wd(6);
            when "00111" =>
                Reg_A <= Reg_wd(7);
            when "01000" =>
                Reg_A <= Reg_wd(8);
            when "01001" =>
                Reg_A <= Reg_wd(9);
            when "01010" =>
                Reg_A <= Reg_wd(10);
            when "01011" =>
                Reg_A <= Reg_wd(11);
            when "01100" =>
                Reg_A <= Reg_wd(12); 
            when "01101" =>
                Reg_A <= Reg_wd(13);
            when "01110" =>
                Reg_A <= Reg_wd(14);
            when "01111" =>
                Reg_A <= Reg_wd(15);
            when others =>
                Reg_A <= x"00000000";
            
         end case;
         case Reg_Sel_B is
             when "00000" =>
                 Reg_B <= Reg_wd(0);
             when "00001" =>
                 Reg_B <= Reg_wd(1);
             when "00010" =>
                 Reg_B <= Reg_wd(2);
             when "00011" =>
                 Reg_B <= Reg_wd(3);
             when "00100" =>
                 Reg_B <= Reg_wd(4);
             when "00101" =>
                 Reg_B <= Reg_wd(5);
             when "00110" =>
                 Reg_B <= Reg_wd(6);
             when "00111" =>
                 Reg_B <= Reg_wd(7);
             when "01000" =>
                 Reg_B <= Reg_wd(8);
             when "01001" =>
                 Reg_B <= Reg_wd(9);
             when "01010" =>
                 Reg_B <= Reg_wd(10);
             when "01011" =>
                 Reg_B <= Reg_wd(11);
             when "01100" =>
                 Reg_B <= Reg_wd(12); 
             when "01101" =>
                 Reg_B <= Reg_wd(13);
             when "01110" =>
                 Reg_B <= Reg_wd(14);
             when "01111" =>
                 Reg_B <= Reg_wd(15);
            when others =>
                 Reg_B <= x"00000000";
            end case;
         case Reg_Sel_C is
              when "00000" =>
                  Reg_C <= Reg_wd(0);
              when "00001" =>
                  Reg_C <= Reg_wd(1);
              when "00010" =>
                  Reg_C <= Reg_wd(2);
              when "00011" =>
                  Reg_C <= Reg_wd(3);
              when "00100" =>
                  Reg_C <= Reg_wd(4);
              when "00101" =>
                  Reg_C <= Reg_wd(5);
              when "00110" =>
                  Reg_C <= Reg_wd(6);
              when "00111" =>
                  Reg_C <= Reg_wd(7);
              when "01000" =>
                  Reg_C <= Reg_wd(8);
              when "01001" =>
                  Reg_C <= Reg_wd(9);
              when "01010" =>
                  Reg_C <= Reg_wd(10);
              when "01011" =>
                  Reg_C <= Reg_wd(11);
              when "01100" =>
                  Reg_C <= Reg_wd(12); 
              when "01101" =>
                  Reg_C <= Reg_wd(13);
              when "01110" =>
                  Reg_C <= Reg_wd(14);
              when "01111" =>
                  Reg_C <= Reg_wd(15);
            when others =>
                  Reg_C <= x"00000000";          
           end case;
       
       if (Sel_Wr = '1') then
         case Reg_Sel_Wr is
            when "00000" =>
                Reg_wd(0) <= Reg_Wr;
            when "00001" =>
                Reg_wd(1) <= Reg_Wr;
            when "00010" =>
                Reg_wd(2) <= Reg_Wr;
            when "00011" =>
                Reg_wd(3) <= Reg_Wr;
            when "00100" =>
                Reg_wd(4) <= Reg_Wr;
            when "00101" =>
                Reg_wd(5) <= Reg_Wr;
            when "00110" =>
                Reg_wd(6) <= Reg_Wr;
            when "00111" =>
                Reg_wd(7) <= Reg_Wr;
            when "01000" =>
                Reg_wd(8) <= Reg_Wr;
            when "01001" =>
                Reg_wd(9) <= Reg_Wr;
            when "01010" =>
                Reg_wd(10) <= Reg_Wr;
            when "01011" =>
                Reg_wd(11) <= Reg_Wr;
            when "01100" =>
                Reg_wd(12) <= Reg_Wr; 
            when "01101" =>
                Reg_wd(13) <= Reg_Wr;
            when "01110" =>
                Reg_wd(14) <= Reg_Wr;
            when "01111" =>
                Reg_wd(15) <= Reg_Wr;
            when others =>
                Reg_wd <= Reg_Wd;
         end case;
      end if;      
    end if;
end process Register_Files;
end Behavioral;

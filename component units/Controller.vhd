----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2017 03:59:31 PM
-- Design Name: 
-- Module Name: Controller - Behavioral
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


entity Controller is
        Port (clk : in STD_LOGIC;
              opcode : in STD_LOGIC_VECTOR (5 downto 0);
              control_in : out STD_LOGIC_VECTOR (2 downto 0);
              adder_en : out STD_LOGIC;
              wb_en : out STD_LOGIC;
              inmode : out STD_LOGIC_VECTOR (4 downto 0);
              opmode : out STD_LOGIC_VECTOR (8 downto 0);
              alumode : out STD_LOGIC_VECTOR (3 downto 0);
              pc_control : out STD_LOGIC_VECTOR (1 downto 0));
end Controller;

architecture Behavioral of Controller is
begin
process(clk)
begin
if (clk'event and clk = '1') then
 case opcode is
 when "000000" => control_in <= "000"; --nop
                 adder_en <= '0';
                 wb_en <= '0';
                 inmode <= "00000";
                 opmode <= "000000000";
                 alumode <= "0000";
                 pc_control <= "00";

 when "000001" => control_in <= "001";  --add
                 adder_en <= '0';
                 wb_en <= '1';
                 inmode <= "00000";
                 opmode <= "000110011";
                 alumode <= "0000";
                 pc_control <= "00";

 when "000010" => control_in <= "001";  --sub
                 adder_en <= '0';
                 wb_en <= '1';
                 inmode <= "00000";
                 opmode <= "000110011";
                 alumode <= "0011";
                 pc_control <= "00";

 when "000011" => control_in <= "010";  --mul
                 adder_en <= '0';
                 wb_en <= '1';
                 inmode <= "10001";
                 opmode <= "000000101";
                 alumode <= "0000";
                 pc_control <= "00";

 when "000100" => control_in <= "011";  --madd
                 adder_en <= '0';
                 wb_en <= '1';
                 inmode <= "10001";
                 opmode <= "000110101";
                 alumode <= "0000";
                 pc_control <= "00";

 when "000101" => control_in <= "100";  --ld
                 adder_en <= '1';
                 wb_en <= '1';
                 inmode <= "00000";
                 opmode <= "000000000";
                 alumode <= "0000";
                 pc_control <= "00";

 when "000110" => control_in <= "101";  --sw
                 adder_en <= '1';
                 wb_en <= '0';
                 inmode <= "00000";
                 opmode <= "000000000";
                 alumode <= "0000";
                 pc_control <= "00";

 when "000111" => control_in <= "001";  --beq
                 adder_en <= '0';
                 wb_en <= '0';
                 inmode <= "00000";
                 opmode <= "000110011";
                 alumode <= "0011";
                 pc_control <= "01";

 when "001000" => control_in <= "000";  --j
                 adder_en <= '0';
                 wb_en <= '0';
                 inmode <= "00000";
                 opmode <= "000000000";
                 alumode <= "0000";
                 pc_control <= "10";

 when others => control_in <= "000";  --others
                adder_en <= '0';
                wb_en <= '0';
                inmode <= "00000";
                opmode <= "000000000";
                alumode <= "0000";
                pc_control <= "00";

 end case;
end if;
end process;
end Behavioral;

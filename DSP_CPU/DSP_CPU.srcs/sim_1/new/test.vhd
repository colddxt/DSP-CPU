----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/18/2017 02:25:21 PM
-- Design Name: 
-- Module Name: test - Behavioral
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

entity test is
--  Port ( );
end test;

architecture Behavioral of test is
  component DSP_CPU
  Port (Clock  : in std_logic;
              Data_out: out std_logic_vector(31 downto 0);
        --      oreg_A,oreg_B,oreg_C,oinstruction: out std_logic_vector(31 downto 0);
         --     o_opmode: out std_logic_vector(5 downto 0);
              oWrite, oTemp_Mem_Data_Out, oDSP_result, oreg_A,oreg_B,oreg_C,oinstruction: out std_logic_vector(31 downto 0);
                          o_opmode: out std_logic_vector(8 downto 0);
                          o_Map_Out_A :out std_logic_vector(29 downto 0);
                          o_Map_Out_B : out std_logic_vector(17 downto 0);
                          o_Map_Out_C : out std_logic_vector(47 downto 0) ;
                          o_Adder_en_Final: out std_logic;
                          oPC_Control_Final: out std_logic_vector(1 downto 0));
 end component;
 
 signal Clock  : std_logic;
 signal Data_out: std_logic_vector(31 downto 0):= (others=>'0');
 signal oWrite, oTemp_Mem_Data_Out, oDSP_result, oreg_A,oreg_B,oreg_C,oinstruction:std_logic_vector(31 downto 0):= (others=>'0');
 signal o_opmode:std_logic_vector(8 downto 0):= (others=>'0');
 signal o_Map_Out_A :std_logic_vector(29 downto 0):= (others=>'0');
 signal o_Map_Out_B :std_logic_vector(17 downto 0):= (others=>'0');
 signal o_Map_Out_C : std_logic_vector(47 downto 0) := (others=>'0');
 signal o_Adder_en_Final: std_logic;
 signal oPC_Control_Final: std_logic_vector(1 downto 0):= (others=>'0');
 constant clk_period : time := 10 ns;
begin
 delayprocess:process
  begin
  wait for 1000 ns;
  end process;
  clk_process :process
  begin
    clock <= '1';
    wait for clk_period/2;
    clock <='0';
    wait for clk_period/2;
  end process;
  
uu: DSP_CPU port map(
  Clock=>Clock,
  Data_out=>Data_out,
  oWrite=>oWrite,
  oTemp_Mem_Data_Out=>oTemp_Mem_Data_Out,
  oDSP_result=>oDSP_result, 
  oreg_A=>oreg_A,
  oreg_B=>oreg_B,
  oreg_C=>oreg_C,
  oinstruction=>oinstruction,
  o_opmode=>o_opmode,
  o_Map_Out_A=>o_Map_Out_A,
  o_Map_Out_B=>o_Map_Out_B,
  o_Map_Out_C=>o_Map_Out_C,
  o_Adder_en_Final=>o_Adder_en_Final,
  oPC_Control_Final=>oPC_Control_Final);
end Behavioral;

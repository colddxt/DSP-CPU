----------------------------------------------------------------------------------
-- Company: University of Pittsburg / SOC Course project
-- Engineer: Daud Emon, Xingtian, Wenyu, Collins
--- Create Date: 04/17/2017
-- Design Name: 
-- Module Name: MUX_32 - Behavioral
-- Project Name: MIPS DSP CPU
-- Target Devices: Virtex ultrascale (xcvu3p-ffvc1517-3-e-EVAL)

---------------Block Function----------
--The PC_Adder increases the PC counter by oneat eac clock-cycle.
-------------------------------------
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity pc_adder is
    Port (
           pc_adderin : in STD_LOGIC_VECTOR (5 downto 0);
           pc_adderout : out STD_LOGIC_VECTOR (5 downto 0));
end pc_adder;

architecture Behavioral of pc_adder is
signal address: std_logic_vector(5 downto 0):= "000000";
begin
out1 :process(address)
begin 
pc_adderout <= address;
end process;

 in1 :process(pc_adderin)
  begin
      address <=  std_logic_vector(unsigned(pc_adderin) + 1);
  end process;
end Behavioral;

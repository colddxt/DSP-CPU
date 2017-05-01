
----------------------------------------------------------------------------------
-- Company: University of Pittsburg / SOC Course project
-- Engineer: Daud Emon, Xingtian, Wenyu, Collins
--- Create Date: 04/17/2017
-- Design Name: 
-- Module Name: MUX_32 - Behavioral
-- Project Name: MIPS DSP CPU
-- Target Devices: Virtex ultrascale (xcvu3p-ffvc1517-3-e-EVAL)

---------------Block Function----------
-- The program counter points to the next instruction. Its output is incremented 
-- through the PC_adder until the last instruction is read in the instruction memory.
-------------------------------------
 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity pc is
    Port ( clk : in STD_LOGIC;
           address_in : in STD_LOGIC_VECTOR (5 downto 0);
           address_out : out STD_LOGIC_VECTOR (5 downto 0));
end pc;

architecture Behavioral of pc is
	signal address: std_logic_vector(5 downto 0):= "000000";
begin
address_out <= address;
	process(clk)
    begin
    if (clk='1' and clk'event) then
    address <= address_in;   
    end if;
end process;
end Behavioral;

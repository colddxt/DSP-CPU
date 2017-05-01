----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2017 12:46:29 PM
-- Design Name: 
-- Module Name: MUX_32 - Behavioral
-- Project Name: MIPS DSP CPU
-- Target Devices: Virtex ultrascale (xcvu3p-ffvc1517-3-e-EVAL)
---------------Function----------
-- This multiplexer selects either the output from the DSP_Block, DSP_Result, or the output from the data memory
-- Mem_Data_out. The select signal is the adder_en signal from the decoder delayed for a specific amount of 
-- clock-cycle for the DSP_result and the Mem_Data_Out signals to be ready for assertion.

-- 
----------------------------------------------------------------------------------
library IEEE;
--library UNISIM;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
--use work.MIPS_DSP_TYPES.all;
--use UNISIM.VComponents.all;
-------- Entity Declaration ----------
entity MUX_32 is
      Port (A, B : in std_logic_vector(31 downto 0);
            C    : out std_logic_vector(31 downto 0);
            Set  : in std_logic);
end MUX_32;

architecture Behavioral of MUX_32 is

begin
    C <= A when (Set='0') else B;
end Behavioral;


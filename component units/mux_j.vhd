----------------------------------------------------------------------------------
-- Company: University of Pittsburg / SOC Course project
-- Engineer: Daud Emon, Xingtian, Wenyu, Collins
--- Create Date: 04/17/2017
-- Design Name: 
-- Module Name: MUX_32 - Behavioral
-- Project Name: MIPS DSP CPU
-- Target Devices: Virtex ultrascale (xcvu3p-ffvc1517-3-e-EVAL)

---------------Block Function----------
-- The MUX_J generates multiplexer select signal for the jump and branch operations. This component compares 
				-- the DSP_control signal, which is a carry_out bit from the DSP to the PC_Control from the decoder. The output
				-- is the jump address select signal. The PC_Control signal is delayed until the DSP_Control signal from the DSP
				-- is ready.
		
					-- Input -- PC_Control -- 2 bit - from decoder
					-- Input -- DSP_Control --1-bit -- from the DSP_Block
					-- Input -- Clock  -- 1-bit
					-- Output -- jadr_en --- 1-bit

-------------------------------------
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

entity mux_j is
    Port ( pc_control : in STD_LOGIC_VECTOR (1 downto 0);
           dsp_control : in STD_LOGIC;
           jadr_en : out STD_LOGIC);
end mux_j;

architecture Behavioral of mux_j is
begin
      jadr_en <= '1' when ((pc_control = "01" and dsp_control ='1') or pc_control = "10") else '0';
end Behavioral;

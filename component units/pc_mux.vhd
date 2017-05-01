----------------------------------------------------------------------------------

-- Company: University of Pittsburg / SOC Course project
-- Engineer: Daud Emon, Xingtian, Wenyu, Collins
--- Create Date: 04/17/2017
-- Design Name: 
-- Module Name: MUX_32 - Behavioral
-- Project Name: MIPS DSP CPU
-- Target Devices: Virtex ultrascale (xcvu3p-ffvc1517-3-e-EVAL)

---------------Block Function----------
				-- The PC_Mux is a multiplexer that selects the #imm value (intr) from the last 6-bits from the instruction, if 
				-- the jadr-en is 1, or selects the PC_addressout from the PC_adder if the jadr_en is '0'.
										
					-- Input -- PC_addressout -- 6 bits -- from sum of PC adder
					-- Input -- J_addr -- 6 bits -- lower 6 bit from instruction -- instruction(5 downto 0)
					-- Output -- Address_in --- 6 bits to PC
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

entity pc_mux is
    Port ( pc_adr : in STD_LOGIC_VECTOR (5 downto 0);
           j_adr : in STD_LOGIC_VECTOR (5 downto 0);
           out_adr : out STD_LOGIC_VECTOR (5 downto 0);
           jadr_en : in STD_LOGIC);
end pc_mux;

architecture Behavioral of pc_mux is
begin
    out_adr <= pc_adr when (jadr_en='0') else j_adr;
end Behavioral;

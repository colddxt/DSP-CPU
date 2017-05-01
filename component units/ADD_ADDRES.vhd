----------------------------------------------------------------------------------
-- Company: University of Pittsburg / SOC Course project
-- Engineer: Daud Emon, Xingtian, Wenyu, Collins
--- Create Date: 04/17/2017
-- Design Name: 
-- Module Name: MUX_32 - Behavioral
-- Project Name: MIPS DSP CPU
-- Target Devices: Virtex ultrascale (xcvu3p-ffvc1517-3-e-EVAL)

---------------Block Function----------
 -- The main integration vhdl script that is run to generate the schematic 
			   	   -- diagram for the entire project. This file should be selected as the design 
				   -- file when simulating.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
----------------------------------------------------------------------------------
entity ADD_ADDRES is
      Port (ADD_En, Clk  : in std_logic;
            A, B         : in std_logic_vector(4 downto 0);
            Sum          : out std_logic_vector(4 downto 0));
end ADD_ADDRES;

architecture Behavioral of ADD_ADDRES is
begin
process(ADD_En, CLk)
begin 
       if rising_edge(Clk) then
    Case ADD_En is
        when '1' =>
            Sum <= STD_LOGIC_VECTOR(unsigned(A) + unsigned(B));

        when others => NULL;
     end case;
     end if;
end process;
end Behavioral;

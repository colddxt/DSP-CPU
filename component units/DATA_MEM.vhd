----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2017 04:43:44 PM
-- Design Name: 
-- Module Name: DATA_MEM - Behavioral
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

entity DATA_MEM is
        Port (write_data: in STD_LOGIC_VECTOR (31 downto 0);
              MemWrite, clk: in STD_LOGIC;
              address_R      : in std_logic_vector(4 downto 0);
              read_data: out STD_LOGIC_VECTOR (31 downto 0));

end DATA_MEM;

architecture Behavioral of DATA_MEM is
type mem_array is array(0 to 31 ) of STD_LOGIC_VECTOR (31 downto 0);
signal data_mem: mem_array := (
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000",
            X"00000000"); 
            
                  
begin
--read_data <= data_mem(to_integer(unsigned(address_R))) when MemRead = '1';
mem_process: process(address_R, write_data,clk)

begin 
	if rising_edge(clk)then
	   if (MemWrite = '0') then   --- em : WRITE  in data memory only when write back is disabled, that means we are not writing in register
			data_mem(to_integer(unsigned(address_R))) <= write_data;
		else
		    read_data <= data_mem(to_integer(unsigned(address_R)));
		end if;
	end if;
end process mem_process;
end behavioral; 
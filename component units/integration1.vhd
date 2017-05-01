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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity integration1 is
    Port ( clk : in STD_LOGIC;

           pc_control : in STD_LOGIC_VECTOR (1 downto 0);
           dsp_control : in STD_LOGIC;
           j_adr : in STD_LOGIC_VECTOR (5 downto 0);
           instruction : out STD_LOGIC_VECTOR (31 downto 0)

           );
end integration1;

architecture Behavioral of integration1 is


signal opcode : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal address1 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
signal address2 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
signal address3 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
signal jadr_en1 : STD_LOGIC;
component Instruction_memory
  Port ( 
           read_address : in STD_LOGIC_VECTOR (5 downto 0);
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
end component;
 
component pc
  Port ( clk : in STD_LOGIC;
         address_in : in STD_LOGIC_VECTOR (5 downto 0);
         address_out : out STD_LOGIC_VECTOR (5 downto 0));
end component;

component pc_adder 
    Port ( 
           pc_adderin : in STD_LOGIC_VECTOR (5 downto 0);
           pc_adderout : out STD_LOGIC_VECTOR (5 downto 0));
end component;

component pc_mux
  Port ( pc_adr : in STD_LOGIC_VECTOR (5 downto 0);
         j_adr : in STD_LOGIC_VECTOR (5 downto 0);
         out_adr : out STD_LOGIC_VECTOR (5 downto 0);
         jadr_en : in STD_LOGIC);
end component;

component mux_j is
    Port ( pc_control : in STD_LOGIC_VECTOR (1 downto 0);
           dsp_control : in STD_LOGIC;
           jadr_en : out STD_LOGIC);
end component;

begin
pc1: pc port map(
    clk => clk,
    address_out => address1,
    address_in => address3);

adder: pc_adder port map(
     pc_adderin => address1,
     pc_adderout => address2);
    
instruction1: instruction_memory port map(
  read_address => address1,
  data_out => instruction);
  
pc_mux1: pc_mux port map(
      pc_adr => address2,
      j_adr => j_adr,
      out_adr => address3,
      jadr_en => jadr_en1);
      
mux_j1: mux_j port map(
      pc_control => pc_control,
      dsp_control => dsp_control,
      jadr_en => jadr_en1);
      
end Behavioral;

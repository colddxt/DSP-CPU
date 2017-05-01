---------------------------------------------------------------------------------
-- Company: University of Pittsburg / SOC Course project
-- Engineer: Daud Emon, Xingtian, Wenyu, Collins
--- Create Date: 04/17/2017
-- Design Name: 
-- Module Name: MUX_32 - Behavioral
-- Project Name: MIPS DSP CPU
-- Target Devices: Virtex ultrascale (xcvu3p-ffvc1517-3-e-EVAL)

---------------Block Function----------
-- The DSP_Block performs the execution of the instruction (add, sub, mul, madd, etc...)
				-- This project explores the DSP48E2 on the Xilinx Zynq Ultrascale series. The DSP_block
				-- houses an ALU, and a multplier which is 18 x 27 bit long to perform arithmetic operations. 
				-- To fully implement a 32 32 multiplier, three DSP48E2 primitives can be cascaded together, 
				-- but this triples the resource requirement for the benefit of only a single instruction.
 				-- Hence, we restrict multiplication to 16 16 bits, producing a 32-bit result. A wider 
				-- multiplication than 16 bits would not be beneficial, since the result would have to be 
				-- truncated to fit the 32-bit data format.

					-- Input -- Ra -- 30 bits from in-map
					-- Input -- Rb -- 18 bits from in-map
					-- Input -- Rc -- 48 bits from in-map
					-- Input -- Clock  -- 1-bit
					-- Output-- DSP_Result 32-bits
					-- Output-- DSP_Control 1-bit
-------------------------------------
 

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

library UNISIM;
use UNISIM.vcomponents.all;

library STD;
use STD.TEXTIO.ALL;
-------------------------------End of Library Declaration--------------------------------------------------------------

entity DSP_Block is
   port(CLK : in std_logic;   
        A : in std_logic_vector( 29 downto 0);  --30 bit A
        B : in std_logic_vector( 17 downto 0);  --18 bit B
        C:  in std_logic_vector( 47 downto 0);  --48 bit C 
        almd: in std_logic_vector( 3 downto 0);
        opmd:  in std_logic_vector( 8 downto 0);
        inmd: in std_logic_vector( 4 downto 0);
        
        RESULT : out std_logic_vector(31 downto 0); --32 bit output 
        DSP_Control: out std_logic    --excess carryout  
        );
end DSP_Block;

architecture Behavioral of DSP_Block is
signal RESULT_OUT :  std_logic_vector(47 downto 0);
signal reg_C1 :  std_logic_vector(47 downto 0):=(others => '0');
signal reg_C2 :  std_logic_vector(47 downto 0):=(others => '0'); 
signal reg_opmd1 :  std_logic_vector(8 downto 0):=(others => '0'); 
signal reg_opmd2 :  std_logic_vector(8 downto 0):=(others => '0'); 
signal reg_almd1 :  std_logic_vector(3 downto 0):=(others => '0'); 
signal reg_almd2 :  std_logic_vector(3 downto 0):=(others => '0'); 
signal  RST : std_logic := '0';
constant Zero: std_logic := '0';
begin
RESULT <= RESULT_OUT(31 downto 0);
--DSP_Control <=Zero;

process (clk)
begin 
if(rising_edge(Clk)) then 
 -------c_input_pipeline---
  reg_C2 <= C;  ---before DSP reg C1 
  reg_opmd2 <= opmd; --before reg_opmode 
  reg_almd2 <= almd; --before reg_alumode 
end if;
end process;
    DSP48E_2: DSP48E2    
      generic map (
     -- AMULTSEL => "A",
      ACASCREG => 2,        --2
      AREG => 2,            --2
      ADREG => 0,                 -- no preadder
      BCASCREG => 2,        --2
      BREG => 2,            --2
      CREG => 1,            --1
      DREG => 0,
      MREG => 1,
      PREG => 1,   --1
      ALUMODEREG => 1, 
      Inmodereg => 0,
      Opmodereg =>1,
      CARRYINREG => 0, 
      CARRYINSELREG => 0,
      -----pattern detect----------
              PATTERN => X"000000000000",   -- see if A:B - C == 0 for beq operaion
      SEL_PATTERN => "PATTERN",
      USE_PATTERN_DETECT => "PATDET",
    --  SEL_Mask => "C",
      mask => X"000000000000", 
      --CREG => 0,        
      USE_MULT => "DYNAMIC" 
      ) 
   port map (
--         ACOUT => A_COUT_OUT,   
--         BCOUT => B_COUT_OUT,  

      ACOUT => open,
      BCOUT => open,
      CARRYCASCOUT => open, 
      CARRYOUT => open,
      MULTSIGNOUT => open, 
      OVERFLOW => open, 
     P => RESULT_OUT,          
      XOROUT => open,                 -- 8-bit output: XOR data
      PATTERNBDETECT => open, 
      PATTERNDETECT => DSP_Control, 
      PCOUT => open,  
      UNDERFLOW => open, 
--       A => A_INP,      
     A =>A,    
      ACIN => "000000000000000000000000000000",    
      
     B => B,          
      BCIN => "000000000000000000",    
     C => reg_C2,           
      CARRYCASCIN => '0', 
     CARRYIN => '0', 
      CARRYINSEL => "000", 
      CEA1 => '1',      
      CEA2 => '1',      
      CEAD => '0', 
      CEALUMODE => '1',  --clock enable for ALUMODE
      CEB1 => '1',      
      CEB2 => '1',      
      CEC => '1',      
      CECARRYIN => '1', 
      CECTRL => '1',
      CED => '0',   
      CEINMODE => '1', 
      CEM => '1',       
      CEP => '1',       
      CLK => CLK,       

      D => "000000000000000000000000000",
 ---------------------------------------
     INMODE => inmd,   
     ALUMODE => reg_almd2,   
     OPMODE => reg_opmd2,  
 ----------------------------------------
      MULTSIGNIN => '0', 
      PCIN => "000000000000000000000000000000000000000000000000",      
      RSTA => RST,     
      RSTALLCARRYIN => RST, 
      RSTALUMODE => RST, 
      RSTB => RST,     
      RSTC => RST,     
      RSTCTRL => RST, 
      RSTD => RST,
      RSTINMODE => RST,
      RSTM => RST, 
      RSTP => RST 
   );

end Behavioral;

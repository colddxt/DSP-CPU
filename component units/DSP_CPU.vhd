----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2017 02:59:52 PM
-- Design Name: 
-- Module Name: Dawson_Integration - Behavioral
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

entity DSP_CPU is
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
end DSP_CPU;         
           -- RA, RB, RC, RD: in std_logic_vector(4 downto 0);
          --  Opcode, Intm_Val : in std_logic_vector(5 downto 0);
            --Data_out: out std_logic_vector(31 downto 0);
           --PC_Control_Final : out std_logic_Vector(1 downto 0);
           -- DSP_Control: out std_logic);



architecture Behavioral of DSP_CPU is

signal RA, RB, RC, RD: std_logic_vector(4 downto 0):= (others=>'0'); 
signal dsp_control:std_logic:= '0'; 
signal opcode,Interm: std_logic_vector(5 downto 0):= (others=>'0'); 

signal Reg_A, Reg_B, Reg_C, Write,instruction : std_logic_vector(31 downto 0):= X"00000000";
signal Temp_Wb_Add, Temp1_Wb_Add, Temp2_Wb_Add,Temp3_Wb_Add, Temp4_Wb_Add, Wb_Addr_Final : std_logic_vector(4 downto 0):= (others=>'0'); 
signal Temp_Inmode, Inmode, Inmode_Final         : std_logic_vector(4 downto 0):= (others=>'0'); 
--signal Wb_Addr_Final         : std_logic_vector(4 downto 0);
signal Map_Out_A        : std_logic_vector(29 downto 0):= (others=>'0'); 
signal Map_Out_B        : std_logic_vector(17 downto 0):= (others=>'0'); 
signal TemP_Map_Out_C        : std_logic_vector(31 downto 0):= (others=>'0');   --EM
signal Map_Out_C     : std_logic_vector(47 downto 0):= (others=>'0'); 
signal Temp_Wb_En, Temp1_Wb_En, Temp2_Wb_En, Temp3_Wb_En,Wb_en, Wb_Final :std_logic:= '0';
signal Temp_Adder_bit, Temp1_Adder_bit, Temp2_Adder_bit, Temp3_Adder_bit, Adder_en, Adder_en_Final :std_logic:= '0'; 
signal Temp_Alumode, Alumode, Alumode_Final     : std_logic_vector(3 downto 0):= (others=>'0'); 
signal Temp1_interm,Temp2_interm,Temp3_interm,Temp4_interm,Temp5_interm: std_logic_vector(5 downto 0):= (others=>'0'); 
signal InMap_Control,Control_In    : std_logic_vector(2 downto 0):= (others=>'0'); 
signal Opmode, Temp_Opmode, Opmode_Final    : std_logic_vector(8 downto 0):= (others=>'0'); 
signal PC_Control, Temp_PC_Control, Temp1_PC_Control, Temp2_PC_Control,Temp3_PC_Control, PC_control_final : std_logic_vector(1 downto 0):= (others=>'0'); 
Signal DSP_Result : std_logic_vector(31 downto 0):= (others=>'0'); 
--signal DSP_Control: std_logic;
Signal MEM_Address: std_logic_vector(4 downto 0):= (others=>'0'); 
Signal Mem_Data_out, Temp_Mem_Data_Out : std_logic_vector(31 downto 0):= (others=>'0'); 
--=====================COMPONENT DECLARATION ==========================--------------------

component integration1 is
    Port ( clk : in STD_LOGIC;
           pc_control : in STD_LOGIC_VECTOR (1 downto 0);
           dsp_control : in STD_LOGIC;
           j_adr : in STD_LOGIC_VECTOR (5 downto 0);
           instruction : out STD_LOGIC_VECTOR (31 downto 0)         
           );
end component;


Component Register_File is
            Port (Clock        : in std_logic;
                  Sel_Wr       : in std_logic;
                  Reg_Sel_A    : in std_logic_vector(4 downto 0);
                  Reg_Sel_B    : in std_logic_vector(4 downto 0); 
                  Reg_Sel_C    : in std_logic_vector(4 downto 0);
                  Reg_Sel_Wr   : in std_logic_vector(4 downto 0);
                  Reg_A        : out std_logic_vector(31 downto 0);
                  Reg_B        : out std_logic_vector(31 downto 0);
                  Reg_C        : out std_logic_vector(31 downto 0);
                  Reg_Wr       : in std_logic_vector(31 downto 0));
end component;-------Register file component----------
-----------------------------------------------------
Component In_map is
     Port(Ra:in std_logic_vector(31 downto 0); 
          Rb:in std_logic_vector(31 downto 0); 
          Rc:in std_logic_vector(31 downto 0); 
          Intr:in std_logic_vector(5 downto 0); 
          Ctrl: in std_logic_vector (2 downto 0);
          DSP_A: out std_logic_vector(29 downto 0); 
          DSP_B: out std_logic_vector(17 downto 0); 
          DSP_C: out std_logic_vector(47 downto 0); 
          clk: in std_logic); 
end Component;------ In mapping component ---------
---------------------------------------------------------
Component Controller is
        Port (clk : in STD_LOGIC;
              opcode : in STD_LOGIC_VECTOR (5 downto 0);
              control_in : out STD_LOGIC_VECTOR (2 downto 0);
              adder_en : out STD_LOGIC;
              wb_en : out STD_LOGIC;
              inmode : out STD_LOGIC_VECTOR (4 downto 0);
              opmode : out STD_LOGIC_VECTOR (8 downto 0);
              alumode : out STD_LOGIC_VECTOR (3 downto 0);
              pc_control : out STD_LOGIC_VECTOR (1 downto 0));
end Component;-- Contoller Component----------
------------------------------------------------------------------------
Component DSP_Block is
       port(CLK : in std_logic;   
            -- RST : in std_logic;
             A : in std_logic_vector( 29 downto 0);  --30 bit A
             B : in std_logic_vector( 17 downto 0);  --18 bit B
             C:  in std_logic_vector( 47 downto 0);  --48 bit C 
             almd: in std_logic_vector( 3 downto 0);
             opmd:  in std_logic_vector( 8 downto 0);
             inmd: in std_logic_vector( 4 downto 0);
             RESULT : out std_logic_vector(31 downto 0); --32 bit output 
             DSP_Control: out std_logic    --excess carryout  
             );
end component;-------------------- DSP_BLOCK Component--------
-------------------------------------------------------------------
Component ADD_ADDRES is
      Port (ADD_En, Clk  : in std_logic;
            A, B         : in std_logic_vector(4 downto 0);
            Sum          : out std_logic_vector(4 downto 0));
end component;---- MEM_Address Adder component-----------------
---------------------------------------------------------------------------
Component DATA_MEM is
        Port (write_data: in STD_LOGIC_VECTOR (31 downto 0);
              MemWrite, clk: in STD_LOGIC;
              address_R      : in std_logic_vector(4 downto 0);
              read_data: out STD_LOGIC_VECTOR (31 downto 0));
end component;
-----------------------------------------------------------------------
Component MUX_32 is
      Port (A, B : in std_logic_vector(31 downto 0);
          C    : out std_logic_vector(31 downto 0);
          Set  : in std_logic);
end component;--- MUX-32 Component ---------------------------
begin
REG: Register_File port map(Clock => Clock,
                            Sel_Wr => Wb_Final,
                           Reg_Sel_A  => RA, --address
                          Reg_Sel_B  => RB,
                          Reg_Sel_C  => RC,
                          Reg_Sel_Wr => Wb_Addr_Final,
                          Reg_A => Reg_A,   --datas out
                          Reg_B => Reg_B,
                          Reg_C => Reg_C,
                          Reg_Wr => Write);
-------------------------End of Register Mapping -------------------
INMAP:In_Map port map(Ra => Reg_A,  
                      Rb => Reg_B, 
                       Rc => Reg_C,  
                       Intr => temp1_interm,  
                       Ctrl => Control_In, 
                       DSP_A => Map_Out_A, 
                       DSP_B => Map_Out_B, 
                       DSP_C => Map_Out_C,
                       clk => CLock);    
-------------------------- End of InMapping -----------------------
CONTRL: Controller port map(clk => Clock,
                            opcode => Opcode,
                            control_in => Control_in,
                            adder_en => Adder_en,
                            wb_en => Wb_En,
                            inmode => inmode, 
                            opmode => opmode, 
                            alumode => ALumode, 
                            pc_control => PC_Control);   
------------------------------end of control----------------
IF_xing: integration1 port map (clk => clock, 
                            pc_control => PC_Control_final,
                            dsp_control => dsp_control,
                            j_adr => temp5_interm,
                            instruction => instruction);   
-------------------------Creating a Pipeline to wait for the DSP input control signal to be ready---------------------------
 process(Clock)
 
 begin
     --wait until clock'event;
    if rising_edge(clock) then
    --wait until clock'event and clock ='1';
        Temp_ALumode <= Alumode;
        Temp_Opmode <=  Opmode;                     
        Temp_Inmode <= Inmode;
        Temp_WB_En <= WB_En; --3rd clk
        Temp_Adder_bit <= Adder_En ;  --clk 3
        Temp_PC_Control <= PC_Control; --c3
       
        Temp_Wb_Add  <= Rd;  
        Temp1_interm <= interm;
      end if;
 end process;
    OPCODE <= instruction(31 downto 26);
    RD <= instruction(25 downto 21);
    RA <= instruction(20 downto 16);
    RB <= instruction(15 downto 11);
    RC <= instruction(10 downto 6);
    interm <= instruction(5 downto 0);
    Data_out <=Write;
    
    oreg_a <= reg_a;
    oreg_B <= reg_b;
    oreg_c <= reg_c;
    o_opmode <= opmode;
        oinstruction <= instruction;
        o_Map_Out_A <= Map_Out_A ;
        o_Map_Out_B <= Map_Out_B ;
       o_Map_Out_C <= Map_Out_C ;
      
        oWrite <= write;
        oTemp_Mem_Data_Out <=Temp_Mem_Data_Out;
        oDSP_result<=DSP_result;
        o_Adder_en_Final<= Adder_en_Final;
        oPC_Control_Final <= PC_Control_Final;
    
    Opmode_Final <= Temp_Opmode;
    Alumode_Final <= Temp_Alumode ;
    Inmode_Final <= Temp_Inmode;
    Temp1_WB_En <= Temp_WB_En; --dummy
    Temp1_Adder_Bit <= Temp_Adder_Bit;  --dummy
    Temp1_PC_Control <= Temp_PC_Control; --d
    Temp1_Wb_Add <= Temp_Wb_Add;  
---------------------------------------------------------------------------------------------------------
DSP: DSP_Block port map (CLK => CLock,   
                         A => Map_Out_A,
                         B => Map_Out_B,
                         C => Map_Out_C, 
                         almd => Alumode_Final,
                         opmd => Opmode_Final,
                         inmd => Inmode_Final,
                         RESULT => DSP_Result, 
                         DSP_Control => DSP_Control);
----------------------------------DSP Block Mapping--------------------------------------                         
MEM_ADDER: ADD_ADDRES port map (ADD_En => Temp1_Adder_Bit,
                                Clk => Clock,
                                A => Map_Out_A (4 downto 0),
                                B => Map_Out_B (4 downto 0),
                                Sum => MEM_Address);                               
--------------------------------------------------------------------------------------       
process (Clock)
begin
   ---wait until Clock'event;--
    if rising_edge(clock) then
        ---wait until Clock'event and Clock ='1';
            Temp2_WB_En <= Temp1_Wb_En;  --clk4
            Temp2_Adder_bit <= Temp1_Adder_bit;  --clk 4
            Temp2_PC_Control <= Temp1_PC_Control;  --4
             Temp_Map_Out_C <= Map_Out_C (31 downto 0);  --clk 4 EM
            Temp2_Wb_Add <= Temp1_Wb_Add;
            Temp2_interm <= Temp1_interm;
    end if;
end process;                        
---------------------------------------------------------------------------------------
DATA_MEMORY:DATA_MEM port map(write_data => Temp_Map_out_C (31 downto 0), 
                              MemWrite => Temp2_WB_En,
                              clk => CLock,
                              address_R => Mem_Address,
                              read_data => Mem_Data_Out);     
----------------------------------------------------------------------------------------                                                                             
process (Clock) 
begin 
    -- wait until Clock'event;
    if rising_edge(clock) then
       -- wait until Clock'event and Clock ='1';
            Temp3_PC_Control <= Temp2_PC_Control;  ---5
            Temp3_WB_En <= TEmp2_WB_En;  --clk 5
            Temp3_Adder_Bit <= Temp2_Adder_Bit;  --clk5
            Temp3_Wb_Add <= Temp2_Wb_Add;
            Temp_Mem_Data_Out <= Mem_Data_Out;
            Temp3_interm <= Temp2_interm;
     end if;
 end process;
process (Clock)
 begin 
 --wait until Clock'event;-- and Clock ='1';
     if rising_edge(clock) then
        -- wait until Clock'event and Clock ='1';
             PC_Control_Final <= Temp3_PC_Control;  ---6
             WB_Final <= TEmp3_WB_En;
             Adder_en_Final <= Temp3_Adder_Bit;  --clk6
             Temp4_Wb_Add <= Temp3_Wb_Add;  --clk6
             Temp4_interm <= Temp3_interm;
      end if;
  end process;
  process (CLock)
   begin 
     -- wait until Clock'event;
       if rising_edge(clock) then
            --and Clock ='1';
               Wb_Addr_Final <= Temp4_Wb_Add;
               Temp5_interm <= Temp4_interm;
        end if;
    end process;
   --------------------------------------------------
MEM_DSP_MUX: MUX_32 port map(A => DSP_Result,
                             B => Temp_Mem_Data_Out,
                             C => Write,
                             Set => Adder_en_Final);
end Behavioral;

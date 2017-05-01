# DSP-CPU
32-Bits DSP processor in VHDL
	University of Pittsburgh
	ECE 2140 - System on Chip - Team Project
	Project Members:
			Collins Dawson, Sr.
			Emon Daud Hasan
			Wenyu Shi
			Xingtain Dong
=======================================================================================================
USAGE OF THE FILES:
	This project supports instruction similar to the MIPS instruction. Because the project was designed 
	with vivado, to use the files in a project, it is advisable to use vivado to run this project.
		1. Download all the .vhd files here in a file. 
		2. Open vivado, and add the files to a new project.
		3. Run the RTL Analysis "Open Elaboration Design" to generate the elaborted schematics.
		4. Run Synthesis.
		5. Create a timing constraint using the "Constraints Wizard" in the synthesis tab.
		6. Re-run synthesis and verify the timing report. For this project, the DSP can run upto 450 MHz.

Note:   The first clock-cycle is to fetch (read) the instructions from the instruction memory, and every 
	clock-cycle after that continues to read the instructions, and increment the program counter (PC) 
	accordingly. The program will continue to run until the PC has reached an address greater than the
	address of the last instruction in the instruction memory. The instruction memory, data memory, 
	and the register file will still persist after the program ends in the PC, and these components 
	will only change if they are overwritten, or simulation ends.
===============================================================================================================
TYPES OF INSTRUCTIONS SUPPORTED:
==================================================================================================================
Instruction Assembly 			Operation		
------------------------------------------------------------------------------------------------------------------
Arithmetic/ Logical:
nop 					   nop			        none
add 				add rd, ra, rb			rd[31:0] = ra[31:0] + rb[31:0]
				add rd, ra, #imm 		rd[31:0] = ra[31:0] + {16{#imm[15]},#imm[15:0]}
sub 				sub rd, ra, rb 			rd[31:0] = ra[31:0] - rb[31:0]
				sub rd, ra, #imm 		rd[31:0] = ra[31:0] - {16{#imm[15]},#imm[15:0]}
mul 				mul rd, rb, rc 			rd[31:0] = rb[15:0] x rc[15:0]
madd 				madd rd, ra, rb, rc 		rd[31:0] = ra[31:0] + (rb[15:0] x rc[15:0])
--------------------------------------------------------------------------------------------------------------------
Data Transfer Types:
lw 				lw rd, [ra, rb] 		rd[31:0] = mem[ra[31:0] + rb[31:0]]
				lw rd, [ra, #imm] 		rd[31:0] = mem[ra[31:0] + {16{#imm[15]}, #imm[15:0]}
sw 				sw rd, [ra, rb] 		mem[ra[31:0] + rb[31:0]] = rd[31:0]
				sw rd, [ra, #imm] 		mem[ra[31:0] + {16{#imm[15]}, #imm[15:0]} = rd[31:0]
---------------------------------------------------------------------------------------------------------------------
Program Control:
slt 				slt rd, ra, rb 			rd = 1 if ra[31:0] < rb[31:0]
				slt rd, ra, #imm 		rd = 1 if ra[31:0] < {16{#imm[15]},#imm[15:0]}
j 				j #target 			pc = #target
b{condg}* 			bcond ra, rb, #target 		(ra condition rb) pc = #target
====================================================================================================================

Components:
	Details of the major parts of the processor.
		1. Integration.vhd:	
				   The main integration vhdl script that is run to generate the schematic 
			   	   diagram for the entire project. This file should be selected as the design 
				   file when simulating.

		2. PC.vhd:
				   The program counter points to the next instruction. Its output is incremented 
				   through the PC_adder until the last instruction is read in the instruction
				   memory.

		3. PC_Adder:
				   The PC_Adder increases the PC counter by oneat eac clock-cycle.

		4. Instruction_Memory:
				    The instruction memory houses the instructions, and reads on the each increment 
				    of the program counter. Its input is the address from the PC, and outputs 
				    a 32-bits instruction. The instruction memory ar pre-loaded with instructions.

						 Input  -- read_address -- 5bits
						 Output -- instruction -- 32bits

		5. Decoder:	
				  The decoder provides the select signals for the components. The input to the
				  decoder is the opcode, which is the high 6-bits of the instruction, and the 
				  outputs are shown below. The decoder run on the 2nd clock-cycle. 

						 Input -- Opcode <= instruction(31 downto 26)
						 Input -- Clock
		6. Register_File:
				  The register file is 32 by 32-bit register file, with 3 read lines and a 1
				  write line. The read lines are outputs from the register file, while the write
				  line is an input. These lines are accessed through the address lines.
				  The address lines are 5-bits addresses from instruction memory assisned as below.
				
				       Input--RA <= instruction(20 downto 16) --- Provides accesses to read line A.
				       Input--RB <= instruction(15 downto 11) --- Provides accesses to read line B.
				       Input--RC <= instruction(10 downto 6) ---  Provides accesses to read line C.
				       Input--RD <= instruction(25 downto 21) --- Provides accesses to write line.
				       Input--Sel_wr -- 1-bit from the decoder
				       Input-- Write -- 32-bits written back to the register file
				       Output-- Reg_A -- 32-bits
				       Output-- Reg_B -- 32-bits
				       Output-- Reg_C -- 32-bits

				  The write line is a written back after execution of the instruction in the 
				  DSP_Block. That means this line needs to be delayed by the number of clock-cycle
				  it takes to complete execution. Delaying the signals until they are needed is our
				  way of pipelining. Just like the decoder, the register file operates on the 2nd 
				  clock-cycle

		7. In_Map:
			        The in_map component maps the 32-bit oprand to the DSP. The mapping is split across 
				the of the DSP. The input to the in_map component are the read lines from the 
				register file, Reg_A, Reg_B, and Reg_C. The port mapping are map per the scheme in
				the table below. The inputs to the in_map are the 32-bit read outputs from the 
				register file, a 3-bit control signal from the decoder, an immediate value
	 			(#imm), which we assign as 'intr'. The intr is the lower 6-bits from the instruction
				
					Input  -- intr <= instruction(5 downto 0) -- the immediate value
					Output -- Ra -- 30-bits
					Output -- Rb -- 18-bits
					Output -- Rc -- 48-bits
					
	Assembly           	Operation    	 Port A (30b)         	Port B (18b) 		Port C (48b)
	-----------------------------------------------------------------------------------------------------------
	add Rd, Ra, Rb      	C + A:B         16{Rb[31]},Rb[31:18]   	Rb[17:0]        	16{Ra[31]}, Ra[31:0]
	add Rd, Ra, #imm    	C + A:B 	30{1'b0}	       	2{imm[15]}, imm[15:0] 	16{Ra[31]}, Ra[31:0]
	sub Rd, Ra, Rb 	    	C - A:B 	16{Rb[31]}, Rb[31:18] 	Rb[17:0] 		16{fRa[31]}, Ra[31:0]
	mul Rd, Rb, Rc 	    	C + A x B 	15{Rb[15]}, Rb[15:0]    2{Rc[15]}, Rc[15:0] 	48{1'b0}
	madd Rd, Ra, Rb, Rc 	C + A x B 	15{Rb[15]}, Rb[15:0] 	2{Rb[15]}, Rc[15:0] 	16{Ra[31]}, Ra[31:0]


		8. DSP_Block:
			        The DSP_Block performs the execution of the instruction (add, sub, mul, madd, etc...)
				This project explores the DSP48E2 on the Xilinx Zynq Ultrascale series. The DSP_block
				houses an ALU, and a multplier which is 18 x 27 bit long to perform arithmetic operations. 
				To fully implement a 3232 multiplier, three DSP48E2 primitives can be cascaded together, 
				but this triples the resource requirement for the benefit of only a single instruction.
 				Hence, we restrict multiplication to 1616 bits, producing a 32-bit result. A wider 
				multiplication than 16 bits would not be beneficial, since the result would have to be 
				truncated to fit the 32-bit data format.

					Input -- Ra -- 30 bits from in-map
					Input -- Rb -- 18 bits from in-map
					Input -- Rc -- 48 bits from in-map
					Input -- Clock  -- 1-bit
					Output-- DSP_Result 32-bits
					Output-- DSP_Control 1-bit

		9. MEM_Adder:
				The mem_adder generates the address line for the data memory. It takes the lower 5-bits of 
				the 2 outputs from the in_map (Ra an Rb) and add them to generate the output for the 
				data memory address.

					Input -- A <= Ra(4 downto 0) -- 5 bits
					Input -- B <= Ra(4 downto 0) -- 5 bits
					Input -- Clock  -- 1-bit
					Output -- Sum = A + B -- 5 bits

		10. Data_Mem:
				The data_mem is the data memory and it is preloaded. It takes it address from the memory adder,
				mem_adder sum to generate the memory data output. When a memory write signal memwrite, is asserted
				the data memory is written in to it. This occurs when a store instruction is issued. This requires
				the memwrite signal form the decoder to be delay for a specific number of clock-cycle for the sum
				signal from the memory adder to be ready. The write signal is asserted from the Rc signal coming 
				from in_map.

					Input -- memwrite -- 1 bit - from decoder
					Input -- read_address -- 5 bits -- from sum of memory adder
					Input -- Clock  -- 1-bit
					Input -- write_data <= Rc(31 downto 0) -- 32 bits -- from Rc of in_map
					Output -- Mem_Data_Out --- 32-bits
					
		11. MUX_J:
				The MUX_J generates multiplexer select signal for the jump and branch operations. This component compares 
				the DSP_control signal, which is a carry_out bit from the DSP to the PC_Control from the decoder. The output
				is the jump address select signal. The PC_Control signal is delayed until the DSP_Control signal from the DSP
				is ready.
		
					Input -- PC_Control -- 2 bit - from decoder
					Input -- DSP_Control --1-bit -- from the DSP_Block
					Input -- Clock  -- 1-bit
					Output -- jadr_en --- 1-bit

		12. PC_MUX:
				The PC_Mux is a multiplexer that selects the #imm value (intr) from the last 6-bits from the instruction, if 
				the jadr-en is 1, or selects the PC_addressout from the PC_adder if the jadr_en is '0'.
										
					Input -- PC_addressout -- 6 bits -- from sum of PC adder
					Input -- J_addr -- 6 bits -- lower 6 bit from instruction -- instruction(5 downto 0)
					Output -- Address_in --- 6 bits to PC

		13. MUX_32:
				This multiplexer selects either the output from the DSP_Block, DSP_Result, or the output from the data memory
				Mem_Data_out. The select signal is the adder_en signal from the decoder delayed for a specific amount of 
				clock-cycle for the DSP_result and the Mem_Data_Out signals to be ready for assertion.

NOTES:
	There are other components that are not defined in this readme file. Components such the WRT_BK_5_CYCLES are not defined here.
	For instance this component takes the Wb_en signal from the decoder, and delays it for 5- clock-cycles. All the delay components 
	are designed as shift registers.
-----------------------------------------------------------------------------------------------------------------------------------------------------------
TO DO:
	1. Resolve synthesis hold-time issue
	2. Have fun while design this project.

#!/bin/bash

clear
cd sim    # go to sim/
rm ./*    # remove all previous binary and vcd files

#----------------------------------------------------------------- generating binaries for all DUT files
echo "------> Compiling all verilog DUT files"

iverilog -Wall -o half_adder.o 										../rtl/half_adder.v
iverilog -Wall -o carry_lookaheadblock_4bit.o 		../rtl/carry_lookaheadblock_4bit.v
iverilog -Wall -o carry_lookaheadadder_16bit.o		../rtl/carry_lookaheadadder_16bit.v
iverilog -Wall -o finaldata_reg.o 								../rtl/finaldata_reg.v
iverilog -Wall -o matrix_10x10.o 									../rtl/matrix_10x10.v
iverilog -Wall -o mux_2x1.o 											../rtl/mux_2x1.v
iverilog -Wall -o partialproduct_reg.o 						../rtl/partialproduct_reg.v
iverilog -Wall -o vedicmultiplier_2bit.o 					../rtl/vedicmultiplier_2bit.v
iverilog -Wall -o vedicmultiplier_4bit.o 					../rtl/vedicmultiplier_4bit.v
iverilog -Wall -o vedicmultiplier_8bit.o 					../rtl/vedicmultiplier_8bit.v
iverilog -Wall -o control_path.o 									../rtl/control_path.v
iverilog -Wall -o data_path.o 										../rtl/data_path.v
iverilog -Wall -o top_matrix_multiplier.o 				../rtl/top_matrix_multiplier.v

echo "------> Compiled all verilog DUT files"

#----------------------------------------------------------------- generating binaries for all TB files
echo "------> Compiling all verilog TB files"

iverilog -Wall -o tb_carrylookahead_adder.o ../test_bench/tb_carrylookahead_adder.v
vvp tb_carrylookahead_adder.o
# gtkwave carrylookahead_adder.vcd

iverilog -Wall -o tb_control_path.o   ../test_bench/tb_control_path.v
vvp tb_control_path.o
# gtkwave control_path.vcd

iverilog -Wall -o tb_datapath.o       ../test_bench/tb_datapath.v
vvp tb_datapath.o
# gtkwave data_path.vcd

iverilog -Wall -o tb_matrix_10x10.o   ../test_bench/tb_matrix_10x10.v
vvp tb_matrix_10x10.o
# gtkwave matrix_10x10.vcd

iverilog -Wall -o tb_registers.o      ../test_bench/tb_registers.v
vvp tb_registers.o
# gtkwave registers.vcd

iverilog -Wall -o tb_vedicmultiplier.o  ../test_bench/tb_vedicmultiplier.v
vvp tb_vedicmultiplier.o
# gtkwave vedic_multipliers.vcd

iverilog -Wall -o top_matrix_multiplier.o   ../test_bench/tb_top_matrix_multiplier.v
vvp top_matrix_multiplier.o
# gtkwave top_matrix_multiplier.vcd

#----------------------------------------------------------------- go back to root project directory and end script
cd ..   # go back to project root directory

# NOTE; remove all DUT files from dir. add one by one and make commits. same for TB files
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

# iverilog -Wall -o tb_carrylookahead_adder.o       ../test_bench/tb_carrylookahead_adder.v
# vvp tb_carrylookahead_adder.o
# gtkwave carrylookahead_adder.vcd


cd ..   # go back to project root directory

# NOTE; remove all DUT files from dir. add one by one and make commits. same for TB files
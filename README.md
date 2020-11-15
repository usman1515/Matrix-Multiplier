# Matrix Multiplier

## 1. Introduction
This project outlines the design and implementation of an 8-bit 10x10 matrix multiplier using **Vedic multiplication**. It takes two matrices i.e. **matrix A** and **matrix B** and gives their product **matrix C** i.e. **C=A*B**.  

The top module i.e. `matrix_multiplier.sv` is implemented as a **finite-state machine with datapath (FSMD)**. A FSMD is a digital system composed of a finite-state machine `control_path.sv`, which controls the program flow, and a datapath `data_path.sv`, which performs data processing operations.

## 2. Block Diagram
Below attached is the block diagram of the top module i.e. `matrix_multiplier.sv`.

![Diagram](/docs/matrix_multipler.svg "Diagram")

## 3. Dependency Chart
The diagram below shows the implementation of the matrix mutipler and how various modules and submodules are dependent upon each other.

![Diagram](/docs/dependency_graph.svg "Diagram")

## 4. Port List
The table below lists all the input and output ports that are part of `matrix_multilier.sv`. 
All ports having **ADDR_WIDTH** are of **4-bit** length.
All ports having **DATA_WIDTH** are of **8-bit** length.

| Port name       | Direction | Type             | Description |
| --------------- | --------- | ---------------- | ----------- |
| clk             | input     |                  | clock signal             |
| reset_n         | input     |                  | reset (Active LOW)       |
| en_ReadMat_A    | output    |                  | read enable matrix A     |
| en_WriteMat_A   | output    |                  | write enable matrix A    |
| rowAddr_A       | output    | [ADDR_WIDTH-1:0] | row address matrix A     |
| colAddr_A       | output    | [ADDR_WIDTH-1:0] | column address matrix A  |
| writeData_A     | output    | [DATA_WIDTH-1:0] | write data into matrix A |
| readData_A      | input     | [DATA_WIDTH-1:0] | read data from matrix A  |
| en_ReadMat_B    | output    |                  | read enable matrix B     |
| en_WriteMat_B   | output    |                  | write enable matrix B    |
| rowAddr_B       | output    | [ADDR_WIDTH-1:0] | row address matrix B     |
| colAddr_B       | output    | [ADDR_WIDTH-1:0] | column address matrix B  |
| writeData_B     | output    | [DATA_WIDTH-1:0] | write data into matrix B |
| readData_B      | input     | [DATA_WIDTH-1:0] | read data from matrix B  |
| en_ReadMat_C    | output    |                  | read enable matrix C     |
| en_WriteMat_C   | output    |                  | write enable matrix C    |
| rowAddr_C       | output    | [ADDR_WIDTH-1:0] | row address matrix C     |
| colAddr_C       | output    | [ADDR_WIDTH-1:0] | column address matrix C  |
| writeData_C     | output    | [DATA_WIDTH-1:0] | write data into matrix C |
| resultIsInvalid | output    |                  | HIGH if any matrix C value is greater than 255 else LOW  |


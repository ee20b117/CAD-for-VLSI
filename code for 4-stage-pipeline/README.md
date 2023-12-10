
This directory contains the code for 4-stage Pipelined Implementation of IMAC.




# How to run and test

## Stepts to test the code
### Step 1: Copy all the .bsv files from into the same directory and cd to that directory.
### Step 2: Create .ba files for modules acc (mkAcc), mul (mkMul) and top_module (mkImac) and the testbench (imacTb). 
```bsc -sim -g mkAcc imac_acc_4stage.bsv```

```bsc -sim -g mkMul imac_mul_4stage.bsv```

```bsc -sim -g mkImac imac_top_module_4stage.bsv```

```bsc -sim -g imacTb imac_tb_4stage.bsv```

### Step 3: Create bsim file for testbench
```bsc -sim -e imacTb -o ./imacTb_bsim```

### Step 4: Run the bsim file
```./imacTb_bsim```

### Expected Output
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/386efc01-c8c1-4787-9a2f-7b525880a6ee)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/1b42cfd6-2b5f-4f83-b1f8-65305d5f1a0b)


### Modiying the testbench
Currently, the testbench has 12 pre-defined test cases. They can be modified appropriately. The no. of test cases can also be increased by changing the initialised values of the registers: mul_total_cases and acc_total_cases in the testbench.

### The .v files are corresponding verilog files generated using ```bsc -u -verilog imac_top_module_4stage.bsv``` 

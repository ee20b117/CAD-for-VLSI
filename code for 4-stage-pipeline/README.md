
This directory contains the code for 4-stage Pipelined Implementation of IMAC.




# How to run and test

## Stepts to test the code
### Step 1: Copy all the .bsv files from into the same directory and cd to that directory.
### Step 2: Create .ba files for modules acc (mkAcc), mul (mkMul) and top_module (mkImac) and the testbench (imacTb). 
```bsc -sim -g mkAcc imac_acc.bsv```

```bsc -sim -g mkMul imac_mul.bsv```

```bsc -sim -g mkImac imac_top_module.bsv```

```bsc -sim -g imacTb imac_tb.bsv```

### Step 3: Create bsim file for testbench
```bsc -sim -e imacTb -o ./imacTb_bsim```

### Step 4: Run the bsim file
```./imacTb_bsim```

### Expected Output
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/7b52a80e-3473-4c08-87cd-c1520512d128)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/f6a9c2e4-19df-4be4-9237-3ab05f29e068)

### Modiying the testbench
Currently, the testbench has 6 pre-defined test cases. They can be modified appropriately. The no. of test cases can also be increased by changing the initialised values of the registers: mul_total_cases and acc_total_cases in the testbench.

### The .v files are corresponding verilog files generated using ```bsc -u -verilog imac_top_module.bsv``` 

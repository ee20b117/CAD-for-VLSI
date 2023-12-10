
This directory contains the code for 1-stage Pipelined Implementation of IMAC.

# How to run and test

## Stepts to test the code
### Step 1: Copy all the .bsv files from into the same directory and cd to that directory.
### Step 2: Create .ba files for modules acc (mkAcc), mul (mkMul) and top_module (mkImac) and the testbench (imacTb). 
```bsc -sim -g mkAcc imac_acc.bsv```

```bsc -sim -g mkMul imac_mul.bsv```

```bsc -sim -g mkImac imac_top_module.bsv```

```bsc -sim -g imacTb imac_tb_1stage.bsv```

### Step 3: Create bsim file for testbench
```bsc -sim -e imacTb -o ./imacTb_bsim```

### Step 4: Run the bsim file
```./imacTb_bsim```

### Expected Output
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/c2624b33-4032-4132-9475-a26acfc74c9c)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/be9799b5-3680-4fc3-ae48-f04104f99b9d)


### Modiying the testbench
Currently, the testbench has 12 pre-defined test cases. They can be modified appropriately. The no. of test cases can also be increased by changing the initialised values of the registers: mul_total_cases and acc_total_cases in the testbench.

### The .v files are corresponding verilog files generated using ```bsc -u -verilog imac_top_module_1stage.bsv``` 

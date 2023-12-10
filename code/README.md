


# How to run and test

## Stepts to test the code
### Step 1: Copy all the .bsv files in [code/](code) into the same directory and cd to that directory.
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
```IMAC Passed 6 cases out of 6 cases```
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/468168bc-6e7d-44a9-858d-8435d7c0ee43)


### Modiying the testbench
Currently, the testbench has 6 pre-defined test cases. They can be modified appropriately. The no. of test cases can also be increased by changing the initialised values of the registers: mul_total_cases and acc_total_cases in the testbench.

### The .v files are corresponding verilog files generated using ```bsc -u -verilog imac_top_module.bsv``` 

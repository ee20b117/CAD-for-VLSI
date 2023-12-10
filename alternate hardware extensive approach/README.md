This directory contains an alternate hardware approach. If there is very little or no constraint on area, hardware extensive approches with multiple harware blocks to perform the computations can be used. These are implemented using funtion calls in bluespec as shown.

# How to run and test

## Stepts to test the code
### Step 1: Copy all the .bsv files from into the same directory and cd to that directory.
### Step 2: Create .ba files for modules acc (mkAcc), mul (mkMul) and top_module (mkImac) and the testbench (imacTb). 
```bsc -sim -g mkMac iMac.bsv```

```bsc -sim -g imacTb test_imac.bsv```

### Step 3: Create bsim file for testbench
```bsc -sim -e imacTb -o ./imacTb_bsim```

### Step 4: Run the bsim file
```./imacTb_bsim```

### Expected Output
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/82ff0aca-f797-474a-85a8-1905c0253a1a)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/0d936442-bebe-4731-986c-d34ee6726592)

### Modiying the testbench
Currently, the testbench has 12 pre-defined test cases. They can be modified appropriately. The no. of test cases can also be increased by changing the initialised values of the registers: mul_total_cases and acc_total_cases in the testbench.

### The .v file is corresponding verilog files generated using ```bsc -u -verilog iMac.bsv``` 

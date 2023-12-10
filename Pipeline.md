# Pipelining - Timing and Area Analysis
## Unpiplined case
## Single Stage Pipelined case (1 stage between MUL and ACC blocks)
### Timing Analysis
Time Taken by MUL: 3860 units

Time taken by ACC: 40 units

Total time taken: max{3860, 40} = 3860 units
### Area Analysis
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/fc193183-d153-4afb-ba32-1e74eb798ca8)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/b61f620e-4280-46f3-9a95-dc319e7a1df6)

No. of cells in mkMul: 2993

No. of cells in mkAcc: 1839

Total no. of cells: 4832

## Four Stage Pipelined case (3 stages inside MUL block and 1 stage between MUL and ACC blocks)
### Timing Analysis
Time Taken by MUL: 980 units

Time taken by ACC: 40 units

Total time taken: max{3860, 40} = 1030 units
### Area Analysis
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/62d80034-6ead-462f-a66b-00913fda24e0)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/e8785edd-17f6-437b-83bd-62cea417af86)

No. of cells in mkMul: 10429

No. of cells in mkAcc: 1839

Total no. of cells: 12268

## Right choice of #Pipeline Stages
It can be seen that with the increase in no. of pipeline stages from 1 to 4, the area (which is proportional to no. of cells) has nearly doubled. However, the decrease in delay has reduced by nearly four times which is substantial. Therefore, if area is a bigger constraint, Single stage pipeline can be adopted while if timing is the crucial factor, Four stage Pipelined design can be adopted.   

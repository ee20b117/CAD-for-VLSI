# Pipelining - Timing and Area Analysis
## Unpiplined case
### Timing Analysis
Time Taken by MUL to respond: 3860 units

Time taken by ACC to respond: 40 units

i.e., MUL sends an output every 3860 units of time and ACC sends an output every 40 units of time.

Therefore, Minimum Time Period of clk required = 3860+40 = 3900 units
### Area Analysis
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/33ed8442-c193-489a-bf70-83ffc0efd963)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/e379d7c7-8a6b-49e6-be84-bcb478789702)


No. of cells in mkMul: 2993

No. of cells in mkAcc: 1839

Total no. of cells: 4832
## Single Stage Pipelined case (1 stage between MUL and ACC blocks)
### Timing Analysis
Time Taken by MUL: 3860 units

Time taken by ACC: 40 units

i.e., MUL sends an output every 3860 units of time and ACC sends an output every 40 units of time.

Therefore, the minimum Time Period of clk required = max{3860, 40} = 3860 units

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

i.e., MUL sends an output every 980 units of time and ACC sends an output every 40 units of time. 

Therefore, the minimum Time Period of clk required = 980+40 = 1030 units
### Area Analysis
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/62d80034-6ead-462f-a66b-00913fda24e0)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/e8785edd-17f6-437b-83bd-62cea417af86)

No. of cells in mkMul: 10429

No. of cells in mkAcc: 1839

Total no. of cells: 12268

## Right choice of #Pipeline Stages
It can be seen that with the increase in no. of pipeline stages from 1 to 4, the area (which is proportional to no. of cells) has nearly doubled. However, the minimum Clock Period required has reduced by nearly four times which is substantial. Therefore, if area is a bigger constraint, Single stage pipeline can be adopted while if timing is the crucial factor, Four stage Pipelined design can be adopted.   

## Alternate Hardware Extensive Approach
If there is very little or no constraint on area, hardware extensive approches with multiple harware blocks to perform the computations can be used. These are implemented using funtion calls in bluespec as depicted in the [alternate hardware extensive approach](https://github.com/ee20b117/CAD-for-VLSI/tree/main/alternate%20hardware%20extensive%20approach). This substantially decreases the delay and hence, the minimum clock period required to nearly 20 units. However, the area increases significantly (around 6-7 times). 

![image](https://github.com/ee20b117/CAD-for-VLSI/assets/104497659/b98a658a-af80-4751-b717-d5053447aa24)


# CAD-for-VLSI

# 64 BIT PIPELINED IMAC

## INTEGER MULTIPLIER AND ACCUMULATE

The Integer Multiplier and Accumulator (IMAC) is a computational unit commonly employed in digital signal processing (DSP) applications. Its primary function is to multiply two input integers and accumulate the results over multiple clock cycles. This versatile hardware module finds extensive use in applications such as filtering, convolution, and various mathematical transformations. The IMAC typically consists of a multiplier unit for performing integer multiplication and an accumulator to accumulate the products. The input integers, often represented in two's complement form, undergo parallel multiplication, and the results are accumulated in a register over successive clock cycles. This architecture enables the IMAC to efficiently perform multiply-accumulate operations, a fundamental operation in many signal processing algorithms. The ability to execute these operations in a pipelined manner makes the IMAC well-suited for real-time processing requirements, providing a balance between performance and resource utilization in digital systems

## Block diagram of MAC

![image](https://github.com/ee20b117/CAD-for-VLSI/assets/85502194/fe4ae8a8-8aad-4906-9eed-0f995607dc5f)

As stated above, MAC is an arithmetic unit of significant importance and occupies central position in the ALU , however , 64 bits is quite huge and this calls for area optimisation.

## Design decisions:

After a comprehensive review of diverse documentation pertaining to area-optimized multipliers, carefully considering various architectures such as Wallace Tree, Dadda, and array multipliers. Even state of the art implementations are a more optimised version of the prior mentioned architectures. Following an in-depth comparison, we have arrived at the conclusion that a **Booth multiplier presents the most favorable attributes for the intended application.**

The decision to settle on the Booth multiplier was influenced by its demonstrated efficiency in terms of area optimization. This choice reflects a strategic alignment with the project's requirements and a thorough consideration of the strengths and weaknesses inherent in different multiplier architectures. The Booth multiplier's ability to strike a balance between computational performance and resource utilization positions it as the optimal solution for the specific goals of the design.


**Utilisation of booth algorithm in a proposed solution for 64 bit multiplier**

![image](https://github.com/ee20b117/CAD-for-VLSI/assets/85502194/4f575411-e040-4ea1-91e8-300db7aa0f5a)
![image](https://github.com/ee20b117/CAD-for-VLSI/assets/85502194/d9076270-22a6-45a8-82fb-a88fce8a6f82)


**Comparison of different multipliers**

![image](https://github.com/ee20b117/CAD-for-VLSI/assets/85502194/18c6771a-18eb-4229-93f2-b4f9d50945e6)

From this it is evident that Booth's algorithm is robust and an optimised solution for the multiplier in MAC.

## BOOTH'S ALGORITHM

![image](https://github.com/ee20b117/CAD-for-VLSI/assets/85502194/bc795501-75da-4a24-89cb-fbaa6281fbca)


An optimisation of partial sum approach, the essence of Booth's algorithm is to convert your multiplication into series of additions with minimum number of operations.

As compared to wallace tree, that relies on partial product generation and reduction , Booth's algorithm doesnt rely on partial products. Thereby , we cut down the additional AND gates and full adders , reducing area, which goes a long way when the input is as large as 64 bit.

![image](https://github.com/ee20b117/CAD-for-VLSI/assets/85502194/160f2b19-3300-4a40-b676-2ab9347753ef)

Working:

The algorithm works by scanning the multiplicand and the multiplier bits sequentially. At each step, it examines two consecutive bits of the multiplier. Depending on the bit pair's value, Booth's algorithm employs three possible operations: no operation, addition, or subtraction. If the current bit pair is "00" or "11," arithmetic right shift is performed. In the case of "01," a partial product (shifted multiplicand) is added, while for "10," a partial product is subtracted. This method optimizes the multiplication process by reducing the number of additions and subtractions compared to conventional multiplication algorithms. 













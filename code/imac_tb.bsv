package imac_tb;

import imac_acc :: *;
import imac_mul :: *;
import imac_top_module :: *;

(*synthesize*)
module imacTb (Empty);
    Reg#(Bit#(64)) m[10];
    Reg#(Bit#(64)) q[10];
    Reg#(Bit#(128)) mul_result_actual[10];
    Reg#(Bit#(128)) mul_result_obtained <- mkReg(0);
    Reg#(Bit#(128)) mul_result <- mkReg(0);
    Reg#(Bit#(128)) acc_result_actual[10];
    Reg#(Bit#(128)) acc_result_obtained <- mkReg(0);
    Reg#(Bit#(3)) mul_total_cases <- mkReg(6);
    Reg#(Bit#(3)) mul_passed_cases <- mkReg(0);
    Reg#(Bit#(3)) mul_tested_cases <- mkReg(0);
    Reg#(Bit#(3)) acc_total_cases <- mkReg(6);
    Reg#(Bit#(3)) acc_passed_cases <- mkReg(0);
    Reg#(Bit#(3)) acc_tested_cases <- mkReg(0);

    Reg#(Bit#(4)) state <- mkReg(0);
    Reg#(Bool) mul_done <- mkReg(False);

    Reg#(Bit#(4)) acc_state <- mkReg(0);
    Reg#(Bool) acc_done <- mkReg(False);
    m[0] <- mkReg(-3);
    q[0] <- mkReg(4);
    mul_result_actual[0] <-mkReg(-12);
    acc_result_actual[0] <-mkReg(-12);
    m[1] <- mkReg(4);
    q[1] <- mkReg(4);
    mul_result_actual[1] <-mkReg(16);
    acc_result_actual[1] <-mkReg(4);
    m[2] <- mkReg(3);
    q[2] <- mkReg(-5);
    mul_result_actual[2] <-mkReg(-15);
    acc_result_actual[2] <-mkReg(-11);
    m[3] <- mkReg(4);
    q[3] <- mkReg(5);
    mul_result_actual[3] <-mkReg(20);
    acc_result_actual[3] <-mkReg(9);
    m[4] <- mkReg(5);
    q[4] <- mkReg(5);
    mul_result_actual[4] <-mkReg(25);
    acc_result_actual[4] <-mkReg(34);
    m[5] <- mkReg(6);
    q[5] <- mkReg(-4);
    mul_result_actual[5] <-mkReg(-24);
    acc_result_actual[5] <-mkReg(10);

    IMAC imac <- mkImac;
    rule put_imac (state==0);
        imac.put_val(unpack(m[acc_tested_cases]),unpack(q[acc_tested_cases]));
        acc_tested_cases <= acc_tested_cases + 1;
        state <= 1;
    endrule

    rule get_imac (state==1);
        acc_result_obtained <= pack(imac.get_val());
        state <= 2;
    endrule
    
    rule checkacc (state==2);
        if(acc_result_actual[mul_tested_cases] == acc_result_obtained) acc_passed_cases <= acc_passed_cases + 1;
        mul_tested_cases <= mul_tested_cases + 1;
        state <= 3;
    endrule
    rule endAcc (state==3);
        if(mul_tested_cases == acc_total_cases) begin
        acc_done <= True;
        $display("IMAC Passed %d cases out of %d cases",acc_passed_cases, acc_total_cases);
        $finish;
        end
        else begin 
        state<=0;
        end
    endrule
endmodule

endpackage
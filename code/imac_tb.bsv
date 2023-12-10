package imac;

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
        $display("Passed %d cases out of %d cases for IMAC",acc_passed_cases, acc_total_cases);
        $finish;
        end
        else begin 
        state<=0;
        end
    endrule
endmodule

interface IMAC;
    method Action put_val (Int #(64) data, Int #(64) q_); 
    method Int #(128) get_val(); 
endinterface 

module mkImac(IMAC);

    Reg#(Bit#(64)) m <- mkReg(0);
    Reg#(Bit#(64)) q <- mkReg(0);
    Reg#(Bit#(128)) mul_result_obtained <- mkReg(0);
    Reg#(Bit#(128)) mul_result <- mkReg(0);
    Reg#(Bit#(128)) acc_result_obtained <- mkReg(0);

    Reg#(Bit#(4)) state <- mkReg(0);
    Reg#(Bool) mul_done <- mkReg(False);

    Reg#(Bit#(4)) acc_state <- mkReg(0);
    Reg#(Bool) acc_done <- mkReg(False);
    IMul mul <- mkMul;
    rule put_mul (state==5);
        mul.put_val(unpack(m),unpack(q));
        state <= 1;
    endrule
    rule get_mul (state==1);
        mul_result_obtained <= pack(mul.get_val);
        state <= 4;
    endrule
    rule pipe (state==4 && acc_state==0);
            acc_state <= 2;
            mul_result <= mul_result_obtained;
            state <= 0;
    endrule
    IAcc acc <- mkAcc;
    rule put_acc (acc_state==2);
        acc.put_val(unpack(mul_result));
        acc_state <= 3;
    endrule
    rule get_acc (acc_state==3);
        acc_result_obtained <= pack(acc.get_val);
        acc_state <= 4;
    endrule

    rule free_acc (acc_state==4);
        acc_state <= 0;
    endrule

    method Action put_val (Int #(64) data, Int #(64) q_) if (state==0);
        m <= pack(data); 
        q <= pack(q_);
        state <= 5;
    endmethod

    method Int #(128) get_val() if(acc_state==4); 
        return unpack(acc_result_obtained);
    endmethod
endmodule

interface IAcc;
    method Action put_val (Int #(128) data); 
    method Int #(128) get_val(); 
endinterface

(*synthesize*)
module mkAcc(IAcc);
    Reg#(Bit#(128)) result <- mkReg(0);
    Reg#(Bit#(128)) mul_result <- mkReg(0);
    Reg#(Bit#(7)) count <- mkReg(0);
    Reg#(Bit#(2)) state <- mkReg(0);
    rule compute (state==1);
        result <= result + mul_result;
        count <= count + 1;
        state <= 2;
    endrule
    rule complete (state==2);
        if(count==1) begin 
            state <=0;
        end
        else state <= 1;
    endrule
    method Action put_val(data) if(state==0);
        count <= 0;
        mul_result <= pack(data);
        state <= 1;
    endmethod
    method get_val() if(count==1 && state==2);
        return unpack(result);
    endmethod
endmodule

interface IMul; 
    method Action put_val (Int #(64) data, Int #(64) q_); 
    method Int #(128) get_val(); 
endinterface 

(*synthesize*)
module mkMul (IMul); 
    Reg #(Bit #(64)) m <- mkReg(0); 
    Reg #(Bit #(64)) q <- mkReg(0);
    Reg #(Bit #(1)) q_1 <- mkReg(0);
    Reg #(Bit #(64)) accumulator <- mkReg(0);
    Reg #(Bit #(8)) counter <- mkReg(64);
    Reg #(Bit #(129)) accumulatorqq <- mkReg(0);
    Reg #(Bit #(2)) qq <- mkReg(0);

    Reg#(Bit#(4)) state <- mkReg(0);

    rule op (state==1);
        qq <= {q[0],q_1};
        state <= 6;
    endrule
    rule bitmul (state==6);
        if (qq==2'b01) accumulator <= accumulator + m;
        else if (qq==2'b10) accumulator <= accumulator - m;
        state <= 2;
    endrule

    rule concatbits (state==2);
        accumulatorqq <= {accumulator,q,q_1};
        state<=3;
    endrule

    rule lshift (state==3);
        accumulatorqq <= accumulatorqq >> 1;
        accumulator <= accumulator >> 1;
        q <= q>>1;
        q_1 <= q[0];
        state <= 4;
        counter <= counter + 1;
    endrule

    rule signext (state==4);
        q[63] <= accumulatorqq[64];
        accumulatorqq[128] <= accumulatorqq[127];
        accumulator[63] <= accumulator[62];
        state <=5;
    endrule

    rule complete (state==5);
        if (counter==64) begin 
            state<=0;
            accumulator <= 0;
            q_1 <= 0;
        end
        else state<=1;
    endrule

    method Action put_val (mul, q_) if(state==0);
        m <= pack(mul); 
        q <= pack(q_);
        counter <= 0;
        state <= 1;
    endmethod

    method Int #(128) get_val() if(counter == 64 && state==0); 
        return unpack(accumulatorqq[128:1]);
    endmethod

endmodule

endpackage
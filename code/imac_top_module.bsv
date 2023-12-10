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
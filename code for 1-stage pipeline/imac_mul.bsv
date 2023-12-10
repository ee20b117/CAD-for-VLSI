package imac_mul;

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
package imac_mul_4stage;

interface IMul; 
    method Action put_val (Int #(64) data, Int #(64) q_); 
    method Int #(128) get_val(); 
endinterface 

(*synthesize*)
module mkMul (IMul); 
    Reg #(Bit #(64)) m <- mkReg(0); 
    Reg #(Bit #(64)) q <- mkReg(0);
    Reg #(Bit #(1)) q1 <- mkReg(0);
    Reg #(Bit #(64)) accumulator <- mkReg(0);
    Reg #(Bit #(8)) counter <- mkReg(64);
    Reg #(Bit #(129)) accumulatorqq <- mkReg(0);
    Reg #(Bit #(2)) qq <- mkReg(0);

    Reg #(Bit #(64)) m_1 <- mkReg(0); 
    Reg #(Bit #(64)) q_1 <- mkReg(0);
    Reg #(Bit #(1)) q1_1 <- mkReg(0);
    Reg #(Bit #(64)) accumulator_1 <- mkReg(0);
    Reg #(Bit #(8)) counter_1 <- mkReg(64);
    Reg #(Bit #(129)) accumulatorqq_1 <- mkReg(0);
    Reg #(Bit #(2)) qq_1 <- mkReg(0);

    Reg #(Bit #(64)) m_2 <- mkReg(0); 
    Reg #(Bit #(64)) q_2 <- mkReg(0);
    Reg #(Bit #(1)) q1_2 <- mkReg(0);
    Reg #(Bit #(64)) accumulator_2 <- mkReg(0);
    Reg #(Bit #(8)) counter_2 <- mkReg(64);
    Reg #(Bit #(129)) accumulatorqq_2 <- mkReg(0);
    Reg #(Bit #(2)) qq_2 <- mkReg(0);

    Reg #(Bit #(64)) m_3 <- mkReg(0); 
    Reg #(Bit #(64)) q_3 <- mkReg(0);
    Reg #(Bit #(1)) q1_3 <- mkReg(0);
    Reg #(Bit #(64)) accumulator_3 <- mkReg(0);
    Reg #(Bit #(8)) counter_3 <- mkReg(64);
    Reg #(Bit #(129)) accumulatorqq_3 <- mkReg(0);
    Reg #(Bit #(2)) qq_3 <- mkReg(0);

    Reg#(Bit#(4)) state <- mkReg(0);
    Reg#(Bit#(2)) delay <- mkReg(0);

    rule op (state==1);
        qq <= {q[0],q1};
        qq_1 <= {q_1[0],q1_1};
        qq_2 <= {q_2[0],q1_2};
        qq_3 <= {q_3[0],q1_3};
        state <= 6;
    endrule
    rule bitmul (state==6);
        if (qq==2'b01) accumulator <= accumulator + m;
        else if (qq==2'b10) accumulator <= accumulator - m;

        if (qq_1==2'b01) accumulator_1 <= accumulator_1 + m_1;
        else if (qq_1==2'b10) accumulator_1 <= accumulator_1 - m_1;

        if (qq_2==2'b01) accumulator_2 <= accumulator_2 + m_2;
        else if (qq_2==2'b10) accumulator_2 <= accumulator_2 - m_2;

        if (qq_3==2'b01) accumulator_3 <= accumulator_3 + m_3;
        else if (qq_3==2'b10) accumulator_3 <= accumulator_3 - m_3;

        state <= 2;
    endrule

    rule concatbits (state==2);
        accumulatorqq <= {accumulator,q,q1};
        accumulatorqq_1 <= {accumulator_1,q_1,q1_1};
        accumulatorqq_2 <= {accumulator_2,q_2,q1_2};
        accumulatorqq_3 <= {accumulator_3,q_3,q1_3};
        state<=3;
    endrule

    rule lshift (state==3);
        accumulatorqq <= accumulatorqq >> 1;
        accumulator <= accumulator >> 1;
        q <= q>>1;
        q1 <= q[0];
        
        accumulatorqq_1 <= accumulatorqq_1 >> 1;
        accumulator_1 <= accumulator_1 >> 1;
        q_1 <= q_1>>1;
        q1_1 <= q_1[0];

        accumulatorqq_2 <= accumulatorqq_2 >> 1;
        accumulator_2 <= accumulator_2 >> 1;
        q_2 <= q_2>>1;
        q1_2 <= q_2[0];

        accumulatorqq_3 <= accumulatorqq_3 >> 1;
        accumulator_3 <= accumulator_3 >> 1;
        q_3 <= q_3>>1;
        q1_3 <= q_3[0];

        state <= 4;
        counter <= counter + 1;
    endrule

    rule signext (state==4);
        q[63] <= accumulatorqq[64];
        accumulatorqq[128] <= accumulatorqq[127];
        accumulator[63] <= accumulator[62];

        q_1[63] <= accumulatorqq_1[64];
        accumulatorqq_1[128] <= accumulatorqq_1[127];
        accumulator_1[63] <= accumulator_1[62];

        q_2[63] <= accumulatorqq_2[64];
        accumulatorqq_2[128] <= accumulatorqq_2[127];
        accumulator_2[63] <= accumulator_2[62];

        q_3[63] <= accumulatorqq_3[64];
        accumulatorqq_3[128] <= accumulatorqq_3[127];
        accumulator_3[63] <= accumulator_3[62];

        state <=5;
    endrule

    rule complete (state==5);
        if (counter==16) begin 
            accumulator <= 0;
            q1 <= 0;
            accumulator_1 <= accumulator;
            q1_1 <= q1;
            q_1 <= q;
            m_1 <= m;
            accumulator_2 <= accumulator_1;
            q1_2 <= q1_1;
            q_2 <= q_1;
            m_2 <= m_1;
            accumulator_3 <= accumulator_2;
            q1_3 <= q1_2;
            q_3 <= q_2;
            m_3 <= m_2;

            delay <= delay + 1;
            state<=0;
        end
        else state<=1;
    endrule

    method Action put_val (mul, q_) if(state==0);
        m <= pack(mul); 
        q <= pack(q_);
        counter <= 0;
        state <= 1;
    endmethod

    method Int #(128) get_val() if(counter == 16 && state==0);// && delay[0]==0); 
        return unpack(accumulatorqq_3[128:1]);
    endmethod

endmodule

endpackage
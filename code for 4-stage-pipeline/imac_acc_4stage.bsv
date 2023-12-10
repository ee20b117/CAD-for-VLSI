package imac_acc_4stage;

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

endpackage
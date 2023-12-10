package iMac;

interface IMac; 
 method Action put_val (Int #(64) data, Int #(64) q_); 
 method Bit #(128) get_val(); 
  //method Bool  rdy_val();
endinterface 
(*synthesize*)
module mkMac (IMac);

function Bit#(128) multiply(Bit#(64) mul, Bit#(64) qu);

Bit #(1) q_1 = 0; 
 Bit #(2) qq = (0);
 Bit #(64) q_ = 0;
 Bit #(64) m_ = 0;
 Bit #(64) accumulator_ = 0;
 Bit #(129) accumulatorqq_ = 0;
 Bit #(7) counter = 64;

q_ = qu;
m_ = mul;
q_1 = 0;
counter = 64;
accumulator_ = 0;
accumulatorqq_ = {accumulator_,q_,q_1} ;
for (int i = 0; i < 64; i = i+1) begin
    qq = {q_[0] , q_1};
 
 
    if(qq == 2'b01)
    
    begin
        //accumulatorqq[64:0] <= {q,q_1};
        accumulator_ = accumulator_ + m_;
    end

    else if(qq == 2'b10)
    begin
        //accumulatorqq[64:0] <= {q,q_1};
        accumulator_ = accumulator_ - m_;
    end
    accumulatorqq_ = {accumulator_,q_,q_1} ;
    accumulatorqq_ = accumulatorqq_ >> 1;
    accumulator_ = accumulator_ >> 1;
    q_1 = q_[0];
    q_ = q_>>1;
    q_[63] = accumulatorqq_[64];
     accumulatorqq_[128] = accumulatorqq_[127];
        accumulator_[63] = accumulator_[62];
    counter = counter-1;
end

return accumulatorqq_[128:1];

endfunction

function Bit#(2) fa(Bit#(1) a, Bit#(1) b,
Bit#(1) c_in);
Bit#(1) t = a ^ b;
Bit#(1) s = t ^ c_in;
Bit#(1) c_out = (a & b) | (c_in & t);
return {c_out,s};
endfunction

function Bit#(128) adder(Bit#(128) x, Bit#(128) y,Bit#(1) c0);
Bit#(128) s = 0; 
Bit#(129) c = 0; 
c[0] = c0;
let valw = 128;
for(Integer i=0; i<valw; i=i+1)
begin
let cs = fa(x[i],y[i],c[i]);
c[i+1] = cs[1]; s[i] = cs[0];
end
return s;
endfunction


Reg#(Int#(64)) input_m <- mkReg(0);
Reg#(Int#(64)) input_q <- mkReg(0);
Reg#(Int#(128)) output_acc <- mkReg(0);
Reg#(Bit#(64)) p1_m <- mkReg(0);
Reg#(Bit#(64)) p1_q <- mkReg(0);
Reg#(Bit#(128)) p2_product <- mkReg(0);
Reg#(Bit#(128)) p3_accumulate <- mkReg(0);
Reg#(Bit#(1)) zero <- mkReg(0);
Reg#(Bit#(2)) start <- mkReg(0);

rule all_at_once(start == 1); 
p1_m <= pack(input_m);
p1_q <= pack(input_q);
p2_product <= multiply(p1_m,p1_q);
p3_accumulate <= adder(p2_product,p3_accumulate,zero);
output_acc <= unpack(p3_accumulate);
start <= 0;
endrule

method Action put_val (mul, qu) if(start == 0) ; 
    action 
    input_m <= mul; 
    input_q <= qu;
    start <= 1;
    endaction 
 endmethod 
 method Bit #(128) get_val() if(start == 0) ; 
    return pack(output_acc);
 endmethod
endmodule

endpackage
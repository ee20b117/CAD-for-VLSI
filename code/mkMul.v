//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Sun Dec 10 11:02:18 IST 2023
//
//
// Ports:
// Name                         I/O  size props
// RDY_put_val                    O     1
// get_val                        O   128 reg
// RDY_get_val                    O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// put_val_data                   I    64 reg
// put_val_q_                     I    64
// EN_put_val                     I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkMul(CLK,
	     RST_N,

	     put_val_data,
	     put_val_q_,
	     EN_put_val,
	     RDY_put_val,

	     get_val,
	     RDY_get_val);
  input  CLK;
  input  RST_N;

  // action method put_val
  input  [63 : 0] put_val_data;
  input  [63 : 0] put_val_q_;
  input  EN_put_val;
  output RDY_put_val;

  // value method get_val
  output [127 : 0] get_val;
  output RDY_get_val;

  // signals for module outputs
  wire [127 : 0] get_val;
  wire RDY_get_val, RDY_put_val;

  // register accumulator
  reg [63 : 0] accumulator;
  reg [63 : 0] accumulator$D_IN;
  wire accumulator$EN;

  // register accumulatorqq
  reg [128 : 0] accumulatorqq;
  reg [128 : 0] accumulatorqq$D_IN;
  wire accumulatorqq$EN;

  // register counter
  reg [7 : 0] counter;
  wire [7 : 0] counter$D_IN;
  wire counter$EN;

  // register m
  reg [63 : 0] m;
  wire [63 : 0] m$D_IN;
  wire m$EN;

  // register q
  reg [63 : 0] q;
  reg [63 : 0] q$D_IN;
  wire q$EN;

  // register q_1
  reg q_1;
  wire q_1$D_IN, q_1$EN;

  // register qq
  reg [1 : 0] qq;
  wire [1 : 0] qq$D_IN;
  wire qq$EN;

  // register state
  reg [3 : 0] state;
  reg [3 : 0] state$D_IN;
  wire state$EN;

  // inputs to muxes for submodule ports
  wire [128 : 0] MUX_accumulatorqq$write_1__VAL_1,
		 MUX_accumulatorqq$write_1__VAL_2,
		 MUX_accumulatorqq$write_1__VAL_3;
  wire [63 : 0] MUX_accumulator$write_1__VAL_2,
		MUX_accumulator$write_1__VAL_3,
		MUX_accumulator$write_1__VAL_4,
		MUX_q$write_1__VAL_2,
		MUX_q$write_1__VAL_3;
  wire [7 : 0] MUX_counter$write_1__VAL_1;
  wire [3 : 0] MUX_state$write_1__VAL_1;
  wire MUX_accumulator$write_1__SEL_1, MUX_accumulator$write_1__SEL_2;

  // remaining internal signals
  wire [63 : 0] x__h443, x__h505;

  // action method put_val
  assign RDY_put_val = state == 4'd0 ;

  // value method get_val
  assign get_val = accumulatorqq[128:1] ;
  assign RDY_get_val = counter == 8'd64 && state == 4'd0 ;

  // inputs to muxes for submodule ports
  assign MUX_accumulator$write_1__SEL_1 = state == 4'd5 && counter == 8'd64 ;
  assign MUX_accumulator$write_1__SEL_2 =
	     state == 4'd6 && (qq == 2'b01 || qq == 2'b10) ;
  assign MUX_accumulator$write_1__VAL_2 = (qq == 2'b01) ? x__h443 : x__h505 ;
  assign MUX_accumulator$write_1__VAL_3 = { 1'd0, accumulator[63:1] } ;
  assign MUX_accumulator$write_1__VAL_4 =
	     { accumulator[62], accumulator[62:0] } ;
  assign MUX_accumulatorqq$write_1__VAL_1 =
	     { accumulatorqq[127], accumulatorqq[127:0] } ;
  assign MUX_accumulatorqq$write_1__VAL_2 = { 1'd0, accumulatorqq[128:1] } ;
  assign MUX_accumulatorqq$write_1__VAL_3 = { accumulator, q, q_1 } ;
  assign MUX_counter$write_1__VAL_1 = counter + 8'd1 ;
  assign MUX_q$write_1__VAL_2 = { 1'd0, q[63:1] } ;
  assign MUX_q$write_1__VAL_3 = { accumulatorqq[64], q[62:0] } ;
  assign MUX_state$write_1__VAL_1 = (counter == 8'd64) ? 4'd0 : 4'd1 ;

  // register accumulator
  always@(MUX_accumulator$write_1__SEL_1 or
	  MUX_accumulator$write_1__SEL_2 or
	  MUX_accumulator$write_1__VAL_2 or
	  state or
	  MUX_accumulator$write_1__VAL_3 or MUX_accumulator$write_1__VAL_4)
  begin
    case (1'b1) // synopsys parallel_case
      MUX_accumulator$write_1__SEL_1: accumulator$D_IN = 64'd0;
      MUX_accumulator$write_1__SEL_2:
	  accumulator$D_IN = MUX_accumulator$write_1__VAL_2;
      state == 4'd3: accumulator$D_IN = MUX_accumulator$write_1__VAL_3;
      state == 4'd4: accumulator$D_IN = MUX_accumulator$write_1__VAL_4;
      default: accumulator$D_IN =
		   64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign accumulator$EN =
	     state == 4'd5 && counter == 8'd64 ||
	     state == 4'd6 && (qq == 2'b01 || qq == 2'b10) ||
	     state == 4'd3 ||
	     state == 4'd4 ;

  // register accumulatorqq
  always@(state or
	  MUX_accumulatorqq$write_1__VAL_1 or
	  MUX_accumulatorqq$write_1__VAL_2 or
	  MUX_accumulatorqq$write_1__VAL_3)
  begin
    case (1'b1) // synopsys parallel_case
      state == 4'd4: accumulatorqq$D_IN = MUX_accumulatorqq$write_1__VAL_1;
      state == 4'd3: accumulatorqq$D_IN = MUX_accumulatorqq$write_1__VAL_2;
      state == 4'd2: accumulatorqq$D_IN = MUX_accumulatorqq$write_1__VAL_3;
      default: accumulatorqq$D_IN =
		   129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign accumulatorqq$EN = state == 4'd4 || state == 4'd3 || state == 4'd2 ;

  // register counter
  assign counter$D_IN = (state == 4'd3) ? MUX_counter$write_1__VAL_1 : 8'd0 ;
  assign counter$EN = state == 4'd3 || EN_put_val ;

  // register m
  assign m$D_IN = put_val_data ;
  assign m$EN = EN_put_val ;

  // register q
  always@(EN_put_val or
	  put_val_q_ or state or MUX_q$write_1__VAL_2 or MUX_q$write_1__VAL_3)
  begin
    case (1'b1) // synopsys parallel_case
      EN_put_val: q$D_IN = put_val_q_;
      state == 4'd3: q$D_IN = MUX_q$write_1__VAL_2;
      state == 4'd4: q$D_IN = MUX_q$write_1__VAL_3;
      default: q$D_IN = 64'hAAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign q$EN = EN_put_val || state == 4'd3 || state == 4'd4 ;

  // register q_1
  assign q_1$D_IN = !MUX_accumulator$write_1__SEL_1 && q[0] ;
  assign q_1$EN = state == 4'd5 && counter == 8'd64 || state == 4'd3 ;

  // register qq
  assign qq$D_IN = { q[0], q_1 } ;
  assign qq$EN = state == 4'd1 ;

  // register state
  always@(state or MUX_state$write_1__VAL_1 or EN_put_val)
  begin
    case (1'b1) // synopsys parallel_case
      state == 4'd5: state$D_IN = MUX_state$write_1__VAL_1;
      EN_put_val: state$D_IN = 4'd1;
      state == 4'd6: state$D_IN = 4'd2;
      state == 4'd2: state$D_IN = 4'd3;
      state == 4'd3: state$D_IN = 4'd4;
      state == 4'd4: state$D_IN = 4'd5;
      state == 4'd1: state$D_IN = 4'd6;
      default: state$D_IN = 4'b1010 /* unspecified value */ ;
    endcase
  end
  assign state$EN =
	     state == 4'd5 || EN_put_val || state == 4'd6 || state == 4'd2 ||
	     state == 4'd3 ||
	     state == 4'd4 ||
	     state == 4'd1 ;

  // remaining internal signals
  assign x__h443 = accumulator + m ;
  assign x__h505 = accumulator - m ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        accumulator <= `BSV_ASSIGNMENT_DELAY 64'd0;
	accumulatorqq <= `BSV_ASSIGNMENT_DELAY 129'd0;
	counter <= `BSV_ASSIGNMENT_DELAY 8'd64;
	m <= `BSV_ASSIGNMENT_DELAY 64'd0;
	q <= `BSV_ASSIGNMENT_DELAY 64'd0;
	q_1 <= `BSV_ASSIGNMENT_DELAY 1'd0;
	qq <= `BSV_ASSIGNMENT_DELAY 2'd0;
	state <= `BSV_ASSIGNMENT_DELAY 4'd0;
      end
    else
      begin
        if (accumulator$EN)
	  accumulator <= `BSV_ASSIGNMENT_DELAY accumulator$D_IN;
	if (accumulatorqq$EN)
	  accumulatorqq <= `BSV_ASSIGNMENT_DELAY accumulatorqq$D_IN;
	if (counter$EN) counter <= `BSV_ASSIGNMENT_DELAY counter$D_IN;
	if (m$EN) m <= `BSV_ASSIGNMENT_DELAY m$D_IN;
	if (q$EN) q <= `BSV_ASSIGNMENT_DELAY q$D_IN;
	if (q_1$EN) q_1 <= `BSV_ASSIGNMENT_DELAY q_1$D_IN;
	if (qq$EN) qq <= `BSV_ASSIGNMENT_DELAY qq$D_IN;
	if (state$EN) state <= `BSV_ASSIGNMENT_DELAY state$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    accumulator = 64'hAAAAAAAAAAAAAAAA;
    accumulatorqq = 129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    counter = 8'hAA;
    m = 64'hAAAAAAAAAAAAAAAA;
    q = 64'hAAAAAAAAAAAAAAAA;
    q_1 = 1'h0;
    qq = 2'h2;
    state = 4'hA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMul


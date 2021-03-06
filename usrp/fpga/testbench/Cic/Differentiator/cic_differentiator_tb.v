`timescale 1ns/100ps

module cic_differentiator_tb;

//test vector to load data from file
parameter TEST_VECTOR_LENGTH = 500;
parameter CLK_PER_2          = 10;
parameter ENABLE_PER         = 5000;
parameter STROBE_PER         = 50;
parameter SIM_TIME           = 3e5;

parameter INPUT_WIDTH  = 16;
parameter OUTPUT_WIDTH = 16;
parameter NUM_STAGES   = 4;

reg [INPUT_WIDTH-1:0] d_in;
wire [OUTPUT_WIDTH-1:0] d_out;


reg clk,rst;

initial
begin	
clk=1'b1;
forever #(CLK_PER_2) clk = ~clk;
end

always @(negedge clk)
   if(rst)
      d_in = 0;
   else
      d_in = 3*d_in + 1;

/*
VARIABLE Initialization
*/
 initial
 begin
    //reset pulse
    rst <= 1'b0;
    rst <= #10 1'b1;
    rst <= #100 1'b0;
 end


 cic_differentiator #( .INPUT_WIDTH(INPUT_WIDTH),.OUTPUT_WIDTH(OUTPUT_WIDTH) ) cic_dec_0
 (
	 .clock(clk),
    .reset(rst),
    .d_in(d_in),
    .d_out(d_out)
 );

 //read test vector from file into storage
 initial
 begin	
 $dumpfile("cic_differentiator_tb.lxt");
 $dumpvars;
 #(SIM_TIME) $finish;
  end

  endmodule 



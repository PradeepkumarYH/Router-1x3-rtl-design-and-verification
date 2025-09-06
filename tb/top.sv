module top;

	import uvm_pkg::*;
	import router_test_pkg::*;

	bit clock;

	always
		#5 clock=~clock;

	router_if in(clock),in0(clock),in1(clock),in2(clock);


	rtop DUV(.clk(clock),.rstn(in.restn),.din(in.din),
		.pkt_valid(in.pkt_valid),.error(in.error),
		.busy(in.busy),.re0(in0.rd_en),.re1(in1.rd_en),.re2(in2.rd_en),
		.vld0(in0.valid_out),.vld1(in1.valid_out),.vld2(in2.valid_out),
		.dout0(in0.dout),.dout1(in1.dout),.dout2(in2.dout));

	initial 
		begin	
			uvm_config_db#(virtual router_if)::set(null,"*","vif",in);
			uvm_config_db#(virtual router_if)::set(null,"*","vif0",in0);	
			uvm_config_db#(virtual router_if)::set(null,"*","vif1",in1);	
			uvm_config_db#(virtual router_if)::set(null,"*","vif2",in2);	
			run_test("large_test");
		end
endmodule	
				

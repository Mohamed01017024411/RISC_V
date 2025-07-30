module VERI_RISC #(parameter DWIDTH=8 , parameter AWIDTH = 5)(
    input clk , rst ,
    output halt
);

wire [2:0] phase , opcode ;
wire zero ;
wire sel , rd , ld_ir , inc_pc , ld_ac , ld_pc , wr , data_e ;
wire [AWIDTH-1:0] addr , ir_addr , pc_addr ;
wire [DWIDTH-1:0] data , ac_out , alu_out , ir_out ;

phase_generator counter_clk (.clk(clk), .rst(rst), .phase(phase));

controller controller_inst (.phase(phase), .opcode(opcode), .zero(zero), .sel(sel) , .rd(rd) , .ld_ir(ld_ir) ,
 .halt(halt) , .inc_pc(inc_pc) , .ld_ac(ld_ac) , .ld_pc(ld_pc) , .wr(wr) , .data_e(data_e)) ;

memory #(.DWIDTH(DWIDTH) , .AWIDTH(AWIDTH)) memory_inst (.clk(clk), .wr(wr), .rd(rd), .addr(addr), .data(data)) ;

counter #(.WIDTH(AWIDTH)) counter_pc (.clk(clk) , .rst(rst) , .enable(inc_pc) , .load(ld_pc) ,.cnt_in(ir_addr) ,
 .cnt_out(pc_addr)) ;
 
mux2x1 #(.WIDTH(AWIDTH)) address_mux (.in0(ir_addr), .in1(pc_addr), .sel(sel), .mux_out(addr));

register #(.WIDTH(DWIDTH)) register_ir (.clk(clk) , .load(ld_ir) , .rst(rst) , .data_in(data),
  .data_out(ir_out)) ; 

assign opcode  = ir_out[7:5];
assign ir_addr = ir_out[4:0];

alu #(.WIDTH(DWIDTH)) alu_inst (.in_a(ac_out) , .in_b(data) ,.opcode(opcode) , .alu_out(alu_out) ,
   .a_is_zero(zero));

register #(.WIDTH(DWIDTH)) register_ac (.clk(clk) , .load(ld_ac) , .rst(rst) , .data_in(alu_out) ,
    .data_out(ac_out));

driver #(.WIDTH(DWIDTH)) driver_inst (.data_in(alu_out) ,.data_en(data_e) , .data_out(data));

endmodule
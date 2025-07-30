module mux2x1 #(parameter WIDTH = 5) (
  input [WIDTH-1 : 0] in0 ,
  input [WIDTH-1 : 0]in1 ,
  input sel , 
  output reg [WIDTH-1 : 0] mux_out
);
 always @(*)begin
  case (sel)
    1'b0:begin mux_out = in0 ; end 
    1'b1:begin mux_out = in1 ; end 
  endcase
 end
endmodule
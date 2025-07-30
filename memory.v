module memory #(
  parameter AWIDTH = 5,
  parameter DWIDTH = 8
)(
  input clk, wr, rd,
  input [AWIDTH-1:0] addr,
  inout [DWIDTH-1:0] data
);

  reg [DWIDTH-1:0] array [0:(1<<AWIDTH)-1];
  reg [DWIDTH-1:0] data_out;

  always @(posedge clk) begin
    if (wr)
      array[addr] <= data;
  end

  always @(posedge clk) begin
    if (rd)
      data_out <= array[addr];
  end
  assign data = (rd && !wr) ? data_out : {DWIDTH{1'bz}};

endmodule
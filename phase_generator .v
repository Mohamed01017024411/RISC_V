module phase_generator (
    input wire clk,
    input wire rst,
    output reg [2:0] phase
);

always @(posedge clk or posedge rst) begin
    if (rst)
        phase <= 3'b000;           // Reset to phase 0
    else
        phase <= phase + 1'b1;     // Increment phase each clock cycle
end

endmodule
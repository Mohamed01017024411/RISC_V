module counter #(parameter WIDTH = 5)(
    input clk , rst , enable , load ,
    input [WIDTH-1:0] cnt_in ,
    output reg [WIDTH-1:0] cnt_out 
);
    reg [WIDTH-1:0] next_count;

    always @(*) begin
        if (rst) begin
            next_count = {WIDTH{1'b0}};  // Reset to all zeros
        end
        else if (load) begin
            next_count = cnt_in;         // Parallel load
        end
        else if (enable) begin
            next_count = cnt_out + 1;    // Increment
        end
        else begin
            next_count = cnt_out;        // Hold current value
        end
    end
    always @(posedge clk) begin
        cnt_out <= next_count;          // Update count on clock edge
    end
endmodule
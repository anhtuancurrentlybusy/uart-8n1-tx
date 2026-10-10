module uart_bit_counter (
    input  logic clk,
    input  logic rst_n,
    input  logic clear,
    input  logic increment,
    output logic bit_last
);

    logic [3:0] bit_index;

    assign bit_last = (bit_index == 4'd7);

    always_ff @(posedge clk) begin
        if (!rst_n)
            bit_index <= '0;
        else if (clear)
            bit_index <= '0;
        else if (increment)
            bit_index <= bit_index + 1'b1;
    end

endmodule
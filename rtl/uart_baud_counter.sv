module uart_baud_counter #(
    parameter int CLKS_PER_BIT = 16
) (
    input  logic clk,
    input  logic rst_n,
    input  logic clear,
    output logic tick
);

    localparam int CW =
        (CLKS_PER_BIT <= 1) ? 1 : $clog2(CLKS_PER_BIT);

    logic [CW-1:0] baud_count;

    assign tick = (CLKS_PER_BIT <= 1) ||
                  (baud_count == CLKS_PER_BIT - 1);

    always_ff @(posedge clk) begin
        if (!rst_n)
            baud_count <= '0;
        else if (clear)
            baud_count <= '0;
        else
            baud_count <= baud_count + 1'b1;
    end

endmodule
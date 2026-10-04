module baud_generator #(
    parameter int CLK_FREQ  = 50_000_000,
    parameter int BAUD_RATE = 115_200
)(
    input  logic clk,
    input  logic rst_n,

    output logic baud_tick
);

    localparam int BAUD_DIV = CLK_FREQ / BAUD_RATE;

    logic [$clog2(BAUD_DIV)-1:0] baud_counter;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            baud_counter <= '0;
            baud_tick    <= 1'b0;
        end
        else begin
            if (baud_counter == BAUD_DIV - 1) begin
                baud_counter <= '0;
                baud_tick    <= 1'b1;
            end
            else begin
                baud_counter <= baud_counter + 1'b1;
                baud_tick    <= 1'b0;
            end
        end
    end

endmodule
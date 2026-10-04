module tx_shift_register (
    input  logic clk,
    input  logic rst_n,

    input  logic       load,
    input  logic       shift_en,
    input  logic [7:0] data_in,

    output logic       tx
);

    logic [9:0] tx_shift;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tx_shift <= 10'b1111111111;
        end
        else begin
            if (load) begin
                // UART 8N1:
                // [9]    STOP
                // [8:1]  DATA
                // [0]    START
                tx_shift <= {1'b1, data_in, 1'b0};
            end

            else if (shift_en) begin
                tx_shift <= {1'b1, tx_shift[9:1]};
            end
        end
    end

    // TX được tạo trực tiếp từ bit thấp nhất của shift register
    assign tx = tx_shift[0];

endmodule
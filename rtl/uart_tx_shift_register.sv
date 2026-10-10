module uart_tx_shift_register (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       load,
    input  logic       shift_en,
    input  logic [7:0] data_in,
    output logic       shift_bit0,
    output logic       shift_bit1
);

    logic [7:0] shift_reg;

    assign shift_bit0 = shift_reg[0];
    assign shift_bit1 = shift_reg[1];

    always_ff @(posedge clk) begin
        if (!rst_n)
            shift_reg <= '0;
        else if (load)
            shift_reg <= data_in;
        else if (shift_en)
            shift_reg <= {1'b0, shift_reg[7:1]};
    end

endmodule
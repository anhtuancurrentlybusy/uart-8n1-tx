module uart_tx_top #(
    parameter int CLKS_PER_BIT = 16
) (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       valid_in,
    input  logic [7:0] data_in,
    output logic       tx,
    output logic       busy
);

    // Internal control signals
    logic baud_tick;
    logic baud_clear;

    logic bit_clear;
    logic bit_inc;
    logic bit_last;

    logic shift_load;
    logic shift_en;
    logic shift_bit0;
    logic shift_bit1;

    // 1. Baud counter
    uart_baud_counter #(
        .CLKS_PER_BIT(CLKS_PER_BIT)
    ) u_baud_counter (
        .clk   (clk),
        .rst_n (rst_n),
        .clear (baud_clear),
        .tick  (baud_tick)
    );

    // 2. Bit counter
    uart_bit_counter u_bit_counter (
        .clk       (clk),
        .rst_n     (rst_n),
        .clear     (bit_clear),
        .increment (bit_inc),
        .bit_last  (bit_last)
    );

    // 3. TX shift register
    uart_tx_shift_register u_tx_shift_register (
        .clk        (clk),
        .rst_n      (rst_n),
        .load       (shift_load),
        .shift_en   (shift_en),
        .data_in    (data_in),
        .shift_bit0 (shift_bit0),
        .shift_bit1 (shift_bit1)
    );

    // 4. UART controller
    uart_tx_controller u_tx_controller (
        .clk        (clk),
        .rst_n      (rst_n),
        .valid_in   (valid_in),
        .baud_tick  (baud_tick),
        .bit_last   (bit_last),
        .shift_bit0 (shift_bit0),
        .shift_bit1 (shift_bit1),

        .baud_clear (baud_clear),
        .bit_clear  (bit_clear),
        .bit_inc    (bit_inc),
        .shift_load (shift_load),
        .shift_en   (shift_en),

        .tx         (tx),
        .busy       (busy)
    );

endmodule
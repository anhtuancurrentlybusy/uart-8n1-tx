module uart_top #(
    parameter int CLK_FREQ  = 50_000_000,
    parameter int BAUD_RATE = 115_200
)(
    input  logic       clk,
    input  logic       rst_n,

    input  logic [7:0] ui_in,
    input  logic       req,

    output logic tx,
    output logic busy,
    output logic done
);

    //============================================================
    // INTERNAL SIGNALS
    //============================================================

    logic baud_tick;

    logic load_data;
    logic shift_data;


    //============================================================
    // BAUD GENERATOR
    //============================================================

    baud_generator #(
        .CLK_FREQ  (CLK_FREQ),
        .BAUD_RATE (BAUD_RATE)
    ) u_baud_generator (

        .clk       (clk),
        .rst_n     (rst_n),

        .baud_tick (baud_tick)

    );


    //============================================================
    // UART CONTROLLER
    //============================================================

    uart_controller u_uart_controller (

        .clk        (clk),
        .rst_n      (rst_n),

        .req        (req),
        .baud_tick  (baud_tick),

        .load_data  (load_data),
        .shift_data (shift_data),

        .busy       (busy),
        .done       (done)

    );


    //============================================================
    // TX SHIFT REGISTER
    //============================================================

    tx_shift_register u_tx_shift_register (

        .clk      (clk),
        .rst_n    (rst_n),

        .load     (load_data),
        .shift_en (shift_data),

        .data_in  (ui_in),

        .tx       (tx)

    );

endmodule
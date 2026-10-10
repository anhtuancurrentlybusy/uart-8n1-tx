module uart_tx_controller (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       valid_in,
    input  logic       baud_tick,
    input  logic       bit_last,
    input  logic       shift_bit0,
    input  logic       shift_bit1,

    output logic       baud_clear,
    output logic       bit_clear,
    output logic       bit_inc,
    output logic       shift_load,
    output logic       shift_en,

    output logic       tx,
    output logic       busy
);

    typedef enum logic [1:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t state;

    // Control signals for submodules
    always_comb begin
        baud_clear = 1'b0;
        bit_clear  = 1'b0;
        bit_inc    = 1'b0;
        shift_load = 1'b0;
        shift_en   = 1'b0;

        case (state)
            IDLE: begin
                baud_clear = 1'b1;
                bit_clear  = 1'b1;
                shift_load = valid_in;
            end

            START: begin
                if (baud_tick) begin
                    baud_clear = 1'b1;
                    bit_clear  = 1'b1;
                end
            end

            DATA: begin
                if (baud_tick) begin
                    baud_clear = 1'b1;

                    if (!bit_last) begin
                        bit_inc  = 1'b1;
                        shift_en = 1'b1;
                    end
                end
            end

            STOP: begin
                if (baud_tick)
                    baud_clear = 1'b1;
            end

            default: begin
                baud_clear = 1'b1;
                bit_clear  = 1'b1;
            end
        endcase
    end

    // FSM and output registers
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state <= IDLE;
            tx    <= 1'b1;
            busy  <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    tx   <= 1'b1;
                    busy <= 1'b0;

                    if (valid_in) begin
                        state <= START;
                        tx    <= 1'b0;
                        busy  <= 1'b1;
                    end
                end

                START, DATA, STOP: begin
                    busy <= 1'b1;

                    if (baud_tick) begin
                        case (state)
                            START: begin
                                state <= DATA;
                                tx    <= shift_bit0;
                            end

                            DATA: begin
                                if (bit_last) begin
                                    state <= STOP;
                                    tx    <= 1'b1;
                                end else begin
                                    tx <= shift_bit1;
                                end
                            end

                            STOP: begin
                                state <= IDLE;
                                tx    <= 1'b1;
                                busy  <= 1'b0;
                            end

                            default: state <= IDLE;
                        endcase
                    end
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
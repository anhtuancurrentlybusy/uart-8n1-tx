module uart_controller (
    input  logic clk,
    input  logic rst_n,

    input  logic req,
    input  logic baud_tick,

    output logic load_data,
    output logic shift_data,

    output logic busy,
    output logic done
);

    typedef enum logic [1:0] {
        IDLE  = 2'b00,
        START = 2'b01,
        DATA  = 2'b10,
        STOP  = 2'b11
    } state_t;

    state_t state;

    logic [3:0] bit_count;


    //============================================================
    // FSM STATE REGISTER
    //============================================================

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state     <= IDLE;
            bit_count <= 4'd0;
        end

        else begin

            case (state)

                //------------------------------------------------
                // IDLE
                //------------------------------------------------
                IDLE: begin

                    bit_count <= 4'd0;

                    if (req) begin
                        state <= START;
                    end

                end


                //------------------------------------------------
                // START
                //------------------------------------------------
                START: begin

                    if (baud_tick) begin
                        state <= DATA;
                    end

                end


                //------------------------------------------------
                // DATA
                //------------------------------------------------
                DATA: begin

                    if (baud_tick) begin

                        if (bit_count == 4'd7) begin

                            bit_count <= 4'd0;
                            state     <= STOP;

                        end

                        else begin

                            bit_count <= bit_count + 1'b1;

                        end

                    end

                end


                //------------------------------------------------
                // STOP
                //------------------------------------------------
                STOP: begin

                    if (baud_tick) begin
                        state <= IDLE;
                    end

                end


                //------------------------------------------------
                // DEFAULT
                //------------------------------------------------
                default: begin

                    state     <= IDLE;
                    bit_count <= 4'd0;

                end

            endcase

        end
    end


    //============================================================
    // CONTROL SIGNAL GENERATION
    //============================================================

    always_comb begin

        // Default values
        load_data  = 1'b0;
        shift_data = 1'b0;

        busy       = 1'b0;
        done       = 1'b0;


        case (state)

            //------------------------------------------------
            // IDLE
            //------------------------------------------------
            IDLE: begin

                busy = 1'b0;

                if (req) begin
                    load_data = 1'b1;
                end

            end


            //------------------------------------------------
            // START
            //------------------------------------------------
            START: begin

                busy = 1'b1;

            end


            //------------------------------------------------
            // DATA
            //------------------------------------------------
            DATA: begin

                busy = 1'b1;

                if (baud_tick) begin
                    shift_data = 1'b1;
                end

            end


            //------------------------------------------------
            // STOP
            //------------------------------------------------
            STOP: begin

                busy = 1'b1;

                if (baud_tick) begin
                    done = 1'b1;
                end

            end


            //------------------------------------------------
            // DEFAULT
            //------------------------------------------------
            default: begin

                busy = 1'b0;

            end

        endcase

    end

endmodule
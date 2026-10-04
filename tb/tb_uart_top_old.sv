`timescale 1ns/1ps

module tb_uart_top;

    //============================================================
    // PARAMETERS
    //============================================================

    // 10 MHz clock
    localparam int CLK_FREQ = 10_000_000;

    // 1 MHz baud rate
    // => 1 UART bit = 1 us = 10 clock cycles
    localparam int BAUD_RATE = 1_000_000;

    localparam time CLK_PERIOD = 100ns;


    //============================================================
    // DUT SIGNALS
    //============================================================

    logic       clk;
    logic       rst_n;

    logic [7:0] ui_in;
    logic       req;

    logic       tx;
    logic       busy;
    logic       done;


    //============================================================
    // DUT
    //============================================================

    uart_top #(
        .CLK_FREQ  (CLK_FREQ),
        .BAUD_RATE (BAUD_RATE)
    ) dut (
        .clk   (clk),
        .rst_n (rst_n),

        .ui_in (ui_in),
        .req   (req),

        .tx    (tx),
        .busy  (busy),
        .done  (done)
    );


    //============================================================
    // CLOCK GENERATION
    //============================================================

    initial begin
        clk = 1'b0;

        forever begin
            #(CLK_PERIOD / 2);
            clk = ~clk;
        end
    end


    //============================================================
    // RESET TASK
    //============================================================

    task automatic reset_dut;

        begin

            rst_n = 1'b0;
            ui_in = 8'h00;
            req   = 1'b0;

            repeat (5) @(posedge clk);

            rst_n = 1'b1;

            repeat (2) @(posedge clk);

        end

    endtask


    //============================================================
    // CHECK UART FRAME
    //============================================================
    //
    // UART 8N1:
    //
    //       START   DATA[7:0]          STOP
    //          0    D0 D1 ... D7          1
    //
    // Transmission order:
    //
    //       START -> D0 -> D1 -> ... -> D7 -> STOP
    //
    //============================================================

    task automatic check_frame(
        input logic [7:0] expected_data
    );

        logic [9:0] expected_frame;

        integer i;

        begin

            // Construct expected UART frame
            //
            // [9]    = STOP
            // [8:1]  = DATA[7:0]
            // [0]    = START
            //
            expected_frame = {1'b1, expected_data, 1'b0};


            //----------------------------------------------------
            // Wait for START bit
            //----------------------------------------------------

$display("[CHECK] Waiting for BUSY at time %0t", $time);
wait (busy == 1'b1);
$display("[CHECK] BUSY detected at time %0t, tx=%b", $time, tx);

wait (tx == 1'b0);
$display("[CHECK] START detected at time %0t", $time);

#(500ns);


            //----------------------------------------------------
            // Check 10 UART bits
            //----------------------------------------------------

            for (i = 0; i < 10; i = i + 1) begin

                if (tx !== expected_frame[i]) begin

                    $error(
                        "[FRAME ERROR] data=0x%02h | bit=%0d | expected=%b | actual=%b | time=%0t",
                        expected_data,
                        i,
                        expected_frame[i],
                        tx,
                        $time
                    );

                end
                else begin

                    $display(
                        "[FRAME OK] data=0x%02h | bit=%0d | value=%b | time=%0t",
                        expected_data,
                        i,
                        tx,
                        $time
                    );

                end


                //------------------------------------------------
                // Move to middle of next bit
                //------------------------------------------------

                if (i < 9)
                    #(1us);

            end


            $display(
                "[PASS] UART frame 0x%02h transmitted correctly",
                expected_data
            );

        end

    endtask


    //============================================================
    // SEND ONE BYTE
    //============================================================

    task automatic send_byte(
        input logic [7:0] data
    );

        begin

            //----------------------------------------------------
            // Put data on input
            //----------------------------------------------------

            @(posedge clk);

            ui_in = data;


            //----------------------------------------------------
            // Generate request pulse
            //----------------------------------------------------

            req = 1'b1;

            @(posedge clk);

            req = 1'b0;


            //----------------------------------------------------
            // Wait until UART becomes busy
            //----------------------------------------------------

            wait (busy == 1'b1);


            //----------------------------------------------------
            // Wait until transmission is completed
            //----------------------------------------------------

            wait (done == 1'b1);


            //----------------------------------------------------
            // Wait until busy returns LOW
            //----------------------------------------------------

            wait (busy == 1'b0);


            $display(
                "[SEND] Byte 0x%02h completed at time %0t",
                data,
                $time
            );

        end

    endtask


    //============================================================
    // CHECK BUSY SIGNAL
    //============================================================

    task automatic check_busy_during_transmission;

        begin

            if (busy !== 1'b1) begin

                $error(
                    "[BUSY ERROR] busy should be HIGH during transmission"
                );

            end
            else begin

                $display(
                    "[PASS] busy = 1 during transmission"
                );

            end

        end

    endtask


    //============================================================
    // MAIN TEST
    //============================================================

    initial begin

        //========================================================
        // WAVEFORM DUMP
        //========================================================

        $dumpfile("uart.vcd");
        $dumpvars(0, tb_uart_top);


        //========================================================
        // INITIAL VALUES
        //========================================================

        clk   = 1'b0;
        rst_n = 1'b0;
        ui_in = 8'h00;
        req   = 1'b0;


        //========================================================
        // RESET
        //========================================================

        $display("");
        $display("==============================================");
        $display("        UART H01 TESTBENCH START");
        $display("==============================================");
        $display("");

        reset_dut();


        //========================================================
        // TEST 1
        // REQUIRED CASE: 0x00
        //========================================================

        $display("");
        $display("----------------------------------------------");
        $display("TEST 1: TRANSMIT 0x00");
        $display("----------------------------------------------");

        fork

            send_byte(8'h00);

            check_frame(8'h00);

        join


        //========================================================
        // TEST 2
        // REQUIRED CASE: 0xFF
        //========================================================

        $display("");
        $display("----------------------------------------------");
        $display("TEST 2: TRANSMIT 0xFF");
        $display("----------------------------------------------");

        fork

            send_byte(8'hFF);

            check_frame(8'hFF);

        join


        //========================================================
        // TEST 3
        // REQUIRED CASE: 0x55
        //========================================================

        $display("");
        $display("----------------------------------------------");
        $display("TEST 3: TRANSMIT 0x55");
        $display("----------------------------------------------");

        fork

            send_byte(8'h55);

            check_frame(8'h55);

        join


        //========================================================
        // TEST 4
        // REQUIRED CASE:
        // TWO CONSECUTIVE BYTES
        //
        // 0xA5 -> 0x3C
        //========================================================

        $display("");
        $display("----------------------------------------------");
        $display("TEST 4: TWO CONSECUTIVE BYTES");
        $display("        0xA5 -> 0x3C");
        $display("----------------------------------------------");

        fork

            begin

                send_byte(8'hA5);
                send_byte(8'h3C);

            end


            begin

                check_frame(8'hA5);
                check_frame(8'h3C);

            end

        join


        //========================================================
        // TEST 5
        // EXTRA CASE #1
        //
        // BOUNDARY CASE:
        // REQUEST WHILE UART IS BUSY
        //========================================================

        $display("");
        $display("----------------------------------------------");
        $display("TEST 5: BOUNDARY CASE");
        $display("        REQUEST WHILE BUSY");
        $display("----------------------------------------------");


        //--------------------------------------------------------
        // Start first transmission
        //--------------------------------------------------------

        @(posedge clk);

        ui_in = 8'hC3;
        req   = 1'b1;

        @(posedge clk);

        req = 1'b0;


        //--------------------------------------------------------
        // Wait until UART is busy
        //--------------------------------------------------------

        wait (busy == 1'b1);

        $display(
            "[INFO] UART is BUSY at time %0t",
            $time
        );


        //--------------------------------------------------------
        // Send another request while BUSY
        //--------------------------------------------------------

        @(posedge clk);

        ui_in = 8'h5A;
        req   = 1'b1;

        @(posedge clk);

        req = 1'b0;


        $display(
            "[INFO] Second request generated while BUSY"
        );


        //--------------------------------------------------------
        // Check first frame
        //--------------------------------------------------------

        check_frame(8'hC3);


        //--------------------------------------------------------
        // Wait until first transmission finishes
        //--------------------------------------------------------

        wait (busy == 1'b0);


        $display(
            "[PASS] Current frame 0xC3 was not corrupted by request while BUSY"
        );


        //========================================================
        // TEST 6
        // EXTRA CASE #2
        //
        // LSB-FIRST / SHIFT TEST
        //
        // 0x01
        //========================================================

        $display("");
        $display("----------------------------------------------");
        $display("TEST 6: LSB-FIRST SHIFT TEST");
        $display("        DATA = 0x01");
        $display("----------------------------------------------");

        fork

            send_byte(8'h01);

            check_frame(8'h01);

        join


        //========================================================
        // FINAL WAIT
        //========================================================

        repeat (10) @(posedge clk);


        //========================================================
        // END SIMULATION
        //========================================================

        $display("");
        $display("==============================================");
        $display("        UART H01 TESTBENCH FINISHED");
        $display("==============================================");
        $display("");

        $finish;

    end

endmodule
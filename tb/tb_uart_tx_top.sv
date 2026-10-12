module tb_uart_tx_top;

    localparam int CPB = 4;
    localparam int CLK_PERIOD = 10;

    logic clk = 0;
    logic rst_n = 0;
    logic valid_in = 0;
    logic [7:0] data_in = 0;
    logic tx, busy;

    time t_start, t_end;
    integer measured_cycles;

    uart_tx_top #(
        .CLKS_PER_BIT(CPB)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .valid_in(valid_in),
        .data_in(data_in),
        .tx(tx),
        .busy(busy)
    );

    always #(CLK_PERIOD/2) clk = ~clk;

    // Request one byte for one clock cycle.
    task automatic send(input logic [7:0] b);
        @(negedge clk);
        data_in = b;
        valid_in = 1'b1;

        @(negedge clk);
        valid_in = 1'b0;
    endtask

    // Sample the signal near the middle of a bit.
    task automatic check_bit(input logic expected);
        repeat (CPB) @(posedge clk);
        #1;
        assert (tx === expected)
            else $fatal(1,
                "TX mismatch: expected %b, got %b at time %0t",
                expected, tx, $time);
    endtask

    // Called after send() has returned.
    // Check START at its midpoint, then all data bits and STOP.
    task automatic check_frame(input logic [7:0] b);
        repeat (CPB/2) @(posedge clk);
        #1;
        assert (tx === 1'b0)
            else $fatal(1, "START bit incorrect for byte %02h", b);

        for (int i = 0; i < 8; i++) begin
            check_bit(b[i]);
        end

        check_bit(1'b1); // STOP
    endtask

    task automatic wait_tx_done;
        wait (busy == 1'b0);
        #1;
    endtask

    task automatic check_busy_after_frame(input logic [7:0] b);
        wait_tx_done();
        assert (tx === 1'b1)
            else $fatal(1, "TX did not return to idle after %02h", b);
    endtask

    initial begin
        // Initial reset
        repeat (2) @(negedge clk);
        rst_n = 1'b1;

        // --------------------------------------------------
        // TC02: 0x00
        // --------------------------------------------------
        send(8'h00);
        assert (busy) else $fatal(1, "TC02: busy not asserted");
        check_frame(8'h00);
        check_busy_after_frame(8'h00);
        $display("TC02 PASS: 0x00");

        // --------------------------------------------------
        // TC03: 0xFF
        // --------------------------------------------------
        send(8'hFF);
        assert (busy) else $fatal(1, "TC03: busy not asserted");
        check_frame(8'hFF);
        check_busy_after_frame(8'hFF);
        $display("TC03 PASS: 0xFF");

        // --------------------------------------------------
        // TC04: 0x55 (alternating bits / LSB first)
        // --------------------------------------------------
        send(8'h55);
        assert (busy) else $fatal(1, "TC04: busy not asserted");
        check_frame(8'h55);
        check_busy_after_frame(8'h55);
        $display("TC04 PASS: 0x55, LSB-first");


        // --------------------------------------------------
        // TC05: measure START bit duration
        // --------------------------------------------------
        @(negedge clk);
        data_in  = 8'h55;
        valid_in = 1'b1;

        @(negedge clk);
        valid_in = 1'b0;

        // Wait for the falling edge that marks START.
        @(negedge tx);
        t_start = $time;

        // For 0x55, data bit 0 is 1, so this rising edge
        // marks the end of START and the beginning of data.
        @(posedge tx);
        t_end = $time;

        measured_cycles = (t_end - t_start) / CLK_PERIOD;

        assert (measured_cycles == CPB)
            else $fatal(1,
                "TC05 FAIL: START duration %0d clocks, expected %0d",
                measured_cycles, CPB);

        // Allow the current frame to finish before the next test.
        wait_tx_done();

        $display("TC05 PASS: START duration = %0d clocks",
                 measured_cycles);


        // --------------------------------------------------
        // TC06: send two bytes consecutively
        // --------------------------------------------------
        send(8'hA5);
        check_frame(8'hA5);
        check_busy_after_frame(8'hA5);

        send(8'h3C);
        check_frame(8'h3C);
        check_busy_after_frame(8'h3C);

        $display("TC06 PASS: two sequential bytes");


        // --------------------------------------------------
        // TC07: Two requests separated by valid_in low
        // --------------------------------------------------

        // First request
        send(8'hA5);
        assert (busy)
            else $fatal(1, "TC07: busy not asserted for first byte");

        check_frame(8'hA5);
        check_busy_after_frame(8'hA5);

        // valid_in is low between requests.
        @(negedge clk);
        valid_in = 1'b0;

        // Second request
        send(8'h3C);
        assert (busy)
            else $fatal(1, "TC07: busy not asserted for second byte");

        check_frame(8'h3C);
        check_busy_after_frame(8'h3C);

        $display("TC07 PASS: two requests with valid_in deasserted between them");



        // --------------------------------------------------
        // TC11: reset during an active frame.
        // Expected rule A: abort, TX=1, busy=0.
        // --------------------------------------------------
        send(8'hA5);
        repeat (CPB) @(posedge clk);

        @(negedge clk);
        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        #1;

        assert (tx === 1'b1)
            else $fatal(1, "TC11 FAIL: TX not idle during reset");

        assert (busy === 1'b0)
            else $fatal(1, "TC11 FAIL: busy not cleared by reset");

        @(negedge clk);
        rst_n = 1'b1;
        valid_in = 1'b0;

        repeat (2) @(posedge clk);
        #1;

        assert (tx === 1'b1 && busy === 1'b0)
            else $fatal(1, "TC11 FAIL: outputs incorrect after reset");

        $display("TC11 PASS: reset aborts frame");
        $display("ALL TESTS PASS");
        $finish;
    end

    // Global timeout prevents a hung simulation.
    initial begin
        #100000;
        $fatal(1, "TIMEOUT: simulation did not finish");
    end

endmodule

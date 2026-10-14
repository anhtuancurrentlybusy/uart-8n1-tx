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

    task automatic send(input logic [7:0] b);
        @(negedge clk);
        data_in = b;
        valid_in = 1'b1;

        @(negedge clk);
        valid_in = 1'b0;
    endtask

    task automatic check_bit(input logic expected);
        repeat (CPB) @(posedge clk);
        #1;
        assert (tx === expected)
            else $fatal(1,
                "TX mismatch: expected %b, got %b at time %0t",
                expected, tx, $time);
    endtask

    task automatic check_frame(input logic [7:0] b);
        repeat (CPB/2) @(posedge clk);
        #1;
        assert (tx === 1'b0)
            else $fatal(1, "START bit incorrect for byte %02h", b);

        for (int i = 0; i < 8; i++) begin
            check_bit(b[i]);
        end

        check_bit(1'b1);
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
    $dumpfile("sim/waves/uart_tx.vcd");
    $dumpvars(0, tb_uart_tx_top);
        repeat (2) @(negedge clk);
        rst_n = 1'b1;

        // Case 1: Transmit 0x00
        send(8'h00);
        assert (busy) else $fatal(1, "Case 1: busy not asserted");
        check_frame(8'h00);
        check_busy_after_frame(8'h00);
        $display("Case 1 PASS: 0x00");

        // Case 2: Transmit 0xFF
        send(8'hFF);
        assert (busy) else $fatal(1, "Case 2: busy not asserted");
        check_frame(8'hFF);
        check_busy_after_frame(8'hFF);
        $display("Case 2 PASS: 0xFF");

        // Case 3: Check alternating bits and LSB-first order
        send(8'h55);
        assert (busy) else $fatal(1, "Case 3: busy not asserted");
        check_frame(8'h55);
        check_busy_after_frame(8'h55);
        $display("Case 3 PASS: 0x55, LSB-first");

        // Case 4: Measure START bit duration
        @(negedge clk);
        data_in  = 8'h55;
        valid_in = 1'b1;

        @(negedge clk);
        valid_in = 1'b0;

        @(negedge tx);
        t_start = $time;

        @(posedge tx);
        t_end = $time;

        measured_cycles = (t_end - t_start) / CLK_PERIOD;

        assert (measured_cycles == CPB)
            else $fatal(1,
                "Case 4 FAIL: START duration %0d clocks, expected %0d",
                measured_cycles, CPB);

        wait_tx_done();
        $display("Case 4 PASS: START duration = %0d clocks",
                 measured_cycles);

        // Case 5: Send two sequential bytes
        send(8'hA5);
        check_frame(8'hA5);
        check_busy_after_frame(8'hA5);

        send(8'h3C);
        check_frame(8'h3C);
        check_busy_after_frame(8'h3C);

        $display("Case 5 PASS: two sequential bytes");

        // Case 6: Send two requests with valid_in low between them
        send(8'hA5);
        assert (busy)
            else $fatal(1, "Case 6: busy not asserted for first byte");
        check_frame(8'hA5);
        check_busy_after_frame(8'hA5);

        @(negedge clk);
        valid_in = 1'b0;

        send(8'h3C);
        assert (busy)
            else $fatal(1, "Case 6: busy not asserted for second byte");
        check_frame(8'h3C);
        check_busy_after_frame(8'h3C);

        $display("Case 6 PASS: separate requests");

        // Case 7: Reset during an active frame
        send(8'hA5);
        repeat (CPB) @(posedge clk);

        @(negedge clk);
        rst_n = 1'b0;
        repeat (2) @(posedge clk);
        #1;

        assert (tx === 1'b1)
            else $fatal(1, "Case 7 FAIL: TX not idle during reset");

        assert (busy === 1'b0)
            else $fatal(1, "Case 7 FAIL: busy not cleared by reset");

        @(negedge clk);
        rst_n = 1'b1;
        valid_in = 1'b0;

        repeat (2) @(posedge clk);
        #1;

        assert (tx === 1'b1 && busy === 1'b0)
            else $fatal(1, "Case 7 FAIL: outputs incorrect after reset");

        $display("Case 7 PASS: reset aborts frame");

        $display("ALL TESTS PASS");
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "TIMEOUT: simulation did not finish");
    end

endmodule

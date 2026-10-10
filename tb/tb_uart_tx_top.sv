module tb_uart_tx_top;

    localparam int CPB = 4;

    logic clk = 0;
    logic rst_n = 0;
    logic valid_in = 0;
    logic [7:0] data_in = 0;
    logic tx, busy;

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

    always #5 clk = ~clk;

    task automatic send(input logic [7:0] b);
        @(negedge clk);
        data_in = b;
        valid_in = 1;

        @(negedge clk);
        valid_in = 0;
    endtask

    task automatic check_bit(input logic v);
        repeat (CPB) begin
            #1;
            assert (tx === v)
                else $fatal(1, "TX mismatch: expected %b, got %b", v, tx);
            @(posedge clk);
        end
    endtask

    initial begin
        repeat (2) @(posedge clk);
        rst_n = 1;

        send(8'hA5);
        assert (busy)
            else $fatal(1, "BUSY was not asserted");

        check_bit(0); // Start
        check_bit(1); // Data bit 0
        check_bit(0); // Data bit 1
        check_bit(1); // Data bit 2
        check_bit(0); // Data bit 3
        check_bit(0); // Data bit 4
        check_bit(1); // Data bit 5
        check_bit(0); // Data bit 6
        check_bit(1); // Data bit 7
        check_bit(1); // Stop

        repeat (2) @(posedge clk);
        #1;

        assert (!busy)
            else $fatal(1, "BUSY did not clear");

        $display("H01 TB PASS");
        $finish;
    end

endmodule
module spi_top_tb();

  reg clk, reset, start;
  reg [7:0] master_din, slave_din;
  wire [7:0] master_dout, slave_dout;

  spi_top DUT (
    .clk(clk),
    .reset(reset),
    .start(start),
    .master_din(master_din),
    .slave_din(slave_din),
    .master_dout(master_dout),
    .slave_dout(slave_dout)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz
  end

  initial begin
    $dumpfile("spi_top.vcd");
    $dumpvars(0, spi_top_tb);
    $monitor("Time=%0t master_din=%b slave_din=%b master_dout=%b slave_dout=%b",
              $time, master_din, slave_din, master_dout, slave_dout);
  end

  initial begin
    reset = 1;
    start = 0;
    master_din = 8'b10101010; // what master sends
    slave_din  = 8'b11001100; // what slave sends
    #50 reset = 0;

    #100 start = 1;
    #2000  start = 0;

    #2000;
    if (master_dout == slave_din && slave_dout == master_din)
      $display(" SPI Transfer Successful!");
    else
      $display("SPI Transfer Failed!");

    $finish();
  end

endmodule

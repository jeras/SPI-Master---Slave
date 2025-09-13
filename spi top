module spi_top(
  input clk,
  input start,
  input reset,
  input [7:0] master_din,
  input [7:0] slave_din,
  output [7:0] master_dout,
  output [7:0] slave_dout 
);
  
  wire sclk, cs, mosi, miso ;
  
  spi_master_final spi_master_init(
    .clk(clk),
    .reset(reset),
    .sclk(sclk),
    .din(master_din),
    .miso(miso),
    .mosi(mosi),
    .cs(cs),
    .start(start),
    .dout(master_dout)
  );
  
  
  spi_slave_final spi_slave_init(
    .sclk(sclk),
    .cs(cs),
    .mosi(mosi),
    .reset(reset),
    .miso(miso),
    .dout(slave_dout),
    .din(slave_din)
  );
  
  
endmodule

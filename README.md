# SPI-Master---Slave

## Simulate with Icarus Verilog and Surfer

```sh
iverilog -o spi_tb *.v
vvp spi_tb
surfer spi_tb.vcd
```
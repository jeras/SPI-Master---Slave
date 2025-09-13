module spi_slave_final(sclk,cs,mosi,reset,miso,dout,din);
  input sclk , cs , mosi , reset;
  input [7:0] din ;
  output wire miso ;
  output wire [7:0] dout ;
  
  
  reg [3:0] bit_count ;
  reg [7:0] tx_reg ;
  reg [7:0] rx_reg ;
  
  reg miso_en ;
  reg miso_reg ;
  assign miso = miso_en ? miso_reg : 1'bz ;
  
  reg dout_en ;
  reg [7:0]dout_reg ;
  assign dout = dout_en ? dout_reg : 1'bz ;
  
  reg frame_done ;
  
  always @(posedge sclk , posedge reset)
    begin
      if(reset)
        begin
          bit_count <= 0 ;
          rx_reg <= 8'b0 ;
          dout_en <= 1'b0 ;
          dout_reg <= 8'b0 ;
          frame_done <= 1'b0 ;
        end
      else if(!cs && !frame_done)
        begin
          rx_reg <= {rx_reg[6:0],mosi} ;
          bit_count <= bit_count + 1 ;
          if (bit_count == 7)
            begin
              dout_reg <= {rx_reg[6:0] , mosi} ;
              bit_count <= 0 ;
              frame_done <= 1'b1 ;
              dout_en <= 1'b1 ;
            end
          else
            dout_en <= 1'b0 ;
            
        end
      else
        dout_en <= 1'b0 ;      
                
    end
  
  always @(negedge sclk , posedge reset)
    begin
      if(reset)
        begin
          tx_reg <= 8'b0 ;
          miso_reg <= 1'b0 ;
          miso_en <= 1'b0 ;
        end
      else if(!cs && !frame_done)
        begin
          miso_reg <= tx_reg[7] ;
          tx_reg <= {tx_reg[6:0],1'b0} ;
          miso_en <= 1'b1 ; 
        end
      else
        miso_en <= 1'b0 ;  
    end
  
  always @(negedge cs , posedge reset)
    begin
      if(reset)
        begin
          tx_reg <= 8'b0 ;
          frame_done <= 1'b0 ;
        end
      else
        begin
          tx_reg <= din ;
          frame_done <= 1'b0 ;
        end
    end
endmodule

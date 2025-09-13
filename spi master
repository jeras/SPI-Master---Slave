module spi_master_final(clk,reset,sclk,din,miso,mosi,cs,start,dout);
  input clk, reset ; 
  input miso, start ;
  input [7:0]din ;
  output reg sclk ; 
  output reg mosi ;
  output reg cs ;
  output reg [7:0] dout ;
  
  reg [1:0] state ;
  reg [7:0] shift_reg ;
  reg [7:0] rx_reg ;
  reg [3:0] count_bit ;
  reg [3:0] clk_div ;
  
  localparam IDLE = 2'b00 , TRANSFER = 2'b01 , STOP = 2'b10;
  
  
  always @(posedge clk or posedge reset)
    begin
      if(reset)
        begin
          sclk <= 1'b0 ;
          clk_div <= 4'b0000 ;
           
        end
      else
         begin
           if (clk_div == 4'b0100)begin
             sclk <= ~sclk ;
             clk_div <= 4'b0000 ;
           end
           else
             clk_div <= clk_div + 4'b0001 ;
         end
    end
  
  always @(posedge clk or posedge reset)
    begin
      if(reset)
        begin
          state <= IDLE ;
          cs <= 1'b1 ;
          count_bit <= 4'b0000 ;
          
        end
      else
        begin
          case(state)
            IDLE :
              
              begin
                if(start)
                  begin
                    cs <= 1'b0 ;
                    shift_reg <= din ;
                    count_bit <= 4'b0000 ;
                    rx_reg <= 8'b0 ;
                    state <= TRANSFER ;
                  end
                else
                  begin
                    cs <= 1'b1 ;
                  end
              end
     
         
            STOP :
              
              begin
                state <= IDLE ; 
                dout <= rx_reg ;
                count_bit <= 4'b0000 ;
                cs <= 1'b1 ;
              end
            
          endcase
        end
    end
  
            
            
  
  always @(negedge sclk)
    begin
      if(state == TRANSFER)
        begin
          mosi <= shift_reg[7] ;
          shift_reg <= { shift_reg[6:0],1'b0 } ;
        end
    end
  
  always @(posedge sclk)
    begin
      if(state == TRANSFER)
        begin
          rx_reg <= {rx_reg[6:0],miso} ;
          count_bit <= count_bit + 1 ;
          if(count_bit == 4'd8)
            state <= STOP ;
        end
    end
  
      
  
endmodule

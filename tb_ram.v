`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 07:52:34 AM
// Design Name: 
// Module Name: tb_ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ram;

  reg clk, cs, wr_e, o_e;
  reg [7:0] addr, tb_data;
  wire [7:0] data;

  integer i;
  
  ram u0( 	
  .clk(clk),
  .addr(addr),
  .data(data),
  .cs(cs),
  .wr_e(wr_e),
  .o_e(o_e)
);
  
  
  always #10 clk = ~clk;
  assign data = !o_e ? tb_data : 'hz;
  
  initial begin
    {clk, cs, wr_e, addr, tb_data, o_e} <= 0;
    
    for (i = 0; i < 10; i= i+1) begin
      @(posedge clk) addr <= i; wr_e <= 1; cs <=1; o_e <= 0; tb_data <= $random;
    end
    
    for (i = 0; i < 10; i= i+1) begin
      @(posedge clk) addr <= i; wr_e <= 0; cs <= 1; o_e <= 1;
    end
    
    #20 $finish;
  end
endmodule

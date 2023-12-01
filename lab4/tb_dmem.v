`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/29/2023 10:33:46 PM
// Design Name: 
// Module Name: tb_dmem
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


module tb_dmem;
  reg clk, rst;
  reg [31:0] address, data_w;
  reg mem_rw;
  wire [31:0] data_r;
  integer i;
  
  dmem dmem_inst (
    .clk(clk),
    .rst(rst),
    .address(address),
    .DataW(data_w),
    .MemRW(mem_rw),
    .DataR(data_r)
  );

    always #10 clk = ~clk;
    initial begin
    {clk, mem_rw, data_w, address, rst} <= 0;
    #4; rst <= 1;
    for (i = 0; i < 10; i= i+1) begin
      @(posedge clk) address <= i; mem_rw <= 1; data_w <= $random;
    end
    
    for (i = 0; i < 10; i= i+1) begin
      @(posedge clk) address <= i; address <= 10-i; mem_rw <= 0;
    end
    
    #20 $finish;
    end
endmodule

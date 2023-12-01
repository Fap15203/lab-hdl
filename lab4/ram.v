`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2023 07:50:21 AM
// Design Name: 
// Module Name: ram
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


module ram(
  input clk,
  input cs,
  input wr_e, o_e,
  input [7:0] addr,
  input [7:0] data,
  output reg [7:0] data_r
);
  reg [7:0] tmp_data;
  reg [7:0] mem [0:127];

  always @(posedge clk) begin
    if (cs & wr_e) begin
      mem[addr] <= data;
    end
  end
  
  always @ (posedge clk) begin
    if (cs & !wr_e) begin
        tmp_data <= mem[addr];
    end
  end
  
  assign data = cs & o_e & !wr_e ? tmp_data : 'hz;
endmodule

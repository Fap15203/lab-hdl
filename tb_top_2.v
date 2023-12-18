`timescale 1ns/1ps
module tb_top_2(
);
    reg clk,rst;
    reg [31:0] instr;
    
    top top_instance(
        .clk(clk),
        .rst(rst),
      .instruction(instr) //input
    );
    initial begin
        clk <= 1'b0;
        forever #1 clk = ~clk;
    end
    initial begin
        rst = 0;
        #4 rst = 1;
    end
    initial begin
      #4;
      instruction = 32'h2109000A;
      #2;
      instruction = 32'h210A0012;
      #2;
      instruction = 32'h210B000A;
      #2;
      instruction = 32'h210C0014;
      #2;
      instruction = 32'h210D001E;
      #2;
      instruction = 32'h01494820;
      #2;
      instruction = 32'h8D4C0008;
      #2;
      instruction = 32'hAD4B000A;
      #2;
      instruction = 32'h8D4D000A;
      #2;
    end
    
endmodule

// test 1
//    addi t1 , t0,   10 
//    addi t2 , t0,   18 
//    addi t3 , t0,   10 
//    addi t4 , t0,   20 
//    addi t5 , t0,   30 
    
//    add t1, t2, t1
//	  lw t4, 8(t2)
//    sw t3, 10(t2)
//    lw t5, 10(t2) 

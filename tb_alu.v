`timescale 1ns / 1ps

module tb_alu();
    reg clk;
    reg [31:0] a, b;
    reg [2:0] f;
    wire [31:0] y;
    reg zero;   // de doc file, khong co tac dung
    reg [31:0] y_ex;
    reg [31:0] vectornum, errors;
    reg [103:0] testvectors[10000:0];
    
    alu dut(a, b, f, y);
    
    always 
        begin
            clk = 1; #5; clk = 0; #5;
        end
        
    initial 
        begin 
            $readmemh("alu_tv.mem", testvectors); //f,a,b, y_ex, zero
            vectornum = 0; errors = 0;
        end
        
    always @(negedge clk)
        begin
            #3; {zero, f, a, b, y_ex} = testvectors[vectornum];
        end
        
    always @(negedge clk) begin
            if (y == y_ex) begin 
                $display("[%d]Success: inputs: a=%h | b=%h | f=%h",vectornum, a, b, f);
                $display("      outputs: y=%h | y_ex=%h | zero=%b", y, y_ex, zero);
            end
            else if (y !== y_ex) begin
                $display("[%d]Error: inputs: a=%h | b=%h | f=%h", vectornum, a, b, f);
                $display("      outputs: y=%h | y_ex=%h | zero=%b", y, y_ex, zero);
                errors = errors + 1;
            end
            vectornum = vectornum + 1;
            if (testvectors[vectornum] === 104'bx) begin
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;
            end
    end
endmodule

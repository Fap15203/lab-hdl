module imem(
    input [31:0] address,
    output  [31:0] RD
);
    reg [31:0] A [0:63];
    assign  RD = A[address>>2]  ;

    initial begin
        $readmemh ("instr_file.mem", A);
    end
    
endmodule 
`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    input [31:0] instr,
    output iszero,
    //control signal
    input [4:0] alu_control,
    input RegDst, RegWrite, ALUsrc, MemWrite, MemRead, MemToReg
    );
    wire [31:0] rd1, rd2, imm, B_alu, alu_result, mem, wd;
    wire [4:0] wr_addr;
    
    reg_file register_file (
        .clk(clk),
        .rst(rst),
        .A1(instr[25:21]),
        .A2(instr[20:16]),
        .A3(wr_addr),
        .WD3(wd),
        .WE3(reg_write_en),
        .RD1(rd1),
        .RD2(rd2)
    );
    imm_gen sign_exten (
        .instr(instr[15:0]),
        .imm_out(imm)
    );
    mux muxB (
        .a(rd2),
        .b(imm),
        .c(B_alu),
        .s(ALUsrc)
    );
    alu ALU (
        .A(rd1),
        .B(B_alu),
        .alu_control(alu_control),
        .alu_result(alu_result),
        .is0(iszero)
    );
    dmem data_mem (
        .clk(clk),
        .rst(rst),
        .address(alu_result),
        .MemRW(MemWrite),
        .DataR(mem),
        .DataW(rs2)
    );
    mux muxC (
        .a(mem),
        .b(alu_result),
        .s(MemToReg),
        .c(wd)
    );
endmodule

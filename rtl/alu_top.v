`timescale 1ns/1ps

module alu_top
#(
    parameter WIDTH = 32
)
(
    input                   rst_n,

    input  [WIDTH-1:0]      A,
    input  [WIDTH-1:0]      B,

    input  [3:0]            opcode,

    output [WIDTH-1:0]      RESULT,

    output                  CARRY,
    output                  OVERFLOW,
    output                  ZERO,
    output                  NEGATIVE,
    output                  LESS,
    output                  EQUAL
);

wire add_en;
wire sub_en;
wire and_en;
wire or_en;
wire xor_en;
wire xnor_en;
wire nand_en;
wire nor_en;
wire not_en;
wire sll_en;
wire srl_en;
wire sra_en;
wire rol_en;
wire ror_en;
wire slt_en;
wire cmp_en;

wire [WIDTH-1:0] result_int;

wire carry_int;
wire overflow_int;
wire zero_int;
wire negative_int;
wire less_int;
wire equal_int;

alu_decoder DECODER
(
    .opcode(opcode),

    .add_en(add_en),
    .sub_en(sub_en),
    .and_en(and_en),
    .or_en(or_en),
    .xor_en(xor_en),
    .xnor_en(xnor_en),
    .nand_en(nand_en),
    .nor_en(nor_en),
    .not_en(not_en),
    .sll_en(sll_en),
    .srl_en(srl_en),
    .sra_en(sra_en),
    .rol_en(rol_en),
    .ror_en(ror_en),
    .slt_en(slt_en),
    .cmp_en(cmp_en)
);

alu_core
#(
    .WIDTH(WIDTH)
)
CORE
(
    .A(A),
    .B(B),

    .add_en(add_en),
    .sub_en(sub_en),
    .and_en(and_en),
    .or_en(or_en),
    .xor_en(xor_en),
    .xnor_en(xnor_en),
    .nand_en(nand_en),
    .nor_en(nor_en),
    .not_en(not_en),
    .sll_en(sll_en),
    .srl_en(srl_en),
    .sra_en(sra_en),
    .rol_en(rol_en),
    .ror_en(ror_en),
    .slt_en(slt_en),
    .cmp_en(cmp_en),

    .RESULT(result_int),

    .CARRY(carry_int),
    .OVERFLOW(overflow_int),
    .ZERO(zero_int),
    .NEGATIVE(negative_int),
    .LESS(less_int),
    .EQUAL(equal_int)
);

assign RESULT = (rst_n) ? result_int : {WIDTH{1'b0}};

assign CARRY = (rst_n) ? carry_int : 1'b0;

assign OVERFLOW = (rst_n) ? overflow_int : 1'b0;

assign ZERO = (rst_n) ? zero_int : 1'b0;

assign NEGATIVE = (rst_n) ? negative_int : 1'b0;

assign LESS = (rst_n) ? less_int : 1'b0;

assign EQUAL = (rst_n) ? equal_int : 1'b0;

endmodule

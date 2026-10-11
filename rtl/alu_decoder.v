`timescale 1ns/1ps

module alu_decoder
(
    input  [3:0] opcode,

    output reg add_en,
    output reg sub_en,
    output reg and_en,
    output reg or_en,
    output reg xor_en,
    output reg xnor_en,
    output reg nand_en,
    output reg nor_en,
    output reg not_en,
    output reg sll_en,
    output reg srl_en,
    output reg sra_en,
    output reg rol_en,
    output reg ror_en,
    output reg slt_en,
    output reg cmp_en
);

always @(*)
begin

    add_en  = 1'b0;
    sub_en  = 1'b0;
    and_en  = 1'b0;
    or_en   = 1'b0;
    xor_en  = 1'b0;
    xnor_en = 1'b0;
    nand_en = 1'b0;
    nor_en  = 1'b0;
    not_en  = 1'b0;
    sll_en  = 1'b0;
    srl_en  = 1'b0;
    sra_en  = 1'b0;
    rol_en  = 1'b0;
    ror_en  = 1'b0;
    slt_en  = 1'b0;
    cmp_en  = 1'b0;

    case(opcode)

        4'b0000 : add_en  = 1'b1;
        4'b0001 : sub_en  = 1'b1;
        4'b0010 : and_en  = 1'b1;
        4'b0011 : or_en   = 1'b1;
        4'b0100 : xor_en  = 1'b1;
        4'b0101 : xnor_en = 1'b1;
        4'b0110 : nand_en = 1'b1;
        4'b0111 : nor_en  = 1'b1;
        4'b1000 : not_en  = 1'b1;
        4'b1001 : sll_en  = 1'b1;
        4'b1010 : srl_en  = 1'b1;
        4'b1011 : sra_en  = 1'b1;
        4'b1100 : rol_en  = 1'b1;
        4'b1101 : ror_en  = 1'b1;
        4'b1110 : slt_en  = 1'b1;
        4'b1111 : cmp_en  = 1'b1;

        default :
        begin
        end

    endcase

end

endmodule

`timescale 1ns/1ps

module alu_core
#(
    parameter WIDTH = 32
)
(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,

    input add_en,
    input sub_en,
    input and_en,
    input or_en,
    input xor_en,
    input xnor_en,
    input nand_en,
    input nor_en,
    input not_en,
    input sll_en,
    input srl_en,
    input sra_en,
    input rol_en,
    input ror_en,
    input slt_en,
    input cmp_en,

    output reg [WIDTH-1:0] RESULT,

    output reg CARRY,
    output reg OVERFLOW,
    output reg ZERO,
    output reg NEGATIVE,
    output reg LESS,
    output reg EQUAL
);

reg [WIDTH:0] temp;

always @(*)
begin

    RESULT   = {WIDTH{1'b0}};
    CARRY    = 1'b0;
    OVERFLOW = 1'b0;
    ZERO     = 1'b0;
    NEGATIVE = 1'b0;
    LESS     = 1'b0;
    EQUAL    = 1'b0;

    if(add_en)
    begin
        temp = A + B;

        RESULT = temp[WIDTH-1:0];
        CARRY  = temp[WIDTH];

        OVERFLOW =
            (~A[WIDTH-1] & ~B[WIDTH-1] & RESULT[WIDTH-1]) |
            ( A[WIDTH-1] &  B[WIDTH-1] & ~RESULT[WIDTH-1]);
    end

    else if(sub_en)
    begin
        temp = A - B;

        RESULT = temp[WIDTH-1:0];
        CARRY  = temp[WIDTH];

        OVERFLOW =
            (~A[WIDTH-1] & B[WIDTH-1] & RESULT[WIDTH-1]) |
            ( A[WIDTH-1] & ~B[WIDTH-1] & ~RESULT[WIDTH-1]);
    end

    else if(and_en)
        RESULT = A & B;

    else if(or_en)
        RESULT = A | B;

    else if(xor_en)
        RESULT = A ^ B;

    else if(xnor_en)
        RESULT = ~(A ^ B);

    else if(nand_en)
        RESULT = ~(A & B);

    else if(nor_en)
        RESULT = ~(A | B);

    else if(not_en)
        RESULT = ~A;

    else if(sll_en)
        RESULT = A << B[4:0];

    else if(srl_en)
        RESULT = A >> B[4:0];

    else if(sra_en)
        RESULT = $signed(A) >>> B[4:0];

    else if(rol_en)
        RESULT = (A << B[4:0]) | (A >> (WIDTH-B[4:0]));

    else if(ror_en)
        RESULT = (A >> B[4:0]) | (A << (WIDTH-B[4:0]));

    else if(slt_en)
    begin
        if($signed(A) < $signed(B))
        begin
            RESULT = 32'd1;
            LESS = 1'b1;
        end
        else
        begin
            RESULT = 32'd0;
            LESS = 1'b0;
        end
    end

    else if(cmp_en)
    begin
        if(A==B)
        begin
            RESULT = 32'd1;
            EQUAL = 1'b1;
        end
        else
        begin
            RESULT = 32'd0;
            EQUAL = 1'b0;
        end
    end

    ZERO = (RESULT==0);
    NEGATIVE = RESULT[WIDTH-1];

end

endmodule

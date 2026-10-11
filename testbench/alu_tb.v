`timescale 1ns/1ps

module alu_tb;

parameter WIDTH = 32;

//-------------------------------------------------
// Testbench Signals
//-------------------------------------------------

reg                 rst_n;

reg  [WIDTH-1:0]    A;
reg  [WIDTH-1:0]    B;

reg  [3:0]          opcode;

wire [WIDTH-1:0]    RESULT;

wire                CARRY;
wire                OVERFLOW;
wire                ZERO;
wire                NEGATIVE;
wire                LESS;
wire                EQUAL;

//-------------------------------------------------
// Device Under Test
//-------------------------------------------------

alu_top
#(
    .WIDTH(WIDTH)
)
DUT
(
    .rst_n(rst_n),

    .A(A),
    .B(B),

    .opcode(opcode),

    .RESULT(RESULT),

    .CARRY(CARRY),
    .OVERFLOW(OVERFLOW),
    .ZERO(ZERO),
    .NEGATIVE(NEGATIVE),
    .LESS(LESS),
    .EQUAL(EQUAL)
);

//-------------------------------------------------
// Test Counter
//-------------------------------------------------

integer pass_count;
integer fail_count;

//-------------------------------------------------
// Display Task
//-------------------------------------------------

task display_result;

begin

$display("---------------------------------------------");
$display("TIME      = %0t",$time);

$display("A         = %h",A);
$display("B         = %h",B);

$display("OPCODE    = %b",opcode);

$display("RESULT    = %h",RESULT);

$display("CARRY     = %b",CARRY);
$display("OVERFLOW  = %b",OVERFLOW);
$display("ZERO      = %b",ZERO);
$display("NEGATIVE  = %b",NEGATIVE);
$display("LESS      = %b",LESS);
$display("EQUAL     = %b",EQUAL);

$display("---------------------------------------------");

end

endtask

//-------------------------------------------------
// Reset Task
//-------------------------------------------------

task reset_dut;

begin

rst_n = 0;

A = 0;
B = 0;
opcode = 0;

#20;

rst_n = 1;

#20;

end

endtask

//-------------------------------------------------
// Apply Input Task
//-------------------------------------------------

task apply_input;

input [WIDTH-1:0] inA;
input [WIDTH-1:0] inB;
input [3:0]       op;

begin

    A = inA;
    B = inB;
    opcode = op;

    #10;

    display_result;

end

endtask
//-------------------------------------------------
// Simulation
//-------------------------------------------------

initial
begin

    $dumpfile("alu.vcd");
    $dumpvars(0,alu_tb);

    pass_count = 0;
    fail_count = 0;

    $display("");
    $display("=========================================");
    $display("      PARAMETERIZED ALU SIMULATION");
    $display("=========================================");
    $display("");

    reset_dut;


//-------------------------------------------------
// ADD
//-------------------------------------------------

apply_input(32'd15,
            32'd20,
            4'b0000);

//-------------------------------------------------
// SUB
//-------------------------------------------------

apply_input(32'd100,
            32'd50,
            4'b0001);

//-------------------------------------------------
// AND
//-------------------------------------------------

apply_input(32'hFFFF0000,
            32'h0F0F0F0F,
            4'b0010);

//-------------------------------------------------
// OR
//-------------------------------------------------

apply_input(32'hAAAA0000,
            32'h0000BBBB,
            4'b0011);

//-------------------------------------------------
// XOR
//-------------------------------------------------

apply_input(32'h12345678,
            32'hFFFFFFFF,
            4'b0100);

//-------------------------------------------------
// XNOR
//-------------------------------------------------

apply_input(32'hAAAAAAAA,
            32'h55555555,
            4'b0101);

//-------------------------------------------------
// NAND
//-------------------------------------------------

apply_input(32'hFFFFFFFF,
            32'h0000FFFF,
            4'b0110);

//-------------------------------------------------
// NOR
//-------------------------------------------------

apply_input(32'h0000FFFF,
            32'hFFFF0000,
            4'b0111);

//-------------------------------------------------
// NOT
//-------------------------------------------------

apply_input(32'hAAAAAAAA,
            32'h00000000,
            4'b1000);

//-------------------------------------------------
// SHIFT LEFT
//-------------------------------------------------

apply_input(32'h00000001,
            32'd5,
            4'b1001);

//-------------------------------------------------
// SHIFT RIGHT
//-------------------------------------------------

apply_input(32'h00000020,
            32'd5,
            4'b1010);

//-------------------------------------------------
// ARITHMETIC SHIFT
//-------------------------------------------------

apply_input(32'h80000000,
            32'd3,
            4'b1011);
apply_input(32'hFFFFFFFF,
            32'hFFFFFFFF,
            4'b1111);

#20;

$display("");
$display("=========================================");
$display("      SIMULATION COMPLETED");
$display("=========================================");

end

endmodule

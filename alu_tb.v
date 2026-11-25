/**************************************************************************************
Name: Sami Aljabery
File: alu_tb.v
Date: 11/23/2026
Description: This is a testbench for the ALU. 
**************************************************************************************/

`timescale 1ns/1ps 

module alu_tb; 
reg [31:0] rs1, rs2; //set the operands, control signal, and output
reg [2:0] ctrl; 
wire [31:0] alu_out; 

integer test = 0; 
integer error = 0; 

alu dut (.rs1(rs1), .rs2(rs2), .control(ctrl), .alu_res(alu_out)); //DUT for ALU

//Use the task to create a loop for testing the 8 opcodes. With task, we have placements for the two operands, 
// the control signal, what the expected is, and a unique way to print the label of the test. 
task check(input [31:0] opA, input [31:0] opB, input [2:0] ctrl_op, input [31:0] expected_in, input [8*24:1] label);
begin 
    rs1 = opA; //set the operands and controls to the original, so it can be reused
    rs2 = opB; 
    ctrl = ctrl_op; 

    #10; 

    test += test + 1; //increment for a test passing 
    if(alu_out != expected_in) begin 
        error += error + 1; 
        $display("FAIL %-22s opA=%h opB=%h Actual=%h Expected=%h", label, opA, opB, alu_out, expected_in); 
    end else 
        $display("PASS %-22s opA=%h opB=%h Result=%h", label, opA, opB, alu_out); 
    end
endtask

initial begin 
    rs1 = 0; //always initialize to zero, no clock signal needed for ALU to set to 0 or reset
    rs2 = 0; 
    ctrl = 0; 

    $dumpfile("alu.vcd"); 
    $dumpvars(0, alu_tb); 
    //ADD
    check(32'd4, 32'd6, 3'b000, 32'd10, "ADD Operation");
    //SLL
    //SLT
    //SLTU
    //XOR
    //SRL
    //OR
    //AND
    $display("****************************************************************************");
    if (error == 0) $display("All %0d tests passed!", test); 
    else $display("%0d of %0d tests failed.", error, test); 
    $finish;
end
endmodule


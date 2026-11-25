/**************************************************************************************
Name: Sami Aljabery
File: alu.v
Date: 11/23/2026
Description: Starting with single cycle RV32I, the plan is to start with 8 intructions. 
The 10 instructions are ADD, SLL, SLT, SLTU, XOR, SRL, OR, and AND. 
**************************************************************************************/

module alu(input [31:0] rs1, rs2, //Two inputs
           input [2:0] control,   //Control signal to determine opcode operation, it is just func3 for now
           output reg [31:0] alu_res  //the combined result 
           ); 

        always@(*) begin 
            case(control)
            3'b000: alu_res = rs1 + rs2; //ADD operation
            3'b001: alu_res = rs1 << rs2[4:0]; //SLL operation (Shift Left Logical)
            3'b010: alu_res = $signed(rs1) < $signed(rs2); //STL (Set Less Than Signed)
            3'b011: alu_res = rs1 < rs2; //STLU (Set Less Than Unsigned)
            3'b100: alu_res = rs1 ^ rs2; //XOR operation 
            3'b101: alu_res = rs1 >> rs2[4:0]; //SRL operation (Shift Right Logical)
            3'b110: alu_res = rs1 | rs2; //OR operation
            3'b111: alu_res = rs1 & rs2; //AND operation
            default: alu_res = 32'd0; //The default case in this scenario will always be zero
            endcase 
        end
endmodule

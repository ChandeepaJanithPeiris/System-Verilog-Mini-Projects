module ALU (
    input logic [15:0] in1,in2,
    input logic sel, // sel 1 = addition , 0 = subtraction
    output logic [15:0] out
);
    assign out = sel ? in1+in2 : in1 -in2;
    
endmodule
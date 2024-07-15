module FIR_filter #(parameter N = 16)
(
    input logic clk,rst,
    input logic [N-1:0] data_in,
    output logic [N-1:0] data_out

);

// intermediate logic
logic [5:0] b0,b1,b2,b3;
logic [N-1:0] x1,x2,x3;
logic [N-1:0] Mul0,Mul1,Mul2,Mul3;
logic [N-1:0] sum;


//coefficents

///Moving Average Filter, 3rd order filter (for a moving average filter all the coeffiecnts are same)
//four coefficents; 1/(order+1)=1/4 = 0.25
// 0.25*128(scalling factor) = 32 = 6'b10000 

assign b0 = 6'b100000;
assign b1 = 6'b100000;
assign b2 = 6'b100000;
assign b3 = 6'b100000;


//delays i.e x[n-1],x[n-2],...x[n-N]
//Instantiate D flipflips for delays

//x[n-1]
DFF delay_1(
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(x1)
);

//x[n-2]
DFF delay_2(
    .clk(clk),
    .rst(rst),
    .data_in(x1),
    .data_out(x2)
);

//x[n-3]
DFF delay_3(
    .clk(clk),
    .rst(rst),
    .data_in(x2),
    .data_out(x3)
);

//Multiplication
always_comb begin
    Mul0 = data_in * b0;
    Mul1 = x1 * b0;
    Mul2 = x2 * b0;
    Mul3 = x3 * b0;
    
end


//addition
assign  sum = Mul0 + Mul1 + Mul2 + Mul3;


//final output
always_ff @(posedge clk ) begin
    data_out <= sum;
end

endmodule

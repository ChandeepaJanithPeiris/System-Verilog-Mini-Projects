
// dff delays the input signal
module DFF #(parameter N = 16) 
(
    input logic [N-1:0] data_in,
    input logic clk,rst,
    output logic [N-1:0] data_out
);

always_ff @( posedge clk ,posedge rst ) begin
    if (rst) data_out <= data_in;
    else data_out <= data_in;
end
    
endmodule
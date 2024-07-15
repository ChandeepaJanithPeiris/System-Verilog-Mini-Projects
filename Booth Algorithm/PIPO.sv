module PIPO (
    input logic [15:0] data_in,
    input logic load,clk,
    output logic [15:0] data_out
);
    always_ff @( posedge clk ) begin
        if (load) data_out <= data_in;    
    end
    
endmodule
module dff (
    input logic [15:0] data_in,
    input logic clk,clear,
    output logic [15:0] data_out
);
    always_ff @( posedge clk ) begin
        if(clear) data_out <= 0;
        else data_out <= data_out;
    end
    
endmodule
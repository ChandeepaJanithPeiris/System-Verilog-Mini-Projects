module shiftReg (
    input logic [15:0] data_in,
    input logic load,clear,shift,s_in,clk,
    output logic [15:0] data_out
);

    always_ff @( posedge clk ) begin
        if(clear) data_out <= 0;
        else if (load) data_out <= data_in;
        else if (shift) data_out <= {s_in,data_in[15:1]};
    end
    
endmodule
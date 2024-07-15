module counter
(
    input logic load,decr,clk,
    output logic [4:0] count
);
    always_ff @( posedge clk ) begin
        if(load) count <= 5'b10000;
        else if (decr) count <= count -1;
    end

endmodule
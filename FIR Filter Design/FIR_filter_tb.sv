`timescale 1ns/1ps

module FIR_filter_tb;
    parameter N = 16;
    
    logic clk, rst;
    logic [N-1:0] data_in;
    logic [N-1:0] data_out;

    //instantiation
    FIR_filter FIR (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_out(data_out)
    );

    //input sine wave data

    //create RAM
    logic [N-1:0] data [31:0];

    initial begin
        $readmemb("signal.data", data);
    end

    //clk
    initial clk = 0;
    always #10 clk = ~clk;

    //Address counter
    logic [4:0] Address;

    // Initialization block for Address
    initial begin
        Address = 5'b00000;
        rst = 1; 
        #20 rst = 20;
    end

    // Sequential logic block to update Address
    always @(posedge clk) begin
        if (Address == 5'b11111)
            Address <= 5'b00000;
        else
            Address <= Address + 5'b00001;
    end
    
    //apply stored data and give to the design
    always_ff @(posedge clk) begin
        if (~rst) data_in <= data[Address];
    end

endmodule

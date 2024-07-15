module Booth_datapath (
    input logic [15:0] data_in,
    input logic ldM,ldA,clrA,sftA,ldQ,clrQ,sftQ,sel_addSub,decr,ldcnt,clrff,clk,
    output logic qm1,eqz
);
    logic [15:0] A,M,Q,Z;
    logic [4:0] count ;

    assign eqz = count ? 0 : 1;   

    shiftReg SR_A (
        .data_in(Z),
        .load(ldA),
        .clear(clrA),
        .shift(sftA),
        .s_in(A[15]),
        .clk(clk),
        .data_out(A)
    );

    shiftReg SR_Q(
        .data_in(data_in),
        .load(ldQ),
        .clear(clA),
        .shift(sftA),
        .s_in(A[0]),
        .clk(clk),
        .data_out(Q)
    );

    PIPO reg_M(
        .data_in(data_in),
        .load(ldM),
        .clk(clk),
        .data_out(data_out)
    );

    dff QM1(
        .data_in(Q[0]),
        .clk(clk),
        .clear(clrff),
        .data_out(qm1)
    );

    ALU AddSub(
        .in1(A),
        .in2(B),
        .sel(sel_addSub),
        .out(Z)
    );

    counter CN(
        .load(ldcnt),
        .decr(decr),
        .clk(clk),
        .count(count)
    );
    
    
endmodule
module Booth_tb;
    logic [15:0] data_in;
    logic clk,start, done;

    Booth_datapath DP(
        .data_in(data_in),
        .ldM(ldM),
        .ldA(ldA),
        .clrA(clrA),
        .sftA(sftA),
        .ldQ(ldQ),
        .clrQ(clrQ),
        .sftQ(sftQ),
        .sel_addSub(sel_addSub),
        .decr(decr),
        .ldcnt(ldcnt),
        .clrff(clrff),
        .clk(clk),
        .qm1(qm1),
        .eqz(eqz)
    );

    Booth_controller CON(
        .start(start),
        .q0(q0),
        .qm1(qm1),
        .ldA(ldA),
        .clrA(clrA),
        .sftA(sftA),
        .ldQ(ldQ),
        .clrQ(clrQ),
        .sftQ(sftQ),
        .ldM(ldM),
        .clrff(clrff),
        .sel_addSub(sel_addSub),
        .decr(decr),
        .ldcnt(ldcnt),
        .done(done)
    );

    initial begin
        clk = 1'b0;
        #3 start = 1'b1;
    end

    always #5 clk = ~ clk;

    initial begin
        #12 data_in = 32;
        #10 data_in = -12;
    end
    
    initial begin
        begin
            $monitor ($time,"%d",done);
        end
    end


endmodule
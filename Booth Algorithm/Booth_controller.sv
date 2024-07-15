module Booth_controller (
    input logic start,clk,q0,qm1,
    output logic ldA,clrA,sftA,ldQ,clrQ,sftQ,ldM,clrff,sel_addSub,decr,ldcnt,done
);
    logic [2:0] state;
    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100, s5 = 3'b101, s6 = 3'b110 ;

    always_ff @( posedge clk ) begin
        case (state)
            s0 : if (start) state <= s1;
            s1 : state <= s2;
            s2 : 
                begin
                    if ({q0,qm1} == 2'b01) state <= s3;
                    else if ({q0,qm1} == 2'b10) state  <= s4;
                    else if ({q0,qm1} == 2'b00) state <= s5;
                end
            s3: state <= s5;
            s4: state <= s5;
            s5:
                begin
                    if ({q0,qm1} == 2'b01) state <= s3;
                    else if ({q0,qm1} == 2'b10) state  <= s4;
                    else if ({q0,qm1} == 2'b00) state <= s6;
                end
            s6: state <= s6;
            default: state <= s0;
        endcase
      end
    
    always_ff @(state) begin
        case (state)
            s0 : 
                begin
                    clrA = 0;
                    ldA = 0;
                    sftA = 0;
                    clrQ = 0;
                    ldQ = 0;
                    sftQ = 0;
                    ldM = 0;
                    clrff = 0;
                    done = 0;
                end 
            
            s1:
                begin
                    clrA = 1;
                    clrff = 1;
                    ldcnt = 1;
                    ldM = 1;
                end
            
            s2:
                begin
                    clrA = 0;
                    clrff = 0;
                    ldcnt = 0;
                    ldM = 0;
                    ldQ = 1;
                end
            
            s3:
                begin
                    ldA = 1;
                    sel_addSub = 1;
                    ldQ  = 0;
                    sftA = 0 ;
                    sftQ = 0 ;
                    decr = 0;
                end

            s4:
                begin
                    ldA = 1;
                    sel_addSub = 0;
                    ldQ  = 0;
                    sftA = 0 ;
                    sftQ = 0 ;
                    decr = 0;
                end
            
            s5:
                begin
                    sftA = 1;
                    sftQ = 1;
                    ldA = 0;
                    ldQ = 0;
                    decr = 1;
                end

            s6: done = 1;
            default: 
                begin
                    clrA = 0;
                    ldA = 0;
                    sftA = 0;
                    clrQ = 0;
                    ldQ = 0;
                    sftQ = 0;
                    ldM = 0;
                    clrff = 0;
                    done = 0;
                end 
        endcase
    end
    
endmodule
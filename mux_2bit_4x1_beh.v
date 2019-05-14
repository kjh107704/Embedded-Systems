
module Mux_4x1_2bit_beh(A1, A0, B1, B0,C1,C0,D1,D0,S1,S0,Out1,Out2);
    input A1,A0;
    input B1,B0;
    input C1,C0;
    input D1,D0;
    input S1,S0;
    output Out1,Out2;
    reg Out1,Out2;

    always @*
    begin
        if(S1==0&&S0==0)
        begin
            Out1<=A1; Out2<=A0;
        end
        else if(S1==0&&S0==1)
        begin
            Out1<=B1; Out2<=B0;
        end
        else if(S1==1&&S0==0)
        begin
            Out1<=C1; Out2<=C0;
        end
        else
        begin
            Out1<=D1; Out2<=D0;
        end
    end
endmodule

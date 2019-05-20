module Shifter_Amount_1(SH_DIR,SH_AMT,D_IN,D_OUT);
    input SH_DIR;
    input [4:0]SH_AMT;
    input [31:0]D_IN;
    output reg[31:0]D_OUT;

    always @(SH_DIR,SH_AMT,D_IN)
        begin
            if(SH_AMT[0]==1)
            begin
                if(SH_DIR==1'b1)    //shift-right
                    begin
                        D_OUT <= D_IN/2;
                        D_OUT[31] <= {1{D_IN[31]}};
                    end
                else                //shift-left
                    begin
                        D_OUT <= D_IN*2;
                    end
            end
            else
                D_OUT<=D_IN;
        end
endmodule
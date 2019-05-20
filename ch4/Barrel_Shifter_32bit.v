
module Barrel_Shifter(SH_DIR,SH_AMT,D_IN,D_OUT);
    input SH_DIR;
    input [4:0]SH_AMT;
    input [31:0]D_IN;
    output [31:0]D_OUT;

    wire [31:0]N1,N2,N3,N4;

    Shifter_Amount_16 Shifter_16(SH_DIR,SH_AMT,D_IN,N1);
    Shifter_Amount_8 Shifter_8(SH_DIR,SH_AMT,N1,N2);
    Shifter_Amount_4 Shifter_4(SH_DIR,SH_AMT,N2,N3);
    Shifter_Amount_2 Shifter_2(SH_DIR,SH_AMT,N3,N4);
    Shifter_Amount_1 Shifter_1(SH_DIR,SH_AMT,N4,D_OUT);

endmodule
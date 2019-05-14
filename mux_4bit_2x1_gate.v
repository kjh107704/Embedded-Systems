
module Mux2_4b(A3,A2,A1,A0,
		B3,B2,B1,B0,
		S0,
		C3,C2,C1,C0);
	input A3,A2,A1,A0;
	input B3,B2,B1,B0;
	input S0;
	output C3,C2,C1,C0;

	Mux2 Mux2_3 (B3,A3,S0,C3);
	Mux2 Mux2_2 (B2,A2,S0,C2);
	Mux2 Mux2_1 (B1,A1,S0,C1);
	Mux2 Mux2_0 (B0,A0,S0,C0);
endmodule

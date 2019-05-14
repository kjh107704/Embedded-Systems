module Mux2(I1, I0, S0, D);
	input I1, I0;
	input S0;
	output D;

	wire N1, N2, N3;

	Inv Inv_1(S0, N1);
	And2 And2_1(I0, N1, N2);
	And2 And2_2(I1, S0, N3);
	Or2 Or2_1(N2, N3, D);
endmodule

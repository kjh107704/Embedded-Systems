
module Or2(X,Y,F);
	input X,Y;
	output F;
	reg F;

	always @(X,Y) begin
		F<=X|Y;
	end
endmodule

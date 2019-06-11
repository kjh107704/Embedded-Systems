module SAD(Go, A_Addr, A_Data,B_Addr, B_Data,C_Addr, I_RW,I_En, O_RW,O_En,Done,SAD_Out, Clk, Rst);

input Go;
input [7:0] A_Data,B_Data;
output reg [14:0] A_Addr,B_Addr;
output reg [6:0] C_Addr;
output reg I_RW,I_En,O_RW,O_En,Done;
output reg [31:0] SAD_Out;
input Clk,Rst;

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3a = 3'b011, S3 = 3'b100, S4 = 3'b101, S5 = 3'b110;
reg [2:0] State;
reg[31:0] Sum;
integer I, J, K;

function [14:0] ABSDiff;
    input [14:0] A;
    input [14:0] B;
    if(A>B)
    begin
        ABSDiff = A - B;
    end
    else
    begin
       ABSDiff = B - A; 
    end
endfunction

always @(posedge Clk)
begin

   if(Rst == 1'b1)
   begin
      A_Addr <= {15{1'b0}};
      B_Addr <= {15{1'b0}};
      I_RW <= 1'b0;
      I_En <= 1'b0;
      C_Addr <= {6{1'b0}};
      O_RW <= 1'b0;
      O_En <= 1'b0;
      Done <= 1'b0;
      State <= S0;
      Sum <= 32'b0;
      SAD_Out <= 32'b0;
      I <= 0; J <= 0; K <= 0;
   end 
   else
   begin
       A_Addr <= {15{1'b0}};
       B_Addr <= {15{1'b0}};
       I_RW <= 1'b0;
       I_En <= 1'b0;
       C_Addr <= {6{1'b0}};
       O_RW <= 1'b0;
       O_En <= 1'b0;
       Done <= 1'b0;
       SAD_Out <= 32'b0;
       
       case(State)
            S0:begin
                if(Go == 1'b1)
                    State <= S1;
                    //교수님은 여기서 I,J,K 에 0을 non-blocking assign하셨음 왜지
                else
                    State <= S0;
            end
            S1:begin
               Sum <= 32'b0;
               J <= 0;
               State <= S2; 
            end
            S2:begin
               if(!(J==256))
               begin
                    State <= S3a;
                    A_Addr <= I;
                    B_Addr <= I;
                    I_RW <= 1'b0;
                    I_En <= 1'b1;
               end
               else
                    State <= S4;
            end
            S3a:begin
               State <= S3; 
            end
            S3:begin
               Sum <= Sum + ABSDiff(A_Data,B_Data);
               I = I + 1;
               J = J + 1;
               State <= S2; 
            end
            S4:begin
                SAD_Out <= Sum;
                C_Addr <= K;
                K = K + 1;
                O_RW <= 1'b1;
                O_En <= 1'b1;
                if(!(I==32768))
                begin
                    State <= S1;
                end
                else
                begin
                    State <= S5;
                    //교수님은 여기에 Done <= 1'b1; State <= S0; 있음
                end
            end
            S5:begin
                Done <= 1'b1;
                State <= S0;
            end
       endcase
   end
end
endmodule
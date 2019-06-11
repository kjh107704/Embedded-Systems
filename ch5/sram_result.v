module Sram_Result(Data_In, Data_Out, Addr, RW, En, Clk, Rst);
input [6:0]Addr;
input RW;
input En;
input Clk;
input Rst;
input [31:0] Data_In;
output reg[31:0]Data_Out;
reg [31:0] Memory [0:(2**7-1)];
integer Index;

always @(posedge Clk)
begin
   Data_Out <= 32'b0;

   if(Rst == 1)
   begin
      for(Index = 0; Index < (2**7); Index = Index + 1)
      begin
         Memory[Index] <= 32'b0;
      end
   end
   else if(En == 1'b1 && RW == 1'b1) //write operation
   begin
      Memory[Addr] <= Data_In; 
   end
   else if(En == 1'b1 && RW == 1'b0) //read operation
   begin
      Data_Out <= Memory[Addr]; 
   end
end

endmodule
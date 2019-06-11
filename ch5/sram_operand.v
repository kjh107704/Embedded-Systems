module Sram_Operand(Data_In, Data_Out, Addr, RW, En, Clk, Rst);

input [14:0]Addr;
input RW;
input En;
input Clk;
input Rst;
input [7:0] Data_In;
output reg [7:0] Data_Out;
reg [7:0] Memory [0:(2**15-1)];
integer Index;

always @(posedge Clk)
begin
    Data_Out <= 8'b0;

    if(Rst==1)
    begin
        for(Index = 0; Index < (2**15); Index = Index + 1)
        begin
           Memory[Index] <= 8'b0; 
        end
    end
    else if (En == 1'b1 && RW == 1'b1) //write operation
    begin
       Memory[Addr] <= Data_In; 
    end
    else if(En == 1'b1 && RW == 1'b0) //read operation
    begin
       Data_Out <= Memory[Addr]; 
    end
end

endmodule
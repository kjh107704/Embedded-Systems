module Testbench();

    reg Go_s;
    wire[14:0] A_Addr_s, B_Addr_s;
    wire[7:0] A_Data_s, B_Data_s, A_Di_s, B_Di_s;
    wire[6:0] C_Addr_s;
    wire[31:0] C_Data_s;
    wire I_RW_s, I_En_s, O_RW_s, O_En_s, Done_s;
    reg Clk_s, Rst_s, Rst_m;
    wire[31:0] SAD_Out_s;
    reg [31:0] SW_Result_Memory[0:(2**7-1)];
    integer Index;

    parameter ClkPeriod = 20;

    SAD CompToTest(Go_s, A_Addr_s, A_Data_s, B_Addr_s, B_Data_s, C_Addr_s, I_RW_s, I_En_s, O_RW_s, O_En_s, Done_s, SAD_Out_s, Clk_s,Rst_s);
    Sram_Operand SADMemA(A_Di_s, A_Data_s, A_Addr_s, I_RW_s, I_En_s, Clk_s, Rst_m);
    Sram_Operand SADMemB(B_Di_s, B_Data_s, B_Addr_s, I_RW_s, I_En_s, Clk_s, Rst_m);
    Sram_Result SADResult(SAD_Out_s, C_Data_s, C_Addr_s, O_RW_s, O_En_s, Clk_s, Rst_m);

    //clock procedure
    always begin
        Clk_s <= 1'b0; #(ClkPeriod/2);
        Clk_s <= 1'b1; #(ClkPeriod/2); 
    end

    //Initialize Arrays
    initial $readmemh("MemA.txt", SADMemA.Memory);
    initial $readmemh("MemB.txt", SADMemB.Memory);
    initial $readmemh("sw_result.txt",SW_Result_Memory);

    //Vector Procedure
    initial begin
       Rst_m <= 1'b0; Rst_s <= 1'b1; Go_s <= 1'b0;
       @(posedge Clk_s);
       Rst_s <= 1'b0; Go_s <= 1'b1;
       @(posedge Clk_s);
       Go_s <= 1'b0;
       @(posedge Clk_s);
       while(Done_s != 1'b1)
            @(posedge Clk_s);

        //교수님은 여기에 클락이 한번 더 있음

        for(Index = 0; Index < (2**7); Index = Index + 1)
        begin
            if(SW_Result_Memory[Index]==SADResult.Memory[Index])
            begin
                $display("%d. SAD is %h from HW -- It is equal to %h from SW",Index,SADResult.Memory[Index],SW_Result_Memory[Index]);
            end
            else
            begin
                $display("%d. SAD is %h from HW -- It is not equal to %h from SW",Index,SADResult.Memory[Index],SW_Result_Memory[Index]);
            end
        end

    $stop;

    end
endmodule
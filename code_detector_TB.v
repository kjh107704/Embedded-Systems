`timescale 1 ns/ 1 ns

module Testbench();
    reg Start_s, Red_s, Green_s, Blue_s, Clk_s, Rst_s;
    wire U_s;

    reg[12:0] Index1;
    reg[2:0] Index2;
    reg[12:0] Correct_Index;

    Code_Detector CompToTest(Start_s,Red_s,Green_s,Blue_s,Clk_s,Rst_s,U_s);

    //Clock Procedure
    always begin
        Clk_s <= 0;
        #10;
        Clk_s <=1;
        #10;
    end // Note : Procedure repeats

    //Vector Procedure
    initial begin

        for(Index1=0;Index1<4096;Index1=Index1+1)
        begin
		    Rst_s <= 1;
        	@(posedge Clk_s);
        	Rst_s <= 0;
            @(posedge Clk_s);//in S_Wait state
                Start_s <= 1;
            @(posedge Clk_s);//in S_Start state
                Start_s <= 0;
            for(Index2=0;Index2<4;Index2=Index2+1)
            begin
                //Index2 == 0 -> in S_Start state
                //Index2 == 1 -> in S_Red1 state
                //Index2 == 2 -> in S_Blue state
                //Index2 == 3 -> in S_Green state

                    Blue_s <= Index1[3*Index2];
                    Green_s <= Index1[(3*Index2)+1];
                    Red_s <= Index1[(3*Index2)+2];
                    @(posedge Clk_s);
            end
            //in S_Red2 state
		    #5
		    if(U_s == 1)
                begin
                    $display("%4d: %3b_%3b_%3b_%3b is correct!",Index1,Index1[11:9],Index1[8:6],Index1[5:3],Index1[2:0]);
                    Correct_Index <= Index1;
                end
            else
                $display("%4d: %3b_%3b_%3b_%3b is incorrect!",Index1,Index1[11:9],Index1[8:6],Index1[5:3],Index1[2:0]);
            
        end
        $display("%4d: %3b_%3b_%3b_%3b is correct!",Correct_Index,Correct_Index[11:9],Correct_Index[8:6],Correct_Index[5:3],Correct_Index[2:0]);
        $stop;
    end

    

endmodule
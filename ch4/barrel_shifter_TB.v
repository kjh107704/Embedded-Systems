`timescale 1ns/1ns

module Testbench();
    reg Clk_s;
    reg SH_DIR;
    reg [4:0]SH_AMT;
    reg [31:0]D_IN;
    wire [31:0]D_OUT;

    reg [5:0] Index;

    Barrel_Shifter barrel_shifter(SH_DIR,SH_AMT,D_IN,D_OUT);

    //Clock Procedure
    always begin
        Clk_s <= 0;
        #10;
        Clk_s <=1;
        #10;
    end // Note : Procedure repeats

    //Vector Procedure
    initial begin
        //Case#1
        $display("1. Shift-Right Operation Test with Negative Value!");
        SH_DIR <= 1;//Shift-Right
        D_IN <= 32'b1000_0000_0000_0000_0000_0000_0000_0000;
        SH_AMT<=0;
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        
        for(Index=0;Index<32;Index=Index+1)
        begin
            SH_AMT<=Index[4:0];
            @(posedge Clk_s);
            #5
            $display("shift-right with amount %d is %32b",SH_AMT,D_OUT);
            
        end

        $display("2. Shift-Right Operation Test with Positive Value!");
        SH_DIR <= 1;//Shift-Right
        D_IN <= 32'b0100_0000_0000_0000_0000_0000_0000_0000;
        SH_AMT<=0;
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        
        for(Index=0;Index<32;Index=Index+1)
        begin
            SH_AMT<=Index[4:0];
            @(posedge Clk_s);
            #5
            $display("shift-right with amount %d is %32b",SH_AMT,D_OUT);
            
        end

        $display("3. Shift-Left Operation Test with Number 1!");
        SH_DIR <= 0;//Shift-Left
        D_IN <= 32'b0000_0000_0000_0000_0000_0000_0000_0001;
        SH_AMT<=0;
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        @(posedge Clk_s);
        
        for(Index=0;Index<32;Index=Index+1)
        begin
            SH_AMT<=Index[4:0];
            @(posedge Clk_s);
            #5
            $display("shift-right with amount %d is %32b",SH_AMT,D_OUT);
            
        end
        $stop;
    end

endmodule
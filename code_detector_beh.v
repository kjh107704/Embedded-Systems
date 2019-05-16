module Code_Detector(Start, Red, Green, Blue, Clk, Rst, U);
    input Start, Red, Green, Blue;
    output reg U;
    input Clk, Rst;
    //Encode the states in verilog
    parameter S_Wait = 0, S_Start = 1, 
            S_Red1 = 2, S_Blue = 3, S_Green = 4, S_Red2 = 5;

    reg [2:0] State, StateNext;

    //StateReg
    always @(posedge Clk) begin
        if(Rst ==1)
            State <= S_Wait;
        else
            State <= StateNext;
    end

    //CombLogic
    always @(State, Start,Red, Green, Blue) begin

        case(State)
            S_Wait: begin
                U <= 0;
                if(Start==1)
                    StateNext <= S_Start;
                else
                    StateNext <= S_Wait;
            end

            S_Start: begin
                U <= 0;
                if(Red==0&&Green==0&&Blue==0)
                    StateNext <= S_Start;
                else if(Red==1&&Green==0&&Blue==0)
                    StateNext <= S_Red1;
                else
                    StateNext <= S_Wait;
            end

            S_Red1: begin
                U <= 0;
                if(Red==0&&Green==0&&Blue==0)
                    StateNext <= S_Red1;
                else if(Red==0&&Green==0&&Blue==1)
                    StateNext <= S_Blue;
                else
                    StateNext <= S_Wait;
            end

            S_Blue: begin
                U <= 0;
                if(Red==0&&Green==0&&Blue==0)
                    StateNext <= S_Blue;
                else if(Red==0&&Green==1&&Blue==0)
                    StateNext <= S_Green;
                else
                    StateNext <= S_Wait;
            end

            S_Green: begin
                U <= 0;
                if(Red==0&&Green==0&&Blue==0)
                    StateNext <= S_Green;
                else if(Red==1&&Green==0&&Blue==0)
                    StateNext <= S_Red2;
                else
                    StateNext <= S_Wait;
            end

            S_Red2: begin
                U <= 1;
                StateNext <= S_Wait;
            end
        endcase
    end

endmodule
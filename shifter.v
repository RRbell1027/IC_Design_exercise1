
module shifter(
input clk,rst,flag,
output reg [3:0]out
);

//write your code..

/*requires:
	1.Before rst=1, out=0000.
	2.When rst=1, start the module(running light).
*/

    reg [4:0]block = 5'b10000;	//Create a 5bits block, block[3:0] corresponds to out[3:0] and block[4] standby.
    reg isStart=1'b0;	//Be activated when rst turns on first time(need to pass a clock posedge), and will never be turned off.
    
	//Everytime the clock changes from 0 to 1, shifter runs once. 
    always@(posedge clk) begin
        if(rst==1) begin	//When rst=1, every output turns off.
            block = 5'b10000;
            isStart = 1'b1;
        end else if(flag==1 && isStart==1) begin	//flag=1, light runs from right to left.([1]0000->[0]0001->[0]0010->[0]0100->[0]1000->[1]0000)
            block = {block[3:0], block[4]};
        end else if(isStart==1) begin				//flag=0, light runs from left to right.([1]0000->[0]1000->[0]0100->[0]0010->[0]0001->[1]0000)
            block = {block[0], block[4:1]};
        end
        out <= block[3:0];
    end

endmodule
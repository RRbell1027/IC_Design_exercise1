
module shifter(
input clk,rst,flag,
output reg [3:0]out
);

//write your code..
    reg [4:0]block = 5'b10000;
    reg isStart=1'b0;
    
    always@(posedge clk) begin
        if(rst==1) begin
            block = 5'b10000;
            isStart = 1'b1;
        end else if(flag==1 && isStart==1) begin
            block = {block[3:0], block[4]};
        end else if(isStart==1) begin
            block = {block[0], block[4:1]};
        end
        out <= block[3:0];
    end

endmodule
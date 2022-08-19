module divider 
(
  input wire clk ,
  input wire rst,
  output reg out_clk
);

//freqency_divider_by2
always @(posedge clk)
begin
if (~rst)
     out_clk <= 1'b0;
else
     out_clk <= ~out_clk;	
end
endmodule
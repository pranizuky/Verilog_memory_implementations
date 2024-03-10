//8x16 asynchronous dual port RAM memory
module asyram(din,wr_clk,rd_clk,rst,we,re,wr_addr,
rd_addr,dout);
parameter width=16,
depth=8,addr_bus=3;
input [width-1:0]din;
input wr_clk,rd_clk,rst,we,re;
input [addr_bus-1:0]wr_addr,rd_addr;
output reg [width-1:0]dout;
reg [width-1:0]mem[depth-1:0];
integer i;
always@(posedge wr_clk or posedge rst)
begin
if(rst)
begin
dout<=0;
for(i=0;i<8;i=i+1)
mem[i]<=16'b0;
end
else if(we)
mem[wr_addr]<=din;
else
mem[wr_addr]<=mem[wr_addr];
end
always@(posedge rd_clk or posedge rst)
begin
if(rst)
dout<=0; else
if(re)
dout<=mem[rd_addr];
else
mem[rd_addr]<=mem[rd_addr];
end
endmodule 
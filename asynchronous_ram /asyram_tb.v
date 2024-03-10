module asyram_tb(); reg [15:0]din;
reg [2:0]wr_addr,rd_addr;
reg wr_clk,rd_clk,rst,we,re;
wire [15:0]dout;
integer x,y; asyram
dut(din,wr_clk,rd_clk,rst,we,re,wr_addr,
rd_addr,dout);
initial
begin
wr_clk=1'b0;
forever #5 wr_clk=~wr_clk;
end
initial
begin
rd_clk=1'b0;
forever #10
rd_clk=~rd_clk; end
task initialize;
begin
din=16'b0;
{wr_addr,rd_addr}=6'b0;
{rst,we,re}=3'b100;
end endtask
task reset; begin
@(negedge wr_clk)rst=1'b1;
@(negedge wr_clk)rst=1'b0;
end
endtask
task write(input [15:0]i,input [2:0]j,input k);
begin
@(negedge wr_clk)din=i;
@(negedge wr_clk)wr_addr=j;
we=k;
end endtask
task read(input [2:0]m,input n);
begin
@(negedge rd_clk)rd_addr=m;
re=n;
end
endtask
initial
begin
initialize;
reset;
#10;
for(x=0;x<8;x=x+1)
write({$random},x,1'b1);
#20;
write({$random},x,1'b0);
#20;
for(y=0;y<8;y=y+1)
read(y,1'b1);
end initial
#1000 $finish(); endmodule 

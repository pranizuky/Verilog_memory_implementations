module ram_tb(); reg
[7:0]din; reg
[3:0]wr_addr,rd_addr;
reg clk,rst,we,re;
wire [7:0]dout;
integer x,y;
ram dut(din,dout,clk,rst,we,re,wr_addr,rd_addr);
initial
begin
clk=1'b0;
forever #5 clk=~clk;
end
task initialize;
begin
din=8'b0;
{wr_addr,rd_addr}=8'b0;
{rst,we,re}=3'b100;
end
endtask
task reset; begin
@(negedge clk)rst=1'b1;
@(negedge clk)rst=1'b0;
end
endtask
task write(input [7:0]i,input [3:0]j,input k);
begin
@(negedge clk)din=i;
wr_addr=j;
we=k;
end endtask
task read(input [3:0]m,input n);
begin
@(negedge clk)rd_addr=m;
re=n;
end
endtask initial
begin
initialize;
reset;
#10;
for(x=0;x<16;x=x+1)
write({$random},x,1'b1);
#20;
write({$random},x,1'b0);
#20;
for(y=0;y<16;y=y+1)
read(y,1'b1);
end
initial
#1000 $finish(); endmodule
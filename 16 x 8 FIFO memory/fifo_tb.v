module fifo_tb();
reg [7:0]din;
reg clk,rst,we,re;
wire [7:0]dout;
wire empty,full;
integer m;
fifo dut(din,clk,rst,we,re,dout,empty,full);
initial
begin
clk=1'b0;
forever #5 clk=~clk;
end
task initialize;
begin rst=1'b1;
din=8'b0;
we=1'b0; re=1'b0;
end
endtask
task reset; begin
@(negedge clk) rst=1'b1;
@(negedge clk) rst=1'b0;
end endtask
task write(input i);
@(negedge clk)we=i; endtask
task inputs(input [7:0]j); @(negedge
clk)din=j; endtask
task read(input k);
@(negedge clk) re=k; endtask
initial
begin
initialize;
reset;
write(1'b1);
for(m=0;m<16;m=m+1) inputs(m);
#20;
write(1'b0); read(1'b1);
#200;
$finish();
end endmodule 

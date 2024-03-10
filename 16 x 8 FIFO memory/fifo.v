//16 x 8 FIFO memory
module fifo(din,clk,rst,we,re,dout,empty,full);
parameter
width=8,depth=16,addr_bus=5;
input [width-1:0]din;
input clk,rst,we,re;
output reg [width-1:0]dout;
output empty,full;
reg [addr_bus-1:0]wr_ptr,rd_ptr;
reg [width-1:0]mem[depth-1:0];
integer i;
//write operation
always@(posedge clk)
begin if(rst)
begin wr_ptr<=5'b0;
for(i=0;i<16;i=i+1)
mem[i]<=8'b0;
end
else if(we==1'b1 && full==1'b0)
begin
mem[wr_ptr[3:0]]<=din;
wr_ptr<=wr_ptr+1'b1;
end
else
wr_ptr<=wr_ptr;
end
//read operation 
always@(posedge clk)
begin
if(rst)
begin
rd_ptr<=5'b0;
dout<=8'b0; end
else if(re==1'b1 && empty==1'b0)
begin
dout<=mem[rd_ptr[3:0]];
rd_ptr<=rd_ptr+1'b1; end
else
rd_ptr<=rd_ptr;
end
assign empty=(wr_ptr==rd_ptr)?1'b1:1'b0; assign
full=(wr_ptr=={~rd_ptr[4],rd_ptr[3:0]})?1'b1:1'b0;
endmodule

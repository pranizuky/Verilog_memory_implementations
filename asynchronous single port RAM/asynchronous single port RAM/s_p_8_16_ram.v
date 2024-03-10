//8x16 asynchronous single port RAM memory
module s_p_8_16_ram(we,re,rst,addr,data);
parameter
ADDR=3,WIDTH=16,DEPTH=8;
 input we,re,rst;
input[ADDR-1:0]addr;
inout [WIDTH-1:0]data;
reg [WIDTH-1:0] mem [DEPTH-1:0];
integer i;
always @(*)
begin
if(rst)
begin
for(i=0;i<8;i=i+1
) mem[i]=0;
end
else if(we&&~re)
mem[addr]=data;
end
assign data=(~we && re)?mem[addr]:16'hz;
endmodule 

`timescale 1ns / 1ps
module s_p_8_16_ram_tb(); reg
we,re,rst; reg [2:0]addr;
wire [15:0]data; reg
[15:0]tempa;
s_p_8_16_ram dut(we,re,rst,addr,data);
assign data=(we && ~re)?tempa:16'hz; task
initialize; begin
re=1'b0;we=1'b0;tempa=16'b0;
end
endtask task reset;
begin rst=1'b1; #10;
rst=1'b0; end
endtask task write; begin we=1'b1;
re=1'b0;
end
endtask task read; begin re=1'b1; we=1'b0;
end
endtask
task inputs(input[15:0]m,[2:0]n); begin
tempa=m; addr=n;
end endtask
initial
begin
initialize; reset; #10; write; inputs(16'd1,4'd1);
#10; inputs(16'd2,4'd2); #10; inputs(16'd3,4'd3);
#10; read; inputs(16'd1,4'd1); #10;
inputs(16'd2,4'd2); #10; inputs(16'd3,4'd3);
#10;
$finish; end endmodule 

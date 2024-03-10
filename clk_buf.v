`timescale 1ns / 1ps
//clock buffer
module clk_buf(mclk,bclk);
input mclk; output
bclk; buf
b1(bclk,mclk);
endmodule 
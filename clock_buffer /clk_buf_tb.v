//generate clock of 256hz
`timescale 1ms/1ns
module clk_buf_tb(); reg
mclk; wire bclk; time
t1,t2,t3,t4,t5,t6; parameter
T=3.90625;
clk_buf dut(mclk,bclk);
initial
begin
 mclk=1'b0;
forever #(T/2) mclk=~mclk; end
task master;
 begin
@(posedge mclk)
t1=$time; @(posedge
mclk) t2=$time; t3=t2-t1;
end
 endtask
task bufout;
begin
 @(posedge bclk) t4=$time;
@(posedge bclk) t5=$time;
t6=t5-t4;
 end
endtask task
freq_phase;
time f,p;
begin
 f=t6-t3; p=t4-t1;
 $display("freq_diff=%0t,phase_diff=%0t",f,p);
 end
endtask
initial
begin
fork
 master;
bufout;
join
freq_phase;
end
endmodule

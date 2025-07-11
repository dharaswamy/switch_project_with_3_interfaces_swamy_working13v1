/*test case for the verify the packet drives  with data_status=0 ,check dut is take that packet or not and send that packet to the 
output port let see.*/
`include "environment.sv"
program test( in_intf intf1, mem_intf intf2, out_intf intf3);
environment env;

class child_ag1 extends transaction_ag1;

function void pre_randomize();
data_status.rand_mode(0);
data_status=0;
endfunction:pre_randomize

endclass:child_ag1 

child_ag1 c1;
  
  initial begin
    c1=new();
    env=new( intf1, intf2,  intf3);
    env.ag1.gen1.repeat_count=4;
    env.ag2.gen2.repeat_count=4;
    env.ag1.gen1.trans=c1;
    env.run();
    end
  
endprogram:test

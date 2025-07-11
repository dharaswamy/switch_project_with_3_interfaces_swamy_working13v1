//test case for the  specific mem_addr 0 for sending the packet to the port0
`include "environment.sv"
program test( in_intf intf1, mem_intf intf2, out_intf intf3);
environment env;

class child_ag2 extends transaction_ag2;

//we use one temporary variable for controlling the mem_addr;

//bit [2:0] count;

function void pre_randomize();

mem_addr.rand_mode(0);
mem_addr=0;
//count++;

endfunction:pre_randomize

endclass:child_ag2 

child_ag2 c2;
  
  initial begin
    c2=new();
    env=new( intf1, intf2,  intf3);
    env.ag1.gen1.repeat_count=4;//doubt here why not runing 4 times (doubt is cleared)
    env.ag2.gen2.repeat_count=4;
    env.ag2.gen2.trans=c2;
    env.run();
    end
  
endprogram:test
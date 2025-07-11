//test case for invalid mem_addr

`include "environment.sv"
program test( in_intf intf1, mem_intf intf2, out_intf intf3);
environment env;

class child_ag2 extends transaction_ag2;


function void pre_randomize();
mem_addr.rand_mode(0);
mem_addr=5;
endfunction:pre_randomize

endclass:child_ag2 

child_ag2 c2;
  
  initial begin
    c2=new();
    env=new( intf1, intf2,  intf3);
    env.ag1.gen1.repeat_count=4;
    env.ag2.gen2.repeat_count=4;
    env.ag2.gen2.trans=c2;
    env.run();
    end
  
endprogram:test
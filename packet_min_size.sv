//code for the send packet with maximum size of 256 bytes and with minimum size of 4 bytes.


`include "environment.sv"
program test( in_intf intf1, mem_intf intf2, out_intf intf3);
environment env;

class child_ag1 extends transaction_ag1;

//using the inheritance constraint to override the value of length(constraint name is  same as parent class constraint).
  constraint length_const{length==0;}//for sending the maximum size of packet.

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
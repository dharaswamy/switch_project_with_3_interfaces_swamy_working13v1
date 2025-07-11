`include "environment.sv"
program test( in_intf intf1, mem_intf intf2, out_intf intf3);
environment env;
  
  
  initial begin
    env=new( intf1, intf2,  intf3);
    env.ag1.gen1.repeat_count=4;
    env.ag2.gen2.repeat_count=4;
    env.run();
    end
  
  
  
  
  
  
endprogram:test

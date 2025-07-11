//packet with bad parity/fcs test case

`include "environment.sv"

program test( in_intf intf1, mem_intf intf2, out_intf intf3);
environment env;

class child_ag1 extends transaction_ag1;


//we write the post randomization method for drive the incorrect parity(fcs).
  function void post_randomize();
    /*parity=d_addr^s_addr^length;
    foreach(data_in[i]) 
    parity=(parity^data_in[i]);

     parity=~(parity);  */
    parity=8'hff;
    
  endfunction:post_randomize
  


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
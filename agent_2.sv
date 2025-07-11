`include "transaction_ag2.sv"
`include "generator_ag2.sv"
`include "driver_ag2.sv"
`include "mem_mntr_ag2.sv"
class agent_2;
//we decale the gen,driver,mem_mntr class handles
 generator_ag2 gen2;
 driver_ag2 driv2;
 mem_mntr_ag2 mem_mntr2;
  
mailbox gen2driv_ag2;
mailbox mem_mntr2scb_ag2;
mailbox ag22ag1;

virtual mem_intf intf2;


  function new(virtual mem_intf intf2,mailbox mem_mntr2scb_ag2,mailbox ag22ag1);
  gen2driv_ag2=new();
  this.intf2=intf2;
   this.mem_mntr2scb_ag2=mem_mntr2scb_ag2;
  this.ag22ag1=ag22ag1;
    gen2=new(gen2driv_ag2,ag22ag1);
    driv2=new(intf2,gen2driv_ag2);
  mem_mntr2=new(intf2,mem_mntr2scb_ag2);
    endfunction:new
  
  task reset();
    driv2.reset();
   endtask:reset
  
task run();
    fork
     gen2.run();
     driv2.run();
     mem_mntr2.run();
    join_any
  endtask:run
  
  
  
endclass:agent_2
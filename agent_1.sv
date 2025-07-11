`include "transaction_ag1.sv"
`include "generator_ag1.sv"
`include "driver_ag1.sv"
`include "in_monitor_ag1.sv"
`include "op_monitor_ag1.sv"

class agent_1;

  generator_ag1 gen1;
  driver_ag1 driv1;
  
  in_monitor_ag1 in_mntr1;
  op_monitor_ag1 op_mntr1;
  
  
  mailbox gen2driv_ag1;
  mailbox ag22ag1;
//mailbox for exchange the data between the input monitor to scoreboard
mailbox in_mntr2scb_ag1;
//mailbox for exchange the data between the  output_mntr to scb
mailbox op_mntr2scb_ag1;

  
  virtual in_intf intf1;//for input 
 virtual out_intf intf3;//for ouput
  
  function new(virtual in_intf intf1,virtual out_intf intf3,mailbox ag22ag1,mailbox in_mntr2scb_ag1,mailbox op_mntr2scb_ag1);
    gen2driv_ag1=new();
    this.ag22ag1=ag22ag1;
    this.in_mntr2scb_ag1=in_mntr2scb_ag1;
    this.op_mntr2scb_ag1=op_mntr2scb_ag1;
    this.intf1=intf1;
    this.intf3=intf3;
    gen1=new(gen2driv_ag1,ag22ag1);
    driv1=new(intf1,gen2driv_ag1);
    in_mntr1=new(intf1,in_mntr2scb_ag1);
    op_mntr1=new(intf3,op_mntr2scb_ag1);
    endfunction:new
  
  //for calling the reset task
  task reset();
    driv1.reset();
   endtask:reset
  
  //task for the calling the run task in driver and generator
  task run();
    fork
     gen1.run();
     driv1.run();
      in_mntr1.run();
      op_mntr1.run();
    join_any
  endtask:run
  
  
endclass:agent_1


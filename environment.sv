
`include "agent_1.sv"
`include "agent_2.sv"
`include "scoreboard.sv"
class environment;
  
//agent1 class declaration
  agent_1 ag1;
  agent_2 ag2;
  scoreboard scb;
  
//mailboxs for the exachange the data between the components
mailbox in_mntr2scb_ag1;
mailbox op_mntr2scb_ag1; 
mailbox mem_mntr2scb_ag2;

//mailbox for ag2 to ag1;
  mailbox ag22ag1;
  
//virtual interfaces handles for interaction
  virtual in_intf intf1;
  virtual mem_intf intf2;
  virtual out_intf intf3;
  
  function new(virtual in_intf intf1,virtual mem_intf intf2,virtual out_intf intf3);
    in_mntr2scb_ag1=new();//mailbox creation
    op_mntr2scb_ag1=new();//mailbox creation
    mem_mntr2scb_ag2=new();
    ag22ag1=new();//mailbox creation
    this.intf1=intf1;
    this.intf2=intf2;
   this.intf3=intf3;
    ag1=new(intf1,intf3,ag22ag1,in_mntr2scb_ag1,op_mntr2scb_ag1);
    ag2=new(intf2,mem_mntr2scb_ag2,ag22ag1);
    scb=new(in_mntr2scb_ag1,op_mntr2scb_ag1,mem_mntr2scb_ag2);
endfunction:new
  
  
  //calling the reset tasks from the ag1 and ag2
  task pre_test();
   fork
    ag1.reset();
     ag2.reset();
   join
  endtask:pre_test
  
  
  //calling the run task in the ag1 and ag2
  task test();
    fork 
     ag2.run();
      scb.run1();
    join
    
    fork 
     ag1.run();
     scb.run2();
    join_any
  endtask:test
  
  //terminates/killes the simulation
  task post_test();
    
   #1000 $finish; 
    
  endtask:post_test
  
  
  task run();
    
    pre_test();
    test();
    post_test();
    
  endtask:run
  
endclass:environment

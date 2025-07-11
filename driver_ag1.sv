class driver_ag1;
//mailbox we need for get the randomized values from the generator
  mailbox gen2driv_ag1;
  //drive the randomized values to the dut through virtual interface
  virtual in_intf.driver intf1;
  
  //event for control of data b/w the mailbox
  //event drivnext_ag1;
  
  //writting the default constructor
  function new(virtual in_intf intf1 ,mailbox gen2driv_ag1);
    this.gen2driv_ag1=gen2driv_ag1;
    this.intf1=intf1;
  endfunction:new
  
  //task for reset the DUT
 task reset();
   wait(!intf1.rst);
    $display("T:%0f ag1 reset DUT is started",$realtime);
    intf1.data_status<=0;
    intf1.data_in<=0;
   wait(intf1.rst);
   $display("\nT:%0f ag1 reset is done",$realtime);
   $display("\nT:%0f reset values data_status=%0d data_in=%0d",$realtime,intf1.data_status,intf1.data_in);
  
  endtask:reset
  
  
task run();
 // repeat(17)
//@(posedge intf1.clk); 
forever begin
transaction_ag1 trans;
gen2driv_ag1.get(trans);

@(posedge intf1.clk);
intf1.data_status<=trans.data_status;

//@(posedge intf1.clk);
intf1.data_in<=trans.d_addr;

@(posedge intf1.clk);
intf1.data_in<=trans.s_addr;
  
@(posedge intf1.clk);
intf1.data_in<=trans.length;
  
foreach(trans.data_in[i]) begin
 @(posedge intf1.clk); 
  intf1.data_in<=trans.data_in[i];
end
  
@(posedge intf1.clk); 
intf1.data_in<=trans.parity;
intf1.data_status<=0;
  $display("\nT:%0t Driver agent1  drive the packet to dut da=%0h sa=%0h length=%0h trans.data_in.size=%0h  \n trans.data_in(data bytes)=%0p  parity=%0h",$time,trans.d_addr,trans.s_addr,trans.length,trans.data_in.size(),trans.data_in,trans.parity);
@(posedge intf1.clk);
intf1.data_in<=0;  
  repeat(3)
@(posedge intf1.clk); 
 //->drivnext_ag1;
     
   end
    
endtask:run
  
endclass:driver_ag1



 // $display("T:%0f reset values ready_0=%0d ready_1=%0d ready_2=%0d ready_3=%0d",$realtime,intf1.ready_0,intf1.ready_1,intf1.ready_2,intf1.ready_3);
    //$display("T:%0f reset values port_0=%0d port_1=%0d port_2=%0d port_3=%0d",$realtime,intf1.port_0,intf1.port_1,intf1.port_2,intf1.port_3);
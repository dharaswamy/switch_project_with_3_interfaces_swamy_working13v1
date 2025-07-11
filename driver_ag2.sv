class driver_ag2;

//mailbox's
mailbox gen2driv_ag2;
  
  virtual mem_intf.driver intf2;
  
  function new(virtual mem_intf intf2,mailbox gen2driv_ag2);
  this.gen2driv_ag2=gen2driv_ag2; 
  this.intf2=intf2;
  endfunction:new
  
  //reset task for mem
  
  
  task reset();
    
    wait(!intf2.rst);
    $display("\nT:%0f \" reset_ag2 of DUT is started\" ",$realtime);
  intf2.mem_en<=0;
  intf2.mem_addr<=0;
  intf2.mem_rd_wr<=0;
  intf2.mem_data<=0;
  wait(intf2.rst);
    $display("\nT:%0f \" reset_ag2 of DUT is completed \" ",$realtime);
    $display("T:%0f \"reset_ag2 values mem_en=%0b mem_addr=%0d mem_rd_wr=%0b,mem_data=%0d \"",$realtime,intf2.mem_en,intf2.mem_addr,intf2.mem_rd_wr,intf2.mem_data);
endtask:reset
             
//task for drive the randomized values to the dut through interface
             
task run();
 
  repeat(4) begin
transaction_ag2 trans=new;
gen2driv_ag2.get(trans);
   
  @(posedge intf2.clk);
  intf2.mem_en<=trans.mem_en;
   @(posedge intf2.clk); 
    intf2.mem_rd_wr<=trans.mem_rd_wr;
     @(posedge intf2.clk); 
  intf2.mem_addr<=trans.mem_addr;
  
  intf2.mem_data<=trans.mem_data;
  @(posedge intf2.clk);
   //intf2.mem_rd_wr<=0;
  intf2.mem_rd_wr<=0;
    //intf2.mem_en<=0;
  trans.display("[driver_ag2 drive]");
   
end
  /*repeat(4)
 @(posedge intf2.clk);*/ 
  
 intf2.mem_en<=0;              
endtask:run
  
endclass:driver_ag2
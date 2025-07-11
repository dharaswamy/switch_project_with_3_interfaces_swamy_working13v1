class in_monitor_ag1;
 
transaction_ag1 trans;
  
//mailbox for exchange the data between the input monitor to scoreboard
  mailbox in_mntr2scb_ag1;

//declare the interface handle
  virtual in_intf.in_mntr intf1;

 //we need one temporary variable 
  //shortint unsigned z;
  
  function  new(virtual in_intf intf1,mailbox in_mntr2scb_ag1);
  this.in_mntr2scb_ag1=in_mntr2scb_ag1;
    this.intf1=intf1;
    endfunction:new
  
  /*task run();
    forever begin
      trans=new();
      @(posedge intf1.clk);
      wait(intf1.data_status);
      //@(negedge intf1.clk);
      //trans.data_status=intf1.data_status;
      //trans.data_in[0]=intf1.data_in;
      
      for(int i=0;i<(260);i++) begin
        @(negedge intf1.clk);
        trans.data_in[i]=intf1.data_in;
        @(posedge intf1.clk);
        if(intf1.data_status==0) begin
          z=i;
        break;
        end
        end
      trans.data_in[z+1]=intf1.data_in;
     
      $display("T:%0t input_monitor agent1 send  packet to the scoreboard data_in=%0p z=%0d",$time,trans.data_in,z);
       in_mntr2scb_ag1.put(trans);
      repeat(3)
        @(posedge intf1.clk);
      end
    endtask:run*/
  
  
  task run();
    repeat(4) begin
      trans=new();
     // trans.data_in=0;
      @(posedge  intf1.clk);
      wait(intf1.data_status);
      //@(negedge intf1.clk);
      //trans.data_status=intf1.data_status;
      //trans.data_in[0]=intf1.data_in;
      
      for(int i=0;i<(260);i++) begin
      @(negedge intf1.clk);
      trans.data_in=new[trans.data_in.size()+1](trans.data_in);
     trans.data_in[trans.data_in.size()-1]=intf1.data_in;
       if(intf1.data_status==0) begin
          //z=i;
        break;
        end
        end
      //trans.data_in[z+1]=intf1.data_in;
     
      $display("\n T:%0t input_monitor agent1 put the  packet into mailbox for the scoreboard  \n data_in=%0p ",$time,trans.data_in);
       in_mntr2scb_ag1.put(trans);
      repeat(3)
        @(posedge intf1.clk);
      end
    endtask:run
  
endclass:in_monitor_ag1
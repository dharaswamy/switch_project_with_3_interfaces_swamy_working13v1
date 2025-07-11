class scoreboard;

//mailbox  declaration for exchange the data b/w the in_montior to scoreboard
mailbox in_mntr2scb_ag1;
//mailbox declaration for exchange the data b/w the op_monitor to scoreboard
mailbox op_mntr2scb_ag1;
//mailbox declaration for exchange the data b/w the mem_monitor to scoreboard
mailbox mem_mntr2scb_ag2;


static reg [7:0] mem[4];//we create the memory with depath of 4 and width is 8.
  
  function new(mailbox in_mntr2scb_ag1,mailbox op_mntr2scb_ag1,mailbox mem_mntr2scb_ag2);
   this.in_mntr2scb_ag1=in_mntr2scb_ag1;
    this.op_mntr2scb_ag1=op_mntr2scb_ag1;
    this.mem_mntr2scb_ag2=mem_mntr2scb_ag2;
   endfunction:new

task run1();
 
repeat(4) begin
transaction_ag2 trans;
mem_mntr2scb_ag2.get(trans);//getting the memory interface values from the memory monitor via mailbox
mem[trans.mem_addr]=trans.mem_data;
$display("\n T:%0t score board mem[%0d]=%0h",$time,trans.mem_addr,trans.mem_data);
end
endtask:run1
  
task run2();
 
repeat(4) begin

  transaction_ag1 trans1=new();// handle for getting the input vlaues 
  transaction_ag1 trans2=new();// handle for getting the output values
  //$display("scoreboard run2 is initilaed1");
  //$display("scoreboard run2 mem=%0p",mem);
  
  in_mntr2scb_ag1.get(trans1);//getting the input samples from the input monitor via mailbox.
op_mntr2scb_ag1.get(trans2);//getting the output samples from the output monitor via mailbox.

  
if(mem[0]==trans1.data_in[0]) begin 

  
if(trans1.data_in==trans2.port_0) begin
  $display("\n T:%0t scoreboard correct results packet is comes out from the port_0 mem[0]=%0h trans1.data_in[0]=%0h",$time,mem[0],trans1.data_in[0]);
  $display(" input packet data_in d_addr=%0h and output packet port_0 d_addr=%0h ",trans1.data_in[0],trans2.port_0[0]);
  $display(" input packet data_in s_addr=%0h and output packet port_0 s_addr=%0h ",trans1.data_in[1],trans2.port_0[1]);
  $display(" input packet length=%0h and output packet port_0 length=%0h ",trans1.data_in[2],trans2.port_0[2]);
  
  if(trans1.data_in.size()>1 && trans2.port_0.size()>1) begin 
    fork
      begin
    for(int i=3;i<(trans1.data_in.size-1);i++) 
      $display("input packet  bytes of data data_in[%0d]=%0h  ",i,trans1.data_in[i]); 
      end
      begin
        for(int i=3;i<(trans2.port_0.size-1 );i++) 
          $display(" output  packet bytes of data [%0d]=%0h ",i,trans2.port_0[i]); 
      end
    join
    end
  $display("T:%0t scoreboard correct results from the port_0 \n Execpected packet=%0p \n Actual packet=%0p",$time,trans2.port_0,trans1.data_in);
end
else begin
if(trans1.data_in!=trans2.port_0) 
$display("\n T:%0t scoreboard error results packet is comes out from the port_0 mem[0]=%0h trans1.data_in[0]=%0h",$time,mem[0],trans1.data_in[0]);
$display("T:%0t port_0 scoreboard error results from the port_0 Execpected packet=%0p \n Actual packet=%0p",$time,trans2.port_0,trans1.data_in);
$error("T:%0t error scoreboard results packet is mismatch port_0 and input packet",$time);
end
  
end



 if(mem[1]==trans1.data_in[0]) begin

if(trans1.data_in==trans2.port_1) begin
  $display("\n T:%0d scoreboard results packet is comes out from the port_1 mem[1]=%0h trans1.data_in[0]=%0h",
$time,mem[1],trans1.data_in[0]);
  $display("T:%0d scoreboard correct results from the port_1 \n Execpected packet=%0p \n Actual packet=%0p",$time,trans2.port_1,trans1.data_in);
end
else begin
  if(trans1.data_in!=trans2.port_1) 
  $display("\n T:%0d scoreboard error results packet is comes out from the port_1 mem[1]=%0h trans1.data_in[0]=%0h",
$time,mem[1],trans1.data_in[0]);
  $display("T:%0t port_1 scoreboard error results from the port_1 Execpected packet=%0p \n Actual packet=%0p",$time,trans2.port_1,trans1.data_in);
  $error("T:%0t error scoreboard results packet is mismatch port_1 and input packet",$time);
end
end

 if(mem[2]==trans1.data_in[0])  begin
if(trans1.data_in==trans2.port_2) begin
  $display("\n T:%0d scoreboard results packet is comes out from the port_2 mem[2]=%0h trans1.data_in[0]=%0h",
$time,mem[2],trans1.data_in[0]);
  $display("T:%0d scoreboard correct results from the port_2\n Execpected packet=%0p \n Actual packet=%0p",$time,trans2.port_2,trans1.data_in);
end
else begin
  if(trans1.data_in!=trans2.port_2) 
  $display("\n T:%0d scoreboard error results packet is comes out from the port_2 mem[2]=%0h trans1.data_in[0]=%0h",
$time,mem[2],trans1.data_in[0]);
  $display("T:%0t port_2 scoreboard error results from the port_2 Execpected packet=%0p \n  Actual packet=%0p",$time,trans2.port_2,trans1.data_in);
  $error("T:%0t error scoreboard results packet is mismatch port_2 and input packet",$time);
end
end

 if(mem[3]==trans1.data_in[0]) begin
  
if(trans1.data_in==trans2.port_3) begin
  $display("\n T:%0d scoreboard results packet is comes out from the port_3 mem[3]=%0h trans1.data_in[0]=%0h",
$time,mem[3],trans1.data_in[0]);
  $display("T:%0d scoreboarf correct results  from the port_3 \n Execpected packet=%0p \n Actual packet=%0p",$time,trans2.port_3,trans1.data_in);
end
else begin
  if(trans1.data_in!=trans2.port_3) 
  $display("\n T:%0d scoreboard error results packet is comes out from the port_3 mem[3]=%0h trans1.data_in[0]=%0h",
$time,mem[3],trans1.data_in[0]);
  $display("T:%0t port_3 scoreboard error results from the port_3 Execpected packet=%0p \n Actual packet=%0p",$time,trans2.port_3,trans1.data_in);
$error("T:%0t error scoreboard results packet is mismatch port_3 and input packet",$time);
end
end
end
endtask:run2
  
 /* task run();
   fork
     run1();
     run2();
   join_none
  endtask:run*/

endclass:scoreboard



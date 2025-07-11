//output monitor for monitoring the sampled values of DUT and send this data to the 
//-mailbox for scoreboard_ag1

class op_monitor_ag1;
  
//required the transaction class handle
transaction_ag1 trans; 

  
//mailbox for exchange the data between the  output_mntr to scb
mailbox op_mntr2scb_ag1;
 
//need the output virtual interface
virtual out_intf intf3;
  
   //we need one temporary variable 
  shortint unsigned z;
  
//writting the default constructor
  
  function new(virtual out_intf intf3,mailbox op_mntr2scb_ag1);
 this.intf3=intf3;
 this.op_mntr2scb_ag1=op_mntr2scb_ag1;
endfunction:new

/*task run();
repeat(4) begin  
trans=new();

@(posedge intf33.clk);  
wait(intf33.ready_0||intf33.ready_1||intf33.ready_2||intf33.ready_3);

if(intf33.ready_0) begin
for(int i=0; i<260; i++) begin
@(posedge intf33.clk);
if(intf33.ready_0==0) begin
z=i;
break;
end //for if condition
trans.port_0[i]=intf33.port_0;
end //for for loop

trans.port_0[z]=intf33.port_0;
op_mntr2scb_ag1.put(trans);
  $display("\n T:%0t ouput monitor putting the packet into the mailbox=%0p",$time,trans.port_0);
end //for ready_0

if(intf33.ready_1) begin
for(int i=0; i<260; i++) begin
@(posedge intf33.clk);
if(intf33.ready_1==0) begin
z=i;
break;
end //for if condition
trans.port_1[i]=intf33.port_1;
end //for for loop

trans.port_1[z]=intf33.port_1;
op_mntr2scb_ag1.put(trans);
  $display("\n T:%0t ouput monitor putting the packet into the mailbox=%0p",$time,trans.port_1);
end //for ready_1

if(intf33.ready_2) begin
for(int i=0; i<260; i++) begin
@(posedge intf33.clk);
if(intf33.ready_2==0) begin
z=i;
break;
end //for if condition
trans.port_2[i]=intf33.port_2;
end //for for loop

trans.port_2[z]=intf33.port_2;
op_mntr2scb_ag1.put(trans);
  $display("\n T:%0t ouput monitor putting the packet into the mailbox=%0p",$time,trans.port_2);
end //for ready_2

if(intf33.ready_3) begin
for(int i=0; i<260; i++) begin
@(posedge intf33.clk);
if(intf33.ready_3==0) begin
z=i;
break;
end //for if condition
trans.port_3[i]=intf33.port_3;
end //for for loop

trans.port_3[z]=intf33.port_3;
 op_mntr2scb_ag1.put(trans);
  $display("\n T:%0t ouput monitor putting the packet into the mailbox=%0p",$time,trans.port_3);
end //for ready_3


    end //for forever 
  endtask:run*/
  
  //new task

task run();
  repeat(4) begin  
    trans=new();

  @(posedge intf3.clk);  
wait(intf3.ready_0||intf3.ready_1||intf3.ready_2||intf3.ready_3);

if(intf3.ready_0) begin
for(int i=0; i<260; i++) begin
@(posedge intf3.clk);
trans.port_0=new[trans.port_0.size()+1](trans.port_0);
trans.port_0[trans.port_0.size()-1]=intf3.port_0;
if(intf3.ready_0==0) 
break;
end //for for loop

  $display("\n T:%0t output_monitor agent1 put the  packet into mailbox for the scoreboard \n port_0=%0p ",$time,trans.port_0);
  op_mntr2scb_ag1.put(trans);
end //for if condition


if(intf3.ready_1) begin
for(int i=0; i<260; i++) begin
@(posedge intf3.clk);
trans.port_1=new[trans.port_1.size()+1](trans.port_1);
trans.port_1[trans.port_1.size()-1]=intf3.port_1;
if(intf3.ready_1==0) 
break;
end //for for loop
  $display("\n T:%0t output_monitor agent1 put the  packet into mailbox for the scoreboard \n port_1=%0p ",$time,trans.port_1);
  op_mntr2scb_ag1.put(trans);
end //for if condition


if(intf3.ready_2) begin
for(int i=0; i<260; i++) begin
@(posedge intf3.clk);
trans.port_2=new[trans.port_2.size()+1](trans.port_2);
trans.port_2[trans.port_2.size()-1]=intf3.port_2;
if(intf3.ready_2==0) 
break;
end //for for loop
  $display("\n T:%0t output_monitor agent1 put the  packet into mailbox for the scoreboard \n port_2=%0p ",$time,trans.port_2);
  //trans.port_2[trans.port_2.size()-4]='haf;//error forcing to scoreboard.
  op_mntr2scb_ag1.put(trans);
end //for if condition


if(intf3.ready_3) begin
for(int i=0; i<260; i++) begin
@(posedge intf3.clk);
trans.port_3=new[trans.port_3.size()+1](trans.port_3);
trans.port_3[trans.port_3.size()-1]=intf3.port_3;
if(intf3.ready_3==0) 
break;
end //for for loop
  $display("\n T:%0t output_monitor agent1 put the  packet into mailbox for the scoreboard \n port_3=%0p ",$time,trans.port_3);
 // trans.port_3[trans.port_3.size()-1]=0011;
  op_mntr2scb_ag1.put(trans);
end //for if condition




    end //for forever 
  endtask:run
  
  endclass:op_monitor_ag1


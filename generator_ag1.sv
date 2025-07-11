
class generator_ag1;
  
//variable for the control of repeatation of the randomization 
  shortint unsigned repeat_count;
  
//need the transaction class handle for the randomization of transaction class
  transaction_ag1 trans,tr;
  
//mailbox for the communication with the scoreboard
  mailbox gen2driv_ag1;
  
  //mailbox for the communication between the ag2 to ag1
  mailbox ag22ag1;
  //bit [7:0] temp_mem_data;
  
  //events for control the sending of msgs to mailbox
  //event done_ag1;
  //event drvnext_ag1;
  //event scbnext_ag1;
  
//writting the default constructor
  function new(mailbox gen2driv_ag1,mailbox ag22ag1);
    this.gen2driv_ag1=gen2driv_ag1;
    this.ag22ag1=ag22ag1;
   trans=new();
  endfunction:new
  
task run();
repeat(repeat_count) begin
//getting the randomized value from mailbox 
  ag22ag1.get(trans.temp_mem_data);  
  if( !trans.randomize()with{d_addr==trans.temp_mem_data;}) 
  $fatal("Gen_ag1:: trans randomization failed");      
tr = trans.do_copy();
gen2driv_ag1.put(tr);
  $display("\nT:%0f agent1 generator randomized vales data_status=%0d  d_addr=%0h s_addr=%0h length=%0h parity=%0h \n randmozied data_in=%0p",$realtime,trans.data_status,trans.d_addr,trans.s_addr,trans.length,trans.parity,trans.data_in); 
 // @(drvnext_ag1);
 // @(scbnext_ag1);
end
//-> done;    
endtask:run
  
endclass:generator_ag1
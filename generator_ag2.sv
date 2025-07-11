class generator_ag2;
  
//we need the transaction class handle for randomize the transaction class properties.
transaction_ag2 trans,tr;

//we require the mailbox for exchange the data b/w the generator and driver.
mailbox gen2driv_ag2;
  mailbox ag22ag1;
  
  //we need the one variable for control the run task
  shortint unsigned repeat_count;
  
  //we write the default constructor 
  function new(mailbox gen2driv_ag2,mailbox ag22ag1);
    this.gen2driv_ag2=gen2driv_ag2;
    this.ag22ag1=ag22ag1;
     trans=new();
  endfunction:new
  
  //write the task for the randomization and put the randomize values in mailbox for driver
  
task  run();
repeat(repeat_count) begin
if( !trans.randomize()) 
$fatal("Gen_ag2:: trans randomization failed"); 
tr = trans.do_copy();
ag22ag1.put(tr.temp_mem_data);
gen2driv_ag2.put(tr);
  trans.display("[Gen_ag2:randomized]");
end
    
endtask:run
  
  
endclass:generator_ag2
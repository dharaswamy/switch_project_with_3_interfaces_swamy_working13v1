//memory monitor for monitoring the memory interface values.
class mem_mntr_ag2;

transaction_ag2 trans;

mailbox mem_mntr2scb_ag2;

virtual mem_intf intf2;

function new(virtual mem_intf intf2,mailbox mem_mntr2scb_ag2);
this.mem_mntr2scb_ag2=mem_mntr2scb_ag2;
this.intf2=intf2;
endfunction:new

task run();

repeat(4) begin
trans=new();
@(posedge intf2.clk);
wait(intf2.mem_en);
  repeat(2)
@(negedge intf2.clk);
if(intf2.mem_rd_wr && intf2.mem_en) begin
@(negedge intf2.clk);
trans.mem_addr=intf2.mem_addr;
trans.mem_data=intf2.mem_data;

mem_mntr2scb_ag2.put(trans);
@(posedge intf2.clk); 
  $display("\n T:%0t mem_monitor putting values into mailbox for scoreboard mem_addr=%0d mem_data=%0h ",$time,trans.mem_addr,trans.mem_data);
end
//@(posedge intf2.clk);
end

endtask:run


endclass:mem_mntr_ag2
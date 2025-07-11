//memory interface for agent2

interface mem_intf(input clk,rst);

logic mem_en;
logic [1:0] mem_addr;
   
logic mem_rd_wr;
logic [7:0]  mem_data;
  //logic [2:0] mem_addr;

modport driver(input clk,rst,output mem_en,mem_addr,mem_rd_wr,mem_data);
//modport in_mntr(input clk,rst,mem_en,mem_addr,mem_rd_wr,mem_data);

endinterface:mem_intf
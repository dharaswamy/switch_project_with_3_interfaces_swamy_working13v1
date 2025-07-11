//input interface declaration
interface in_intf(input clk,rst);

logic data_status;
logic [7:0] data_in;

modport driver(input clk,rst,output data_status,data_in);
modport in_mntr(input clk,rst,data_status,data_in);

endinterface:in_intf

// Eda link : 
// ( swamy ) please copy the code but don't change/modify the code here.


//========================================================================================
// project Name: switch sv based 
//========================================================================================



//`include "test.sv"
`include "packet_max_size.sv"
//`include "packet_min_size.sv"
//`include "specific_addr_packet.sv"
//`include "specific_port0_packet.sv"
//`include "specific_port1_packet.sv"
//`include "specific_port2_packet.sv"
//`include "specific_port3_packet.sv"
//`include "bad_fcs_packet.sv"
//`include "reset_bw_packet.sv"
//`include "invalid_mem_addr.sv"
//`include "data_status_zero_packet.sv"
`include "input_interface.sv"//input interface
`include "memory_interface.sv"//memory interface
`include "out_put_interface.sv"//output interface
module tb_top;
  
bit clk=0;
bit rst=1;
  
//for clock generation  
initial begin
forever begin
#5 clk=~clk;  
end
end
 
//initialize the rst 
  initial begin
   #20 rst=0;
    #23 rst=1;
    //#102 rst=1;
    
    /*#40 rst=0; //for the reset bw the packet transaction.
    #10 rst=1;
    #20 rst=0;
    #50 rst=1;
     #62 rst=1;
    
    #20 rst=0;
     #30 rst=1;
     #45 rst=0;
     #15 rst=1;*/
    
    
  end
  
  //interfaces innstantiation
  in_intf intf1( clk,rst);
  mem_intf intf2( clk,rst);
  out_intf intf3( clk,rst);
  
  //test instantiation
  test t1(intf1,intf2,intf3);
  
  //switch module instantiation
  
  switch s1(.clk(clk),
            .reset(rst),
            .data_status(intf1.data_status),
            .data(intf1.data_in),
            .port0(intf3.port_0),
            .port1(intf3.port_1),
            .port2(intf3.port_2),
            .port3(intf3.port_3),
            .ready_0(intf3.ready_0),
            .ready_1(intf3.ready_1),
            .ready_2(intf3.ready_2),
            .ready_3(intf3.ready_3),
            .read_0(intf3.read_0),
            .read_1(intf3.read_1),
            .read_2(intf3.read_2),
            .read_3(intf3.read_3),
            .mem_en(intf2.mem_en),
            .mem_rd_wr(intf2.mem_rd_wr),
            .mem_add(intf2.mem_addr),
            .mem_data(intf2.mem_data));
  
  //for generating the waveforms writting the dump file.
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
     //#100 $finish;
  end
  
endmodule:tb_top
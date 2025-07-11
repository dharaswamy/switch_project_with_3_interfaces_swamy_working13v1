class transaction_ag2;

  //class randomize fields
  rand bit mem_en;
  randc bit [1:0] mem_addr;
  rand bit mem_rd_wr;
  randc bit [7:0] mem_data;
  rand bit [7:0] temp_mem_data;
  
   //randc bit [2:0] mem_addr;
  constraint mem_en_c{soft mem_en==1;}
  constraint mem_rd_wr_c{soft mem_rd_wr==1;}
  
  //constraint mem_addr_c{mem_addr==3;}
  //constraint mem_data_c{mem_data inside{31,41,51,61};}
  constraint temp_mem_data_c{temp_mem_data==mem_data;}
  
  //constraint mem_addr_c{}
  
  //display function for display of this class properties
  function void display(string name);
    $display("\nT:%0f  %0s values mem_en=%0b mem_addr=%0d mem_rd_wr=%0b,mem_data=%0h ",$realtime,name,mem_en,mem_addr,mem_rd_wr,mem_data); 
    
  endfunction:display
             
function transaction_ag2 do_copy();
  transaction_ag2 trans;
    trans=new();
    trans.mem_en=this.mem_en;
    trans.mem_addr=this.mem_addr;
    trans.mem_rd_wr=this.mem_rd_wr;
    trans.mem_data=this.mem_data;
  trans.temp_mem_data=this.temp_mem_data;
    return trans;
  endfunction:do_copy
  
  
  
endclass:transaction_ag2

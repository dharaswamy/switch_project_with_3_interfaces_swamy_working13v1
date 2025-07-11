//agent1 transaction class.

class transaction_ag1;

rand bit [7:0] s_addr;
rand bit [7:0] d_addr;
rand bit [7:0] length;
rand bit data_status;
rand bit [7:0] data_in[]; //it is dynamic array for sending the bytes of data.
  
bit [7:0] parity;//this signal fcs calculation

  
//this variable required for the mem_data value  from agent2 and assigned to the d_addr ;
  bit[7:0] temp_mem_data;

//for the purpose of monitoring the outputs we take output interface variables.
bit read_0;
bit read_1;
bit read_2;
bit read_3;

bit ready_0;
bit ready_1;
bit ready_2;
bit ready_3;

bit [7:0] port_0[];
bit [7:0] port_1[];
bit [7:0] port_2[];
bit [7:0] port_3[];


  
  
//soft constraint for the data_status signal
constraint data_status_c{soft data_status==1;}

//soft constraint for  the size of the dynamic array depend on the lenth variable.
 // constraint data_in_size_c{soft data_in.size==(length+4);}

//soft constraint for the length variable
  constraint length_c{soft length>0;}

//soft constraint for the s_addr assign that value to the data_in[1] index place
//constraint data_in1_c{soft data_in[1]==s_addr;}
  
  //constraint for the d_addr is equal to the tmep_mem_data;
 // constraint d_addr_c1{d_addr==temp_mem_data;}
  
//assign the d_addr value to the data_in[0] index place.
//constraint data_in0_c{soft data_in[0]==d_addr;}

//assign the value of length to data_in[2] index position
//constraint data_in2_c{soft data_in[2]==length;}

//assiging the last row of data_in equal to the zero.
 // constraint data_in_size_1_c{soft data_in[data_in.size-1]==0;}
  
//constraint d_addr_c1{soft d_addr inside{31,41,51,61};} 
  
  //constraint temp_mem_data_c{temp_mem_data==d_addr;}
  
  //writting the default constructor for temp_mem_data;
  /*function new(int temp_mem_data=0);
  
  this.temp_mem_data=temp_mem_data;
  endfunction:new*/
  //constraint length_const{length>0;}
  constraint length_const{length<8;}
  constraint data_in_size_const{if (length==0 || length==1) data_in.size==0;
                                else data_in.size()==length-1;}
  //for unique array values we use the unique constraints
  constraint data_in_unique_v_const {unique {data_in};}

//we write the post randomization method 
  function void post_randomize();
    
    parity=d_addr^s_addr^length;
    foreach(data_in[i]) 
  parity=(parity^data_in[i]);
      
    
  endfunction:post_randomize
  
/*function void post_randomize();
  parity=0;
foreach(data_in[i]) begin
  parity=(parity^data_in[i]);
  end

  data_in[data_in.size-1]=parity;

endfunction:post_randomize*/
  
 //we write the copy method 
  function transaction_ag1 do_copy();
  transaction_ag1 trans;
    trans=new();
    trans.data_status=this.data_status;
    trans.data_in=this.data_in;
    trans.s_addr=this.s_addr;
    trans.d_addr=this.d_addr;
    trans.length=this.length;
    trans.parity=this.parity;
    trans.temp_mem_data=this.temp_mem_data;
    return trans;
  endfunction:do_copy
  
endclass:transaction_ag1




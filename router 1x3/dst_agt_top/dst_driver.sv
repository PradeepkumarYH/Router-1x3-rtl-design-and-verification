class dst_driver extends uvm_driver #(dst_xtn);
`uvm_component_utils(dst_driver)
function new(string name="dst_driver",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase); 
super.build_phase(phase);
endfunction

virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
endfunction


virtual task run_phase(uvm_phase phase);
//forever
//begin
//seq_item_port.get_next_item(req);
//send_to_dut();
//seq_item_port.item_done;
//end
//endfunction
//task send_to_dut();
//print.xtn;
endtask
endclass

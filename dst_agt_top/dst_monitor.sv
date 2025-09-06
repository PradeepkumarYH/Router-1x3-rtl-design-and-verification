class dst_monitor extends uvm_monitor;
`uvm_component_utils(dst_monitor)

function new(string name="dst_monitor",uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

endclass

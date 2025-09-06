class router_virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);

	`uvm_component_utils(router_virtual_sequencer)

	function new(string name="router_virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction 

endclass

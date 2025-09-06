class router_env extends uvm_env;
	
	`uvm_component_utils(router_env)
	
	src_agt_top src_agth;
	dst_agt_top dst_agth;
	
	router_env_config m_cfg;

	router_scoreboard sb;
	router_virtual_sequencer v_sequencer;

	function new(string name="router_env",uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",m_cfg))	
			`uvm_fatal(get_type_name(),"getting is failed")
		
		if(m_cfg.has_sagent)
			begin
				src_agth=src_agt_top::type_id::create("src_agt",this);
			end


		if(m_cfg.has_dagent)
			begin
				dst_agth=dst_agt_top::type_id::create("dst_agt",this);
			end

		if(m_cfg.has_scoreboard)
			sb=router_scoreboard::type_id::create("sb",this);

		if(m_cfg.has_virtual_sequencer)
			v_sequencer=router_virtual_sequencer::type_id::create("v_sequencer",this);
		super.build_phase(phase);
	endfunction

endclass



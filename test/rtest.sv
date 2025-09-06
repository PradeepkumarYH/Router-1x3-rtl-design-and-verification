class rtest extends uvm_test;
	
	`uvm_component_utils(rtest)
	
	router_env_config m_cfg;
	router_env env_h;

	src_agent_config src_cfg[];
	dst_agent_config dst_cfg[];

	int no_of_src_agents=1;
	int no_of_dst_agents=3;
	
	bit has_sagent=1;
	bit has_dagent=1;



function new(string name="rtest",uvm_component parent);
	super.new(name,parent);
endfunction


virtual function void build_phase(uvm_phase phase);
	m_cfg=router_env_config::type_id::create("m_cfg");
	m_cfg.s_cfg=new[no_of_src_agents];
	m_cfg.d_cfg=new[no_of_dst_agents];


	if(has_sagent) begin
			src_cfg=new[no_of_src_agents];
			foreach(src_cfg[i])
				begin
					src_cfg[i]=src_agent_config::type_id::create($sformatf("src_cfg[%0d]",i));
					if(!uvm_config_db#(virtual router_if)::get(this,"","vif",src_cfg[i].vif))
						`uvm_fatal(get_type_name(),"getting vif is failed")
					src_cfg[i].is_active=UVM_ACTIVE;
					m_cfg.s_cfg[i]=src_cfg[i];
				end
	end
	

	if(has_dagent) begin
		dst_cfg=new[no_of_dst_agents];
		foreach(dst_cfg[i])
			begin
				dst_cfg[i]=dst_agent_config::type_id::create($sformatf("dst_cfg[%0d]",i));
				if(!uvm_config_db#(virtual router_if)::get(this,"",$sformatf("vif%0d",i),dst_cfg[i].vif))
					`uvm_fatal(get_type_name(),"getting vif is failed")
				dst_cfg[i].is_active=UVM_ACTIVE;
			end
			dst_cfg[2].is_active=UVM_PASSIVE;
			m_cfg.d_cfg=dst_cfg;
	end

	m_cfg.has_sagent=has_sagent;
	m_cfg.has_dagent=has_dagent;
	
	m_cfg.no_of_src_agents=no_of_src_agents;
	m_cfg.no_of_dst_agents=no_of_dst_agents;

	uvm_config_db#(router_env_config)::set(this,"*","router_env_config",m_cfg);
	super.build_phase(phase);

	env_h=router_env::type_id::create("env_h",this);
	
endfunction


endclass

//////////////////////////small_packet//////////////////

class small_test extends rtest;

	`uvm_component_utils(small_test)

	bit[1:0] addr=1;
	small_seqs seq_h;

	function new(string name="small_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
	endfunction

	virtual task run_phase(uvm_phase phase);
		seq_h=small_seqs::type_id::create("seq_h");
		phase.raise_objection(this);
		seq_h.start(env_h.src_agth.agnth[0].seqrh);
		phase.drop_objection(this);
	endtask

endclass



/////////////////////////////////medium_packet////////////////


class medium_test extends rtest;

	`uvm_component_utils(medium_test)

	bit[1:0] addr=1;
	medium_seqs seq_h;

	function new(string name="medium_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
	endfunction

	virtual task run_phase(uvm_phase phase);
		seq_h=medium_seqs::type_id::create("seq_h");
		phase.raise_objection(this);
		seq_h.start(env_h.src_agth.agnth[0].seqrh);
		phase.drop_objection(this);
	endtask

endclass


///////////////////large_packet///////////////////////

class large_test extends rtest;

	`uvm_component_utils(large_test)

	bit[1:0] addr=1;
	large_seqs seq_h;

	function new(string name="large_test",uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_db#(bit[1:0])::set(this,"*","bit[1:0]",addr);
	endfunction

	virtual task run_phase(uvm_phase phase);
		seq_h=large_seqs::type_id::create("seq_h");
		phase.raise_objection(this);
		seq_h.start(env_h.src_agth.agnth[0].seqrh);
		phase.drop_objection(this);
	endtask

endclass


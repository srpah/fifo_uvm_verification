class fifo_agent extends uvm_agent;

`uvm_component_utils(fifo_agent)

fifo_driver driver;
fifo_monitor monitor;
uvm_sequencer #(fifo_seq_item) sequencer;

function new(string name, uvm_component parent);
   super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);

driver = fifo_driver::type_id::create("driver",this);
monitor = fifo_monitor::type_id::create("monitor",this);
sequencer = uvm_sequencer #(fifo_seq_item)::type_id::create("sequencer",this);

endfunction

function void connect_phase(uvm_phase phase);

driver.seq_item_port.connect(sequencer.seq_item_export);

endfunction

endclass
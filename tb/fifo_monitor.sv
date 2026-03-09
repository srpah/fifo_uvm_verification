class fifo_monitor extends uvm_monitor;

`uvm_component_utils(fifo_monitor)

virtual fifo_if vif;

uvm_analysis_port #(fifo_seq_item) ap;

function new(string name, uvm_component parent);
   super.new(name,parent);
   ap = new("ap",this);
endfunction

function void build_phase(uvm_phase phase);

   super.build_phase(phase);

   if(!uvm_config_db #(virtual fifo_if)::get(this,"","vif",vif))
      `uvm_fatal("NOVIF","Virtual interface not set")

endfunction
    
task run_phase(uvm_phase phase);

fifo_seq_item trans;

forever
begin
   @(posedge vif.clk);

   trans = fifo_seq_item::type_id::create("trans");

   trans.wr_en = vif.wr_en;
   trans.rd_en = vif.rd_en;
   trans.data  = vif.data_out;

   ap.write(trans);
end

endtask

endclass
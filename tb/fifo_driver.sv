class fifo_driver extends uvm_driver #(fifo_seq_item);

`uvm_component_utils(fifo_driver)

virtual fifo_if vif;

function new(string name, uvm_component parent);
   super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);

   super.build_phase(phase);

   if(!uvm_config_db #(virtual fifo_if)::get(this,"","vif",vif))
      `uvm_fatal("NOVIF","Virtual interface not set")

endfunction
     
task run_phase(uvm_phase phase);

fifo_seq_item req;

forever
begin
   seq_item_port.get_next_item(req);

   @(posedge vif.clk);

   vif.wr_en  <= req.wr_en;
   vif.rd_en  <= req.rd_en;
   vif.data_in <= req.data;

   seq_item_port.item_done();
end

endtask

endclass
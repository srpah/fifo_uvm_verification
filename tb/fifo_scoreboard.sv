class fifo_scoreboard extends uvm_scoreboard;

`uvm_component_utils(fifo_scoreboard)

uvm_analysis_imp #(fifo_seq_item, fifo_scoreboard) analysis_export;

bit [7:0] queue[$];

function new(string name, uvm_component parent);
   super.new(name,parent);
   analysis_export = new("analysis_export", this);
endfunction

function void write(fifo_seq_item t);

   if(t.wr_en)
      queue.push_back(t.data);

   if(t.rd_en && queue.size()>0)
   begin
      bit [7:0] expected;
      expected = queue.pop_front();

      if(expected != t.data)
         `uvm_error("FIFO","Mismatch detected")
   end

endfunction

endclass
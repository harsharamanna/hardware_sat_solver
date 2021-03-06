`timescale 1ns / 1ps

import common::*;

module decide_branch (input clock, reset, find, 
					  input formula formula_in, 
					  output logic ended,
					  output lit lit_out);

formula formula_s;
lit lit_s;
logic [width_clausearray:0] iterator;
logic computing;
logic finished;

assign lit_out = lit_s;

always_ff @(posedge clock or posedge reset)
begin

	if (reset)
	begin
		
		formula_s <= zero_formula;
		lit_s <= zero_lit;
		iterator <= 1'b0;
		computing <= 1'b0;
		finished <= 1'b0;
		ended <= 1'b0;
		
	end

	else if (clock)
	begin
		
		ended <= 1'b0;
		
		if (find == 1'b1 && computing == 1'b0)
		      begin 
                    formula_s <= formula_in;
                    computing <= 1'b1;
                    finished <= 1'b0;
                    ended <= 1'b0;
		      end
		else if (computing == 1'b1)
		  begin
		      if (formula_s.clauses[iterator].len == 1'b0)
		          begin
			         iterator <= iterator + 1;
		          end
		
		      else
		          begin
		    
			         lit_s.num <= formula_s.clauses[iterator].lits[0].num;
			         lit_s.val <= formula_s.clauses[iterator].lits[0].val;
			         computing <= 1'b0;
			         ended <= 1'b1;
		          end
		
		  end
	end

  end

endmodule

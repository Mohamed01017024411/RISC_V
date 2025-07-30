module controller (
  input [2:0] phase , opcode , 
  input zero ,
  output reg sel , rd , ld_ir , halt , inc_pc , ld_ac , ld_pc , wr , data_e  
);
 always @(*) begin
    // Default outputs
    sel = 1'b0;
    rd = 1'b0;
    ld_ir = 1'b0;
    halt = 1'b0;
    inc_pc = 1'b0;
    ld_ac = 1'b0;
    ld_pc = 1'b0;
    wr = 1'b0;
    data_e = 1'b0; 

   case(phase)
     3'b000:begin sel=1'b1; end //inst_addr
     3'b001:begin sel=1'b1 ; rd=1'b1; end //inst_fetch 
     3'b010:begin sel=1'b1;rd=1'b1;ld_ir=1'b1; end //IDLE 
     3'b011:begin sel=1'b1;rd=1'b1;ld_ir=1'b1; end
     3'b100:begin halt =(opcode==3'b000);
            inc_pc=1;
       end //op_addr
     3'b101: begin 
           rd=(opcode==3'b010)||(opcode==3'b011)||(opcode==3'b100)||(opcode==3'b101); 
      end
     3'b110:begin
          rd=(opcode==3'b010)||(opcode==3'b011)||(opcode==3'b100)||(opcode==3'b101);
          inc_pc=(opcode==3'b001) && zero ;
          ld_pc=(opcode==3'b111) ;
          data_e= (opcode==3'b110);
      end
     3'b111:begin // STORE
            rd = (opcode == 3'b010) || (opcode == 3'b011) || 
                 (opcode == 3'b100) || (opcode == 3'b101);
            ld_ac = (opcode == 3'b010) || (opcode == 3'b011) || 
                    (opcode == 3'b100) || (opcode == 3'b101);
            ld_pc = (opcode == 3'b111); // JMP
            wr = (opcode == 3'b110);    // STO
            data_e = (opcode == 3'b110); // STO
        end
   endcase
 end
endmodule
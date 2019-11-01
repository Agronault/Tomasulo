module IQ(Clock, Reset, Run, enableOut, instructionOut);
  /*
  * Tomsulo com instrucao de desvio e despache duplo das instrucoes
  * Documentacao da Instrucao
  *
  * IMMEDIATE - Rx  - Ry  - OPCODE
  * 000000    - 000 - 000 - 0000
  *
  * INST  - OPCODE
  * ADD.D - 0000
  * SUB.D - 0001
  * BNE.D - 0010
  * L.D   - 0011
  * S.D   - 0100
  */
  
  input Clock, Reset, Run;
  reg Adderin, Adderin2, LDin, SDin, LDin2, SDin2;
  reg [15:0]PC1[63:0]; //Armazena a lista de isntrucoes
  reg [15:0]cr;
  
  output reg enableOut;
  output reg[15:0]instructionOut;
  
  reg [15:0]mem[65536:0]; //Memoria
  wire [15:0] addr;
  
  wire [15:0] R0, R1, R2, R3, R4, R5, R6;
  
  initial
	begin //Fila de Instrucoes
		PC1[0]=16'b0000000000100001;
		PC1[1]=16'b0000000000000001;
		PC1[2]=16'b0000000001000001;
		PC1[3]=16'b0000000000001010;
		PC1[4]=16'b0000001111010000;
		PC1[5]=16'b0000000101000011;
		PC1[6]=16'b0000001011111010;
	end

	
	always @ (posedge Clock)
	begin
	  if (Reset == 1'b0 && Run == 1'b1)
	    Adderin = 0;
	    LDin = 0;
	    SDin = 0;
	    Adderin2 = 0;
	    LDin2 = 0;
	    SDin2 = 0;
	    begin
	     // Primeiro Despacho
	     case(PC1[cr][3:0])
	       4'b0000: //estacao de reserva adders
	       begin
	         Adderin = 1;
	         
	       end
	       4'b0001: //estacao de reserva adders
	       begin
	         Adderin = 1;
	         
	       end
	       4'b0010: //estacao de reserva adders
	       begin
	         Adderin = 1;
	         
	       end
	       4'b0011: //load buffer
	       begin
	         LDin = 1;
	         
	       end
	       4'b0100: //store buffer
	       begin
	         SDin = 1;
	         
	       end
	     endcase
	     // Segundo Despacho
	     case(PC1[cr + 1'b1][3:0])
	       4'b0000: //estacao de reserva adders
	       begin
	         Adderin2 = 1;
	         
	       end
	       4'b0001: //estacao de reserva adders
	       begin
	         Adderin2 = 1;
	         
	       end
	       4'b0010: //estacao de reserva adders
	       begin
	         Adderin2 = 1;
	         
	       end
	       4'b0011: //load buffer
	       begin
	         LDin2 = 1;
	         
	       end
	       4'b0100: //store buffer
	       begin
	         SDin2 = 1;
	         
	       end
	     endcase
	     // cr anda de 2 em 2 posicoes na fila de instrucoes
	     cr = cr + 2'b10;
	   end
	   if (Reset == 1)
	     begin
	     cr = 0;
	     Adderin = 0;
	     LDin = 0;
	     SDin = 0;
	     Adderin2 = 0;
	     LDin2 = 0;
	     SDin2 = 0;
	     end
	end
	
  
endmodule
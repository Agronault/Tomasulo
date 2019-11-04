module UnidadeFuncional(clock, instruction, instructIn, instructionCodeIn, instructionCodeOut, done, currentInst, dout, reg1, reg2);
input [2:0]instructionCodeIn;
output reg[2:0]instructionCodeOut;
input [15:0]instruction;
input instructIn, clock;
input [15:0] reg1, reg2;
output reg done;
output reg [15:0]dout, currentInst;
integer i;

always @(posedge clock)
begin
  done=0;	
	
	if(instructIn == 1)
	begin	
		currentInst = instruction;
		i = 1;
		instructionCodeOut = instructionCodeIn;
		case(instruction[3:0])
		4'b0000: dout <= reg1 + reg2;
		4'b0001: dout <= reg1 - reg2;
		//complete
		endcase
	end
	else
		i = i + 1;
	
	if(instruction[3:0] == 4'b0000 || instruction[3:0] == 4'b0001) //add e sub
	begin
		if(i == 3)
			done = 1'b1;
	end
	else //sd e ld
	begin
		done = 1'b1;
	end
end

endmodule
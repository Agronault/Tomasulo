module CDB (clock, Reset, Run);
  
  input clock;
  input Reset, Run;
  
  wire [15:0]R1, R2, R3, R4, R5, R6, R7, dataIn, instructionOut;
  wire enableOut;
  
  reg dataAddress[2:0];
  reg writeEnable;
  
  
  initial begin
  writeEnable = 0;
  dataAddress = 0;
  end
  
  FPregisters fpreg(clock, dataIn, dataAddress, writeEnable, R1, R2, R3, R4, R5, R6, R7); //registradores propriamente ditos
  
  IQ queue(clock, Reset, Run, enableOut, instructionOut); //fila de instrucoes
  
  RSadders RSa1(instruction, Clock, Adderin, Busy, R1, R2, R3, R4, R5, R6, R7, instOutEnable, instOut, done, dout, doutAddress); //falta wires

  RSstore RSs1(clock, instruction, instructionIn, memoIn, memoAddr, registerStatusB0, registerStatusB1, registerStatusB2, registerStatusB3,
               requestRegister, requestAddress, requestEnable,
               R1, R2, R3, R4, R5, R6, R7); //falta wires
              
  RSload RSl1(clock, instruction, instructionIn, registerStatusB0, registerStatusB1,
             registerStatusB2, registerStatusB3, done, doneInst, requestRegister,
             requestAddress, requestEnable, R1, R2, R3, R4, R5, R6, R7,
             registerStatusChange, registerStatusAddr, registerStatusEnable); //falta wires

endmodule
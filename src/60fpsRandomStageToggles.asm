.psx

ToggleFPS:
  lh v0,lo(FPSSetting)(v0)
  lui at,0x800A  ; original instruction
  j ToggleFPSReturn
  addi v0,v0,1

ToggleRandomStage:
  lh v0,lo(RandomStageSetting)(v0)
  nop
  bne v0,r0,@@NoRandomStage
  lui v0,hi(FrameCounter)
  lw v0,lo(FrameCounter)(at)
  j ToggleRandomStageReturn
  andi v0,v0,0x7
  
  @@NoRandomStage:
  jal 0x800378BC
  nop
  j ToggleRandomStageReturn
  nop

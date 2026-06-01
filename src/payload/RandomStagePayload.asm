.psx

ToggleRandomStage:
  lh v0,lo(RandomStageSetting)(v0)  ; load random stage setting
  lui ra,hi(ToggleRandomStageReturn)
  bne v0,r0,@@NoRandomStage         ; if random stages are disabled...
  lui v0,hi(FrameCounter)           ; if random stages are enabled:
  lw v0,lo(FrameCounter)(v0)        ; we load the universal frame counter (for RNG)
  j ToggleRandomStageReturn
  andi v0,v0,0x7                    ; and % 7 = our random stage! Thank god it's a power of 2 lol
  
  @@NoRandomStage:
  j 0x800378BC  ; ...then we use the "recall last stage" function, then return
  addi ra,ra,lo(ToggleRandomStageReturn)

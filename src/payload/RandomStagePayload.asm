.psx

ToggleRandomStage:
  lw v0,lo(FrameCounter)(at)        ; we load the universal frame counter (for RNG)
  j ToggleRandomStageReturn
  andi v0,v0,0x7                    ; and % 7 = our random stage! Thank god it's a power of 2 lol

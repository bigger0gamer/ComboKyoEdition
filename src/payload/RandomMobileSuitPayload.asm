.psx

; free registers: a0, t1, v0
; s0 - controller inputs

RandomMobileSuit:
  andi v0,s0,0x0100
  beq v0,r0,@@Skip
  lui v0,hi(RandomMechRNGY)
  lw v0,lo(RandomMechRNGY)(v0)
  nop
  sw v0,0x000(v1)
  
  @@Skip:
  j RandomMobileSuitReturn
  nop

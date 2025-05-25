.psx

; registers can be used freely: v1, a0, v0, at
; a2: contains 0 when player 2 inputs being read, otherwise it's reading player 1 inputs
; Goal:
; Read Player 2 inputs: 800EA9C5 (1 frame stale) -> 800BE370 (fresh off the controller bus)

InputFix:
  bne a2,r0,@@Skip                   ; if reading player 1 inputs, skip the input fix
  nop
  lui at,hi(Player2TrueInput)
  lbu v1,lo(Player2TrueInput)(at)    ; read player 2 "raw" inputs
  j InputFixReturn
  lbu a0,lo(Player2TrueInput)+1(at)  ; instead of stale inputs
  
  @@Skip:
  lbu v1,0x0002(s0)  ; original instruction
  j InputFixReturn
  lbu a0,0x0003(s0)  ; original instruction

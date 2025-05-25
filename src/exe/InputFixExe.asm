.psx

; Input reader cut away
.org 0x80014E48
  j InputFix
  nop
.org 0x80014E50 :: InputFixReturn:
.org 0x800EA9C5 :: Player2TrueInput:

.psx

.org 0x80018920
  addi v0,r0,0xA  ; make static
.org 0x80018968
  lbu v1,0(s0)    ; make slightly more efficient
  sw v0,8(s1)
  sw v1,0(s1)
  nop
  lui v0,0


.org 0x80018978 :: ExpandedMusicReturn:
.org 0x80018934
  j ExpandedMusic
  addi a1,a1,-0xB

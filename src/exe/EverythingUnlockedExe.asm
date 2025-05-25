.psx

; Unlock Everything
.org 0x8001C23C
  j UnlockEverything
  .org 0x8001C244 :: UnlockEverythingReturn:

; Fix Survival Mode Crash
; Instead of bothering to fill out a table of valid opponents,
; I decided to force it to load them all as valid and ignore the table
.org 0x8001CFF0
  addi v0,r0,1

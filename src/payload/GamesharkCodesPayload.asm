.psx

; free registers for use: v0, v1, at, s1 (set to 0 when done)
; t0-t7, ra, a0 (flushed to RAM and restored), intended for hidden mech args but can be temp registers elsewhere
; s1 should be used for comparisions/branches
; at should be left with 80200000 in it (lui at,CustomVars)
; v0/v1 are just temps

GamesharkCodes:
  sw v0,0x502c(at)  ; original instruction
  
  ; we're gonna need to free up some registers so that we can use some of them as
  ; method arguments, to help shorten the total code length.
  ; We'll free t0-t7 and a0 to use all of them as agruments
  ; likewise, we'll be freeing up ra so we can use jals
  lui at,hi(TempReturnAddress)
  sw a0,lo(a0TempAddress)(at)
  sw t0,lo(t0TempAddress)(at)
  sw t1,lo(t1TempAddress)(at)
  sw t2,lo(t2TempAddress)(at)
  sw t3,lo(t3TempAddress)(at)
  sw t4,lo(t4TempAddress)(at)
  sw t5,lo(t5TempAddress)(at)
  sw t6,lo(t6TempAddress)(at)
  sw t7,lo(t7TempAddress)(at)
  sw ra,lo(TempReturnAddress)(at)
  
  ; and now, all the shit we need to do at the end of the frame!
  .include "payload/gameshark/RNGPayload.asm"
  .include "payload/gameshark/HiddenMechPayload.asm" :: EndOfHiddenMech:
  .include "payload/gameshark/RandomMusicPayload.asm"
  .include "payload/gameshark/StringReplacerPayload.asm" :: EndOfStringReplacer:
  
  ; and now that we're done with this whole method, let's restore the register state
  lw a0,lo(a0TempAddress)(at)
  lw t0,lo(t0TempAddress)(at)
  lw t1,lo(t1TempAddress)(at)
  lw t2,lo(t2TempAddress)(at)
  lw t3,lo(t3TempAddress)(at)
  lw t4,lo(t4TempAddress)(at)
  lw t5,lo(t5TempAddress)(at)
  lw t6,lo(t6TempAddress)(at)
  lw t7,lo(t7TempAddress)(at)
  lw ra,lo(TempReturnAddress)(at)
  j GamesharkCodesReturn
  lui s1,0

.psx

; free registers for use: v0, v1, at, s1 (set to 0 when done)
; t0-t7, ra, a0 (flushed to RAM and restored), intended for hidden mech args but can be temp registers elsewhere
; s1 should be used for comparisions/branches
; at should be left with 80200000 in it (lui at,CustomVars)
; v0/v1 are just temps
; a1 also probably free

; looking at the code, this whole elaborate attempt to preserve register state was
; ...completely unneeded? the t registers are temp registers by design, and I don't see them
; in immediate use so it's probably safe to do whatever with them.
; a0 is disregarded eventually (though it was a pain to look).
; hell, the original code even already saved ra to the stack right fucking above my cut!
; I really didn't even fucking look! I do still have to set s1 to 0, which it also did right above.
; Since that extra register is useful, I replaced the original instruction setting s1 to 0 with
; a later one so I don't have to do any original instuctions here except making s1 0 lol

GamesharkCodes:
  .include "payload/gameshark/RNGPayload.asm"
  .include "payload/gameshark/HiddenMechPayload.asm"
  .include "payload/gameshark/RandomMusicPayload.asm"
  .include "payload/gameshark/StringReplacerPayload.asm"
  
  j GamesharkCodesReturn
  lui s1,0
  
  .include "payload/gameshark/GamesharkFunctionsPayload.asm"

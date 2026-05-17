.psx

; I ended up shortening a fuck of shit by making callable functions for shit I repeated a lot
; This ended up fucking with the "one really long stretch of instructions" assumption I made
; when putting so much different shit after this global frame counter code thingy as a crude
; imitation of gameshark cheats, so I ended up having to jump past these functions.
; Instead of doing that, I'm gonna collect these functions here so I don't have to jump past them.
; This of course, scatters relevent code all over the fucking place. A small price to pay
; to shorten the code by a handful of instructions. I'm trying to save every word I can here!



; arguments:
; t0 - random range upper limit (exclusive)
; t1 - RAM address to save result to
; t2 - must be free
RNGWrapper:
  add t2,ra,r0
  jal 0x80077B04
  nop
  divu a0,t0
  mfhi a0
  jr t2
  sh a0,0(t1)



; main hidden mech function, should be called twice (once for each player)
; arguments:
; t0 - PlayerHandicap
; t1 - PlayerJokerJust
; t2 - PlayerHiddenMech
; t3 - PlayerSampleCountdown
; t4 - PlayerHandicapMechNamePointer
; t5 - PlayerSample
; t6 - sample countdown number (7 for P1, 8 for P2)
; t7 - original sample pointer for reset (0xD3FE for player 1, 0xCDE0 for player 2)
; s1 - PlayerSamplePointer
; a0 - PlayerCharacterID
; a1 - original sample for reset
HiddenMech:
  lh v0,0x0(t0)                  ; load player handicap
  lh v1,0x0(t1)                  ; load player new inputs this frame
  beq v0,r0,PlayerMechReset    ; if player handicap is 0, then reset hidden mech variable
  addi v0,v0,-1
  bne v0,r0,EndOfPlayer        ; if player handicap is 1, then process player inputs
  
  ; The O
  andi v0,v1,0x04
  beq v0,r0,ZedGundam          ; if holding L1, then write The O to hidden mech variable
  addi v0,r0,6                   ; set mech ID
  lui v1,hi(TheOTexture)         ; set player mech name plate pointer
  addi v1,v1,lo(TheOTexture)
  j SetHiddenMech
  addi t1,r0,0x1B                ; set player sample
  
  ZedGundam:
  andi v0,v1,0x01
  beq v0,r0,@@Qubeley            ; if holding L2, then write ZGundam to hidden mech variable
  addi v0,r0,0xD                 ; set mech ID
  lui v1,hi(ZedGundamTexture)    ; set player mech name plate pointer
  addi v1,v1,lo(ZedGundamTexture)
  j SetHiddenMech
  addi t1,r0,0x22                ; set player sample
  
  @@Qubeley:
  andi v0,v1,0x08
  beq v0,r0,@@HammaHamma         ; if holding R1, then write Qubeley to hidden mech variable
  addi v0,r0,0xF
  lui v1,hi(QubeleyTexture)      ; set player mech name plate pointer
  addi v1,v1,lo(QubeleyTexture)
  j SetHiddenMech
  addi t1,r0,0x24                ; set player sample
  
  @@HammaHamma:
  andi v0,v1,0x02
  beq v0,r0,EndofPlayer        ; if holding R2, then write Hamma Hamma to hidden mech variable
  addi v0,r0,0x10
  lui v1,hi(HammaHammaTexture)   ; set player mech name plate pointer
  addi v1,v1,lo(HammaHammaTexture)
  j SetHiddenMech
  addi t1,r0,0x25                ; set player sample
  
  EndOfPlayer:
  ; Character ID Replacement & Sample Pointer Redirection
  lh v0,0x0(t2)
  lh v1,0x2(t3)
  beq v0,r0,@@EndOfFunction
  nop
  sh t7,0x0(s1)
  sh v0,0x0(a0)
  beq v1,r0,@@EndOfFunction
  nop
  sh a1,0x0(t5)
  
  @@EndOfFunction:
  jr ra
  nop
  
  PlayerMechReset:
  jr ra
  sh r0,0x0(t2)                  ; reset hidden mech variable to 0


; meant to be called by HiddenMech, once its matched player inputs to a mech
; args:
; t0    - copy ra to t0 before jaling, then restore on return
; t1    - mech sound effect value
; t2-t7 - untouched from HiddenMech
; v0    - mechID to write 
; v1    - mech texture pointer
; s1    - untouched from HiddenMech
SetHiddenMech:
  sh v0,0x0(t2)  ; save mech ID to custom var
  sh t6,0x0(t3)  ; save sound sfx countdown
  sw v1,0x0(t4)  ; save mech nameplate pointer
  jr ra
  sh t1,0x0(t5)  ; save player sample



; Oh, my, god! A real fucking function!
;   - Yuri Bacon, writing her first ASM function
;
; I also never noted this anywhere, but 0xFF is the termination byte, and it ofc doesn't get saved.
; If you want the 0xFF to be copied too, you can just add "sb t0,0x0(v0)" after calling this function.
; Also importantly: 0x00 doesn't terminate this function, but it *does* get skipped. I did this as
; a way to simplify the code for making minor alterations to an entire area of data, but didn't think
; through how wasteful it would be to basically have an entire second table containing only edits
; for another one, so I ended up only using this for editing "VERSUS 2P" into "COMBOKYO".
; I couldn't be bothered to shorten it somehow, especially since it'd lead to more calls for the edits,
; but you *should* be able to save more space that way, if you need it.
; More notably though: This is why some text uses 0x20 instead of the proper 0x00, because 0x00 wouldn't copy
; and 0x20 convienently did nothing to the text so it worked all the same.
; 
; arguments:
;  v0 - the old string to replace
;  v1 - the new string to copy
;  t0 - data byte
;  t1 - termination byte
StringCopy:
  ; we'll need this to compare the loaded byte to the termination byte
  addi t1,r0,0xFFFF
  addi v0,v0,0xFFFF ; and this is because v0 is updated before saving new byte, so this corrects the mistiming
  
  @@StartOfLoop:
  lb t0,0x0(v1)   ; load the next byte!
  addi v1,v1,0x1  ; advance new string byte for next loop
  
  ; If new byte == 0, we skip saving it 
  beq t0,r0,@@StartOfLoop
  addi v0,v0,0x1  ; advance old string byte for next loop
  
  ; if new byte == FF, break loop and also skip saving it
  beq t0,t1,@@EndOfLoop
  nop
  
  ; time to overwrite the old byte with the new one! Trunks, get the time machine!
  j @@StartOfLoop
  sb t0,0x0(v0)
  
  ; string replacement complete!
  @@EndOfLoop:
  jr ra
  nop


; v0: half pointer
; a0: pointer base address
MenuTextSpecialPointers:
  ori v1,r0,0xE000
  andi at,v0,0xE000
  bne v1,at,@@SkipSpecialPointer
  nop
  lui a0,0x801F
  
  @@SkipSpecialPointer:
  j MenuTextSpecialPointersReturn
  nop

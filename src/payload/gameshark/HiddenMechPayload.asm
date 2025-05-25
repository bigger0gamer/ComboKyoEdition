.psx

lui v0,hi(MenuCanary)
lh v0,lo(MenuCanary)(v0)   ; if not in menu
nop
beq v0,r0,EndOfHiddenMech  ; then skip hidden mech codes


; player 1 hidden mech
li t0,Player1Handicap
li t1,Player1JokerJust
addi t2,at,lo(Player1HiddenMech)
lui t5,hi(Player1SampleCountDown)
addi t3,t5,lo(Player1SampleCountDown)
addi t4,t5,lo(Player1HandicapMechNamePointer)
addi s1,t5,lo(Player1SamplePointer)
addi t6,r0,7
li t5,Player1Sample
li a0,Player1CharacterID
addi t7,r0,0xD3FE
jal HiddenMech
addi at,r0,0x23                ; reset player sample

; player 2 hidden mech
lui at,hi(TempReturnAddress)
li t0,Player2Handicap
li t1,Player2JokerJust
addi t2,at,lo(Player2HiddenMech)
lui t5,hi(Player2SampleCountDown)
addi t3,t5,lo(Player2SampleCountDown)
addi t4,t5,lo(Player2HandicapMechNamePointer)
addi s1,t5,lo(Player2SamplePointer)
addi t6,r0,8
li t5,Player2Sample
li a0,Player2CharacterID
addi t7,r0,0xCDE0
jal HiddenMech
addi at,r0,0x15                ; reset player sample

j EndOfHiddenMech
lui at,hi(TempReturnAddress)


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
; at - original sample for reset
HiddenMech:
  lh v0,0x0(t0)                  ; load player handicap
  nop
  beq v0,r0,@@PlayerMechReset    ; if player handicap is 0, then reset hidden mech variable
  addi v0,v0,-1
  bne v0,r0,@@EndOfPlayer        ; if player handicap is 1, then process player inputs
  lh v1,0x0(t1)                  ; load player new inputs this frame
  nop
  
  ; The O
  andi v0,v1,0x04
  beq v0,r0,@@ZedGundam          ; if holding L1, then write The O to hidden mech variable
  addi v0,r0,6                   ; set mech ID
  lui v1,hi(TheOTexture)         ; set player mech name plate pointer
  addi v1,v1,lo(TheOTexture)
  add t0,ra,r0                   ; copy ra to t0 for safe keeping
  j SetHiddenMech
  addi t1,r0,0x1B                ; set player sample
  j @@EndOfPlayer
  add ra,t0,r0                   ; restore t0 to ra
  
  @@ZedGundam:
  andi v0,v1,0x01
  beq v0,r0,@@Qubeley            ; if holding L2, then write ZGundam to hidden mech variable
  addi v0,r0,0xD                 ; set mech ID
  lui v1,hi(ZedGundamTexture)    ; set player mech name plate pointer
  addi v1,v1,lo(ZedGundamTexture)
  add t0,ra,r0                   ; copy ra to t0 for safe keeping
  j SetHiddenMech
  addi t1,r0,0x22                ; set player sample
  j @@EndOfPlayer
  add ra,t0,r0                   ; restore t0 to ra
  
  @@Qubeley:
  andi v0,v1,0x08
  beq v0,r0,@@HammaHamma         ; if holding R1, then write Qubeley to hidden mech variable
  addi v0,r0,0xF
  lui v1,hi(QubeleyTexture)      ; set player mech name plate pointer
  addi v1,v1,lo(QubeleyTexture)
  add t0,ra,r0                   ; copy ra to t0 for safe keeping
  j SetHiddenMech
  addi t1,r0,0x24                ; set player sample
  j @@EndOfPlayer
  add ra,t0,r0                   ; restore t0 to ra
  
  @@HammaHamma:
  andi v0,v1,0x02
  beq v0,r0,@@EndofPlayer        ; if holding R2, then write Hamma Hamma to hidden mech variable
  addi v0,r0,0x10
  lui v1,hi(HammaHammaTexture)   ; set player mech name plate pointer
  addi v1,v1,lo(HammaHammaTexture)
  add t0,ra,r0                   ; copy ra to t0 for safe keeping
  j SetHiddenMech
  addi t1,r0,0x25                ; set player sample
  j @@EndOfPlayer
  add ra,t0,r0                   ; restore t0 to ra
  
  @@PlayerMechReset:
  sh r0,0x0(t2)                  ; reset hidden mech variable to 0
  jr ra
  nop;sh at,0x0(t5)
  
  @@EndOfPlayer:
  ; Character ID Replacement & Sample Pointer Redirection
  lh v0,0x0(t2)
  lh v1,0x2(t3);nop
  beq v0,r0,@@EndOfFunction
  nop
  sh t7,0x0(s1)
  sh v0,0x0(a0)
  beq v1,r0,@@EndOfFunction
  nop
  sh at,0x0(t5)
  
  @@EndOfFunction:
  jr ra
  nop


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

.psx

; free registers for use: v0, v1, at, s1 (set to 0 when done)

GamesharkCodes:
  sw v0,0x502c(at)  ; original instruction
  
  ; Player 1 Hidden Mech
  lui v0,hi(MenuCanary)
  lh v0,lo(MenuCanary)(v0)
  nop
  beq v0,r0,@@MusicReplacements
  lui v0,hi(Player1Handicap)
  lh v0,lo(Player1Handicap)(v0)   ; load player 1 handicap
  nop
  beq v0,r0,@@Player1MechReset    ; if player 1 handicap is 0, then reset hidden mech variable
  addi v0,v0,-1
  bne v0,r0,@@EndOfPlayer1        ; if player 1 handicap is 1, then process player inputs
  lui v0,hi(Player1JokerJust)
  lh v0,lo(Player1JokerJust)(v0)  ; load player 1 new inputs this frame
  lui v1,hi(Player1HiddenMech)
  
  ; The O
  andi at,v0,0x04
  beq at,r0,@@ZedGundam1          ; if holding L1, then write The O to hidden mech variable
  addi at,r0,6
  sh at,lo(Player1HiddenMech)(v1)
  addi at,r0,7                    ; set player 1 sfx countdown
  lui v1,hi(Player1SampleCountdown)
  sh at,lo(Player1SampleCountdown)(v1)
  addi at,r0,0x1B                 ; set player 1 sample
  lui v1,hi(Player1Sample)
  j @@EndOfPlayer1
  sh at,lo(Player1Sample)(v1)
  
  @@ZedGundam1:
  andi at,v0,0x01
  beq at,r0,@@Qubeley1            ; if holding L2, then write ZGundam to hidden mech variable
  addi at,r0,0xD
  sh at,lo(Player1HiddenMech)(v1)
  addi at,r0,7                    ; set player 1 sfx countdown
  lui v1,hi(Player1SampleCountdown)
  sh at,lo(Player1SampleCountdown)(v1)
  addi at,r0,0x22                 ; set player 1 sample
  lui v1,hi(Player1Sample)
  j @@EndOfPlayer1
  sh at,lo(Player1Sample)(v1)
  
  @@Qubeley1:
  andi at,v0,0x08
  beq at,r0,@@HammaHamma1         ; if holding R1, then write Qubeley to hidden mech variable
  addi at,r0,0xF
  sh at,lo(Player1HiddenMech)(v1)
  addi at,r0,7                    ; set player 1 sfx countdown
  lui v1,hi(Player1SampleCountdown)
  sh at,lo(Player1SampleCountdown)(v1)
  addi at,r0,0x24                 ; set player 1 sample
  lui v1,hi(Player1Sample)
  j @@EndOfPlayer1
  sh at,lo(Player1Sample)(v1)
  
  @@HammaHamma1:
  andi at,v0,0x02
  beq at,r0,@@EndofPlayer1        ; if holding R2, then write Hamma Hamma to hidden mech variable
  addi at,r0,0x10
  sh at,lo(Player1HiddenMech)(v1)
  addi at,r0,7                    ; set player 1 sfx countdown
  lui v1,hi(Player1SampleCountdown)
  sh at,lo(Player1SampleCountdown)(v1)
  addi at,r0,0x25                 ; set player 1 sample
  lui v1,hi(Player1Sample)
  j @@EndOfPlayer1
  sh at,lo(Player1Sample)(v1)
  
  @@Player1MechReset:
  lui v1,hi(Player1HiddenMech)
  sh r0,lo(Player1HiddenMech)(v1)  ; reset hidden mech variable to 0
  addi at,r0,0x23                  ; reset player 1 sample
  lui v1,hi(Player1Sample)
  sh at,lo(Player1Sample)(v1)
  @@EndOfPlayer1:
  
  
  
  ; Player 2 Hidden Mech
  lui v0,hi(Player2Handicap)
  lh v0,lo(Player2Handicap)(v0)   ; load player 2 handicap
  nop
  beq v0,r0,@@Player2MechReset    ; if player 2 handicap is 0, then reset hidden mech variable
  addi v0,v0,-1
  bne v0,r0,@@EndOfPlayer2        ; if player 2 handicap is 1, then process player inputs
  lui v0,hi(Player2JokerJust)
  lh v0,lo(Player2JokerJust)(v0)  ; load player 2 new inputs this frame
  lui v1,hi(Player2HiddenMech)
  
  ; The O
  andi at,v0,0x04
  beq at,r0,@@ZedGundam2          ; if holding L1, then write The O to hidden mech variable
  addi at,r0,6
  sh at,lo(Player2HiddenMech)(v1)
  addi at,r0,8                    ; set player 2 sfx countdown
  lui v1,hi(Player2SampleCountdown)
  sh at,lo(Player2SampleCountdown)(v1)
  addi at,r0,0x1B                 ; set player 2 sample
  lui v1,hi(Player2Sample)
  j @@EndOfPlayer2
  sh at,lo(Player2Sample)(v1)
  
  @@ZedGundam2:
  andi at,v0,0x01
  beq at,r0,@@Qubeley2            ; if holding L2, then write ZGundam to hidden mech variable
  addi at,r0,0xD
  sh at,lo(Player2HiddenMech)(v1)
  addi at,r0,8                    ; set player 2 sfx countdown
  lui v1,hi(Player2SampleCountdown)
  sh at,lo(Player2SampleCountdown)(v1)
  addi at,r0,0x22                 ; set player 2 sample
  lui v1,hi(Player2Sample)
  j @@EndOfPlayer2
  sh at,lo(Player2Sample)(v1)
  
  @@Qubeley2:
  andi at,v0,0x08
  beq at,r0,@@HammaHamma2         ; if holding R1, then write Qubeley to hidden mech variable
  addi at,r0,0xF
  sh at,lo(Player2HiddenMech)(v1)
  addi at,r0,8                    ; set player 2 sfx countdown
  lui v1,hi(Player2SampleCountdown)
  sh at,lo(Player2SampleCountdown)(v1)
  addi at,r0,0x24                 ; set player 2 sample
  lui v1,hi(Player2Sample)
  j @@EndOfPlayer2
  sh at,lo(Player2Sample)(v1)
  
  @@HammaHamma2:
  andi at,v0,0x02
  beq at,r0,@@EndofPlayer2        ; if holding R2, then write Hamma Hamma to hidden mech variable
  addi at,r0,0x10
  sh at,lo(Player2HiddenMech)(v1)
  addi at,r0,8                    ; set player 2 sfx countdown
  lui v1,hi(Player2SampleCountdown)
  sh at,lo(Player2SampleCountdown)(v1)
  addi at,r0,0x25                 ; set player 2 sample
  lui v1,hi(Player2Sample)
  j @@EndOfPlayer2
  sh at,lo(Player2Sample)(v1)
  
  @@Player2MechReset:
  lui v1,hi(Player2HiddenMech)
  sh r0,lo(Player2HiddenMech)(v1)  ; reset hidden mech variable to 0
  addi at,r0,0x15                  ; reset player 2 sample
  lui v1,hi(Player2Sample)
  sh at,lo(Player2Sample)(v1)
  @@EndOfPlayer2:
  
  
  ; Character ID Replacement & Sample Pointer Redirection
  lui v1,hi(Player1HiddenMech)
  lh v0,lo(Player1HiddenMech)(v1)
  nop
  beq v0,r0,@@Player2HiddenMech
  addi at,r0,0xD3FE
  lui v1,hi(Player1SamplePointer)
  sh at,lo(Player1SamplePointer)(v1)
  lui v1,hi(Player1CharacterID)
  sh v0,lo(Player1CharacterID)(v1)
  
  @@Player2HiddenMech:
  lui v1,hi(Player2HiddenMech)
  lh v0,lo(Player2HiddenMech)(v1)
  nop
  beq v0,r0,@@MusicReplacements
  addi at,r0,0xCDE0
  lui v1,hi(Player2SamplePointer)
  sh at,lo(Player2SamplePointer)(v1)
  lui v1,hi(Player2CharacterID)
  sh v0,lo(Player2CharacterID)(v1)
  
  
  @@MusicReplacements:
  lui v0,hi(Player1CharacterID)
  lh v1,lo(Player1CharacterID)(v0)
  addi at,r0,0x12
  beq v1,at,@@BestTheme
  lh v1,lo(Player2CharacterID)(v0)
  nop
  beq v1,at,@@BestTheme
  nop
  j @@SkipBestTheme
  nop
  
  @@BestTheme:
  addi at,r0,2
  lui v0,hi(MusicID)
  sh at,lo(MusicID)(v0)
  
  @@SkipBestTheme:
  lui v0,hi(Player1CharacterID)
  lh v1,lo(Player1CharacterID)(v0)
  addi at,r0,0xE
  beq v1,at,@@AcguyTheme
  lh v1,lo(Player2CharacterID)(v0)
  nop
  beq v1,at,@@AcguyTheme
  nop
  j @@SkipAcguyTheme
  nop
  
  @@AcguyTheme:
  addi at,r0,8
  lui v0,hi(MusicID)
  sh at,lo(MusicID)(v0)
  
  @@SkipAcguyTheme:
  j GamesharkCodesReturn
  nop

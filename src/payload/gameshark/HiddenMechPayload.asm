.psx

lui v0,hi(MenuCanary)
lh v0,lo(MenuCanary)(v0)   ; if not in menu
lui at,hi(TempReturnAddress)
beq v0,r0,EndOfHiddenMech  ; then skip hidden mech codes


; player 1 hidden mech
addi t0,at,lo(Player1Handicap)
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
addi a1,r0,0x23                ; reset player sample

; player 2 hidden mech
addi t0,at,lo(Player2Handicap)
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
addi a1,r0,0x15                ; reset player sample

EndOfHiddenMech:

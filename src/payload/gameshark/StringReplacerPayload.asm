.psx

; Check to see if were in the menu, and haven't replaced strings yet
lui t0,hi(MenuCanary)
lh v0,lo(MenuCanary)(t0)
lh v1,lo(StringsReplaced)(at)
beq v0,r0,@@Skip                 ; if not in menu, skip
nop
bne v1,r0,EndOfStringReplacer    ; if strings already replaced, also skip
nop


; Time for all the magic fun fun!

; Game Options Menu Expanded Pointers List
lui v0,hi(GameOptionsEightName)
addi v0,v0,lo(GameOptionsEightName)
jal StringCopy
addi v1,at,lo(ExpandedOptionsEight)

lui v0,hi(GameOptionsSevenName)
addi v0,v0,lo(GameOptionsSevenName)
jal StringCopy
addi v1,at,lo(ExpandedOptionsSeven)

lui v0,hi(GameOptionsSixName)
addi v0,v0,lo(GameOptionsSixName)
jal StringCopy
addi v1,at,lo(ExpandedOptionsSix)

lui v0,hi(GameOptionsFiveName)
addi v0,v0,lo(GameOptionsFiveName)
jal StringCopy
addi v1,at,lo(ExpandedOptionsFive)

lui v0,hi(GameOptionsThreeSelections)
addi v0,v0,lo(GameOptionsThreeSelections)
jal StringCopy
addi v1,at,lo(SwappedPilotDisplay)

; now time to set StringsReplaced to 1 so we don't do this again for a while
addi v0,r0,0x1


@@Skip:
sh v0,lo(StringsReplaced)(at)  ; if not in menu, reset "Strings Replaced" variable

EndOfStringReplacer:

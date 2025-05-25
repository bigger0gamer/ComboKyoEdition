.psx

; Check to see if were in the menu, and haven't replaced strings yet
lui v0,hi(MenuCanary)
lh v0,lo(MenuCanary)(v0)
nop
beq v0,r0,@@SkipReset            ; if not in menu, skip
lui v0,hi(StringsReplaced)
lh v0,lo(StringsReplaced)(v0)
nop
bne v0,r0,@@Skip                 ; if strings already replaced, also skip
nop


; Time for all the magic fun fun!
; Versus 2P -> ComboKyo replacment
lui v0,hi(Versus2P)
addi v0,v0,lo(Versus2P)
jal StringCopy
addi v1,at,lo(ComboKyoString)

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

lui v0,hi(GameOptionsFourSelections)
addi v0,v0,lo(GameOptionsFourSelections)
jal StringCopy
addi v1,at,lo(RenamedHitDisplay)

; now time to set StringsReplaced to 1 so we don't do this again for a while
addi v1,r0,0x1
lui v0,hi(StringsReplaced)
sh v1,lo(StringsReplaced)(v0)


@@Skip:
j EndOfStringReplacer
nop

@@SkipReset:
j EndOfStringReplacer
sh r0,lo(StringsReplaced)(v0)  ; if not in menu, reset "Strings Replaced" variable


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
  nop;addi s1,r0,0x0  ; NOTE: not necessary?


; v0: half pointer
; a0: pointer base address
MenuTextSpecialPointers:
  nop
  andi at,v0,0xE000
  ori v1,r0,0xE000
  bne v1,at,@@SkipSpecialPointer
  nop
  lui a0,0x801F
  
  @@SkipSpecialPointer:
  j MenuTextSpecialPointersReturn
  nop

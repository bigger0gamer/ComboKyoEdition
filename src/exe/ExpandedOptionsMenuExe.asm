.psx

; Game Options extended to 8 slots
.org 0x8009AB94 :: .byte 0x07

; Game Options slots 5-7 have 2 options
.org 0x8009ABC2 :: .byte 0x01
.org 0x8009ABC8 :: .byte 0x01
.org 0x8009ABCC :: .byte 0xFF,0xFF
.org 0x8009ABCE :: .byte 0x01
.org 0x801BCCEC :: OptionsMenuFiveSelection:
.org 0x801BCCF2 :: OptionsMenuSixSelection:
.org 0x801BCCF8 :: OptionsMenuSevenSelection:


; Add special "half pointer" that redirects string loads to payload
.org 0x8001A250
  j MenuTextSpecialPointers
  lhu v0,0x0004(a1)  ; original instruction
.org 0x8001A258 :: MenuTextSpecialPointersReturn:


; Extend Options Menu saving
.org 0x80031874
  j ExpandedOptionsMenuCheckIfChanged  ; adds persistent custom variable saving when changing settings
  lhu v0,0x308C(a0)
.org 0x8003187C :: ExpandedOptionsMenuNotChangedReturn:
.org 0x8003199C :: ExpandedOptionsMenuIsChangedReturn:

.org 0x80031A60
  j ExpandedOptionsMenuCopyToLowerRAM  ; adds persistent custom variable saving when changing settings
  lhu v0,0x308C(a0)
.org 0x80031A68 :: ExpandedOptionsMenuCopyToLowerRAMReturn:

.org 0x800316D4
  j ExpandedOptionsMenuLoadCustomVariables  ; adds proper loading of custom variables when opening options
  lui v0,hi(RandomStageSetting)

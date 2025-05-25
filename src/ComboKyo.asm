; Gundam Battle Assualt 2: ComboKyo Edition
; AKA GBA2TE
; created by Yuri Bacon, with much help from ComboKyo
; build using armips v11.0
.psx


; game's first instruction: 0x8008C764
; end of main exe: 0x800A6030
; unused RAM: 0x800D6580-0x800DF230 (0x8CB0)
; These were quick and dirty notes I made for MovePayload, and are too helpful to remove


; SLUS_014.18, anything that needs to be inserted into the main executable or payload goes here
; also contains any and all RAM addresses that need to be referenced by any code
.openfile "../build env/GBA2/SLUS_014.18","../build env/GBA2/GBA2_TED.EV",0x8000F800

  ; First, we need to start with any data that needs to be modified in SLUS_014.04 itself
  ; Most of this is just jumps into the payload, so you'll want to find the Payload half
  ; for each of these to make sense.
  .include "exe/InputFixExe.asm"
  .include "exe/60fpsExe.asm"
  .include "exe/RandomStageExe.asm"
  .include "exe/RandomMobileSuitExe.asm"
  .include "exe/EverythingUnlockedExe.asm"
  .include "exe/GamesharkCodesExe.asm"  ; + custom vars & some string stuff
  .include "exe/ExpandedOptionsMenuExe.asm"
  
  ; Invert Pilot Display logic
  ; This is just changing the original instruction from bne to beq
  .org 0x80040720
    beq v0,r0,0x80040744
  
  
  ; As most of the game's code uses fixed jump locations, the code can't be resized,
  ; anything that needs extra instructions has to be stored somewhere else, in unused RAM.
  ; It's stored in empty space at the end of the exe, and this code moves that "payload".
  .include "MovePayload.asm"
  
  ; and now, everything inside the payload!
  ; Please note that you can no longer use .org or else you'll fuck the payload up and nothing will build
  ; If you need to give a RAM address a label, put it somewhere before MovePayload.asm
  .include "payload/StringTablePayload.asm"
  .include "payload/InputFixPayload.asm"
  .include "payload/60fpsPayload.asm"
  .include "payload/RandomStagePayload.asm"
  .include "payload/RandomMobileSuitPayload.asm"
  .include "payload/EverythingUnlockedPayload.asm"
  .include "payload/GamesharkCodesPayload.asm"
  .include "payload/ExpandedOptionsMenuPayload.asm"
  
  ; The Payload in its entirety, including the code to move the payload into the needed place in RAM,
  ; can only be so long, because the BIOS will only load so much data from the main exe.
  ; Main exe max size is 0x97000, 0x800 of which is the exe header.
  ; We don't use the exe header because not all BIOS load it, nor load it into the same place.
  ; After accounting for the space used up by the exe itself, we have 0x7D0 bytes to work with.
  ; If we go over it, armips will throw an error telling me, so I don't have to find out
  ; when the hack go crashy crashy.
  .if orga() > 0x97000
    .error "Main EXE overflow! You've added too much extra data and the BIOS **WILL NOT** load it all into RAM! Expect crashy crashy!!!!!"
  .endif
.close

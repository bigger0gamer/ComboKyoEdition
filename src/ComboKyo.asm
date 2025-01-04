; Gundam Battle Assualt 2: ComboKyo Edition (Tournament Edition)
; created by Yuri Bacon
; Build using armips v11.0
.psx


; game's first instruction: 0x8008C764
; end of main exe: 0x800A6030
; unused RAM: 0x800D6580-0x800DF230 (0x8CB0)


; SLUS_014.18, anything that needs to be inserted into the main executable or payload goes here
; also contains any and all RAM addresses that need to be referenced by any code
.openfile "../build env/GBA2/SLUS_014.18",0x8000F800

  ; First, we need to start with any data that needs to be modified in SLUS_014.04 itself
  ; Input reader cut away
  .org 0x80014E48
    j InputFix
    nop
  .org 0x80014E50 :: InputFixReturn:
  .org 0x800EA9C5 :: Player2TrueInput:
  
  
  ; Offer Random Stage
  ; replace jump to "recall last stage" function with loading the universal frame counter
  ; and then anding it with 0x7 (the number of stages, and also a power of 2 (thank god))
  .org 0x80037A9C
  ;  lui at,hi(FrameCounter)
  ;  lw v0,lo(FrameCounter)(at)
    j ToggleRandomStage
    lui v0,hi(RandomStageSetting)
  .org 0x80037AA4 :: ToggleRandomStageReturn:
  ;  andi v0,v0,0x7
  .org 0x800A502C :: FrameCounter:
  .org 0x800DF81A :: RandomStageSetting:
  
  ; 60FPS Gameplay
  .org 0x8001FA68
  ;  addiu v0,r0,0x0001
    j ToggleFPS
    lui v0,hi(FPSSetting)
  .org 0x8001FA70 :: ToggleFPSReturn:
  .org 0x800DF818 :: FPSSetting:
  
  ; Force Pilot Display Off
  .org 0x80040718
    addiu v0,r0,1
  
  ; Force Hit Display On
  .org 0x800406F4
    add v0,r0,r0
  
  
  ; Unlock Everything
  .org 0x8001C23C
    j UnlockEverything
  .org 0x8001C244 :: UnlockEverythingReturn:
  
  
  ; Fix Survival Mode Crash
  .org 0x8001CFF0
    addi v0,r0,1
  
  
  ; "Gameshark Codes": Hidden Mech & Music Replacements
  .org 0x80084664
    j GamesharkCodes
    lui at,0x800a  ; original instruction
  .org 0x8008466C :: GamesharkCodesReturn:
  .org 0x801FDF96 :: Player1Handicap:
  .org 0x801FDFCE :: Player2Handicap:
  .org 0x801FE000 :: Player1HiddenMech:
  .org 0x801FE002 :: Player2HiddenMech:
  .org 0x800BE356 :: Player1JokerJust:
  .org 0x800BE3B4 :: Player2JokerJust:
  .org 0x801C7360 :: Player1SampleCountdown:
  .org 0x801C7348 :: Player1SamplePointer:
  .org 0x801ED402 :: Player1Sample:
  .org 0x801C7C98 :: Player2SampleCountdown:
  .org 0x801C7C80 :: Player2SamplePointer:
  .org 0x801ECDE4 :: Player2Sample:
  .org 0x801FDE8C :: MenuCanary:
  .org 0x800DF844 :: Player1CharacterID:
  .org 0x800DF85E :: Player2CharacterID:
  .org 0x800DF80A :: MusicID:
  
  
  ; As most of the game's code uses fixed jump locations, the code can't be resized,
  ; anything that needs extra instructions has to be stored somewhere else, in unused RAM.
  ; It's stored in empty space at the end of the exe, and this code moves that "payload".
  .include "CopyCodeExtension.asm"
  
  ; and now, everything inside the payload!
  .include "InputFix.asm"
  .include "EverythingUnlocked.asm"
  .include "GamesharkCodes.asm"
  .include "60fpsRandomStageToggles.asm"

.close

; "Gameshark Codes": Hidden Mech & Music Replacements (& now more!)
.org 0x80084664
  j GamesharkCodes
  lui at,0x800a  ; original instruction
.org 0x8008466C :: GamesharkCodesReturn:

; game variables
.org 0x801FDF96 :: Player1Handicap:
.org 0x801FDFCE :: Player2Handicap:
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
.org 0x800A502C :: FrameCounter:
.org 0x801C7548 :: Player1HandicapMechNamePointer:
.org 0x801C7E80 :: Player2HandicapMechNamePointer:

; custom variables
.org 0x801FE000 :: Player1HiddenMech:
.org 0x801FE002 :: Player2HiddenMech:
.org 0x801FE004 :: RandomStageSetting:
.org 0x801FE006 :: FPSSetting:
.org 0x801FE008 :: RandomMusicSetting:
.org 0x801FE00A :: StringsReplaced:
.org 0x801FE010 :: RandomMechRNGY:
.org 0x801FE012 :: RandomMechRNGX:
.org 0x801FE014 :: RandomMusicRNG:
;.org 0x801FE016 :: 

.org 0x801FE00C :: TempReturnAddress:  ; This will keep the contents of ra safe while I use jals.
.org 0x801FE018 :: t0TempAddress:
.org 0x801FE01C :: t1TempAddress:
.org 0x801FE020 :: t2TempAddress:
.org 0x801FE024 :: t3TempAddress:
.org 0x801FE028 :: t4TempAddress:
.org 0x801FE02C :: t5TempAddress:
.org 0x801FE030 :: t6TempAddress:
.org 0x801FE034 :: t7TempAddress:
.org 0x801FE038 :: a0TempAddress:

.org 0x801FE000 :: MenuTextSpecialPointersBaseAddress:

; original strings
.org 0x801EA9B4 :: Versus2P:
.org 0x801BB2F2 :: PilotDisplayOn:
.org 0x801BB2EE :: PilotDisplayText:
.org 0x801BB2FA :: PilotDisplayTextTwo:
.org 0x801BB320 :: HitDisplayText:
.org 0x801BB327 :: HitDisplayTextTwo:
.org 0x801EABB4 :: TheOTexture:

; string pointers
.org 0x801B9F44 :: GameOptionsFiveName:
.org 0x801B9F64 :: GameOptionsSixName:
.org 0x801B9F84 :: GameOptionsSevenName:
.org 0x801B9FA4 :: GameOptionsEightName:
.org 0x801B9F06 :: GameOptionsThreeSelections:
.org 0x801B9F26 :: GameOptionsFourSelections:

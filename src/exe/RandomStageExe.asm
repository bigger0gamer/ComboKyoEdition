.psx

; Offer Random Stage
; replace jump to "recall last stage" function with loading the universal frame counter
; and then anding it with 0x7 (the number of stages, and also a power of 2 (thank god))
.org 0x80037A9C
  j ToggleRandomStage
  lui v0,hi(RandomStageSetting)
.org 0x80037AA4 :: ToggleRandomStageReturn:

.psx

; 60FPS Gameplay
.org 0x8001FA68
  j ToggleFPS
  lui v0,hi(FPSSetting)
.org 0x8001FA70 :: ToggleFPSReturn:

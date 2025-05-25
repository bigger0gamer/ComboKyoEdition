.psx

; FPSSettings:
;  0 = 60 (frameskip value 1)
;  1 = 30 (frameskip value 2)

ToggleFPS:
  lh v0,lo(FPSSetting)(v0)  ; load framerate setting
  lui at,0x800A             ; original instruction
  j ToggleFPSReturn
  addi v0,v0,1              ; correct setting to actual frameskip value

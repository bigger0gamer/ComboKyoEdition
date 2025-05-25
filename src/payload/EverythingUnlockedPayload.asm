.psx

; DF2B0, 16 bytes, 2P/CPU VS stages available
;  - (0-1, 3-6, 8, A) are valid, others cause issues and crashes
; DF37C, 8 bytes, main menu modes available
; DF384, 8 bytes, street mode MS
; DF38C, 1 enables BGM & Voice Test
;  - This seems to be a whole 8 byte range, but only the first is used?
; DF394, 0x22 bytes, other modes MS
;  - (6, D, F, 10) are invalid, and cause issues or crashes

; s0 - 800DF240
; v0 - 1

UnlockEverything:
  ; Main Menu Modes Available
  sb v0,0x013F(s0)
  sb v0,0x0140(s0)
  sb v0,0x0141(s0)
  sb v0,0x0142(s0)
  
  ; Street Mode Mobile Suit Available
  sb v0,0x0149(s0)
  sb v0,0x014A(s0)
  sb v0,0x014B(s0)
  
  ; All Other Modes Mobile Suit Available
  ; TODO: Maybe comment this with the IDs of each MS being unlocked? Might be useful
  sb v0,0x0155(s0)
  sb v0,0x0156(s0)
  sb v0,0x0158(s0)
  sb v0,0x0159(s0)
  ;sb v0,0x015A(s0) Hidden Mech
  sb v0,0x015B(s0)
  sb v0,0x015D(s0)
  sb v0,0x015F(s0)
  sb v0,0x0160(s0)
  ;sb v0,0x0161(s0) Hidden Mech
  sb v0,0x0162(s0)
  ;sb v0,0x0163(s0) Hidden Mech
  ;sb v0,0x0164(s0) Hidden Mech
  sb v0,0x0165(s0)
  sb v0,0x0166(s0)
  sb v0,0x0167(s0)
  sb v0,0x016B(s0)
  sb v0,0x016F(s0)
  sb v0,0x0172(s0)
  sb v0,0x0173(s0)
  sb v0,0x0174(s0)
  sb v0,0x0175(s0)
  
  ; CPU/2P VS Stages Available
  sb v0,0x0075(s0)
  sb v0,0x007A(s0)
  
  ; Unlock BGM/Voice Test
  j UnlockEverythingReturn
  sb v0,0x014C(s0)

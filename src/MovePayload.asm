.psx

; Update first game instruction
.orga 0x10       :: .word MovePayload
.org  0x8008C764 :: MovePayloadReturn:

; Where the code will actually live at run time
.org 0x801FE0F0 :: PayloadDestination:


; Main function!
.org 0x800A6030 :: MovePayload:
  lui v0,hi(Payload)
  addiu v0,v0,lo(Payload)  ; v0 = start of payload
  addiu v1,v0,0x7D0        ; v1 = end of payload (fixed size based on maximum main exe size)
  li a0,PayloadDestination ; a0 = RAM location to move payload to
  
  @@StartOfLoop:
  lw a1,0x0000(v0)   ; load 4 bytes of payload into a1
  addiu v0,v0,0x4    ; increment v0 by word
  sw a1,0x0000(a0)   ; hey, a1 loaded just in time to save it!
  addiu a0,a0,0x4    ; a0 too
  sltu at,v0,v1      ; we there yet?
  bne at,r0,@@StartOfLoop  ; no? Ugh, we have to go back again
  nop
  j MovePayloadReturn  ; jump back to original code
  nop


Payload:
.headersize PayloadDestination-orga(Payload)
; This label is intentionally at the end of the file (right after the main func), so that
; payload always refers to file offset after where MovePayload exists in SLUS_014.04,
; so that ComboKyo.asm can start including other asm files right after as part of the payload.
; Then we update the header offset for where the rest of the code will exist in RAM at run time.

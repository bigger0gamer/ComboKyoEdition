.psx

; s1 destination
; s1     - XA Channel
; s1 + 4 - Starting Sector (need stride added, will bake it) (also needs 0x1844 offset added?)
; s1 + 8 - Sector Length

ExpandedMusic:
  ; validate music ID
  slti s0,a1,NumberSongs
  bne s0,r0,@@ValidTrack
  lui s0,hi(ExpandedMusicTable)
  
  lui a1,0
  
  @@ValidTrack:
  addi s0,s0,lo(ExpandedMusicTable)
  sll a1,a1,3   ; music ID * 8
  add s0,s0,a1  ; index into table
  lw v1,0(s0)   ; load starting sector
  lhu v0,4(s0)  ; load sector length
  sw v1,4(s1)   ; save starting sector
  sw v0,8(s1)   ; save sector length
  lhu v1,6(s0)  ; load XA channel
  j ExpandedMusicReturn
  sw v1,0(s1)   ; save XA channel

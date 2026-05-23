; I didn't make any comments while writing this, and now that I'm giving the source
; a second pass over before uploading to github...
; yeah sorry, I can't be assed to comment this.
; It does both Random and Community music edits though, despite the file name.
; Seems I weirdly named "Community" as Original while coding this??
.psx

lh v0,lo(RandomMusicSetting)(at)
addi t0,r0,-1
beq v0,r0,@@CharacterMusic
lui v1,hi(MusicID)
beq v0,t0,@@SkipMusicReplacement
lh v0,lo(RandomMusicRNG)(at)
j @@SaveMusicReplacement
addi v0,v0,1

@@CharacterMusic:
lui v0,hi(Player2CharacterID)
lh v0,lo(Player2CharacterID)(v0)
nop
addi v0,v0,0xB

@@SaveMusicReplacement:
sh v0,lo(MusicID)(v1)

@@SkipMusicReplacement:

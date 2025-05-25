; I didn't make any comments while writing this, and now that I'm giving the source
; a second pass over before uploading to github...
; yeah sorry, I can't be assed to comment this.
; It does both Random and Community music edits though, despite the file name.
; Seems I weirdly named "Community" as Original while coding this??
.psx

lh v0,lo(RandomMusicSetting)(at)
nop
beq v0,r0,@@Original
addi v0,v0,1
beq v0,r0,@@SkipAcguyTheme
lh v1,lo(RandomMusicRNG)(at)
lui v0,hi(MusicID)
j @@SkipAcguyTheme
sh v1,lo(MusicID)(v0)


@@Original:
lui v0,hi(Player1CharacterID)
lh v1,lo(Player1CharacterID)(v0)
addi s1,r0,0x12
beq v1,s1,@@BestTheme
lh v1,lo(Player2CharacterID)(v0)
nop
beq v1,s1,@@BestTheme
nop
j @@SkipBestTheme
nop

@@BestTheme:
addi s1,r0,2
lui v0,hi(MusicID)
sh s1,lo(MusicID)(v0)

@@SkipBestTheme:
lui v0,hi(Player1CharacterID)
lh v1,lo(Player1CharacterID)(v0)
addi s1,r0,0xE
beq v1,s1,@@AcguyTheme
lh v1,lo(Player2CharacterID)(v0)
nop
beq v1,s1,@@AcguyTheme
nop
j @@SkipAcguyTheme
nop

@@AcguyTheme:
addi s1,r0,8
lui v0,hi(MusicID)
sh s1,lo(MusicID)(v0)

@@SkipAcguyTheme:

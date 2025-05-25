.psx

; Random MS RNG
lh v1,lo(RandomMechRNGX)(at)  ; load RNG XY from RAM
lh v0,lo(RandomMechRNGY)(at)

addi v1,v1,1                  ; RNG X++
slti s1,v1,6
bne s1,r0,@@SkipRollover        ; if(RNG X >= 6)
nop
  lui v1,0                      ; RNG X = 0
  addi v0,v0,1                  ; RNG Y++
  slti s1,v0,5
  bne s1,r0,@@SkipRollover      ; if(RNG Y >= 5)
  nop
    lui v0,0                    ; RNG Y = 0

@@SkipRollover:
sh v1,lo(RandomMechRNGX)(at)  ; save RNG XY to RAM
sh v0,lo(RandomMechRNGY)(at)


; Random Music RNG
lh v0,lo(RandomMusicRNG)(at)  ; load musicRNG from RAM
nop

addi v0,v0,1                  ; musicRNG++
slti s1,v0,0xB                ; if(musicRNG > A)
bne s1,r0,@@SkipMusicReset
nop
addi v0,r0,1                  ; then musicRNG = 1

@@SkipMusicReset:
sh v0,lo(RandomMusicRNG)(at)  ; save musicRNG

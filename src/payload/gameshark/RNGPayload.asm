.psx

; It loads a word (4 bytes) from RAM address `0x800E0980`,
; multiplies that by the static number `0x41C64E6D` (keeping only the lower word of the result),
; then adds the static number `0x3039`,
; saves the final result back to RAM address `0x800E0980`,
; and finally returns to the calling code with the final result in register `a0`,
; as well that result shifted 16 bits left and the 16th bit stripped off in register `v0`.
; It is called simply by `jal 0x80077B04`, no arguments necessary.
; It only uses registers `at` (to save the result back to RAM),
; `v1` (contains `0x41C64E6D`), `v0`, and `a0`.


li t1,RandomMechRNGY
jal RNGWrapper
addi t0,r0,5
addi t1,t1,2
jal RNGWrapper
addi t0,r0,6
addi t1,t1,2
jal RNGWrapper
addi t0,r0,0xA + NumberSongs

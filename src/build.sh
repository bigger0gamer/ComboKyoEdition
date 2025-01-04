armips ComboKyo.asm
{
cd ../build\ env/
psxbuild -c GBA2.cat GBA2TE.bin
mednafen GBA2TE.cue
} &> /dev/null

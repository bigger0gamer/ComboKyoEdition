armips ComboKyo.asm
cd ../build\ env/
psxbuild -c GBA2.cat GBA2TE.bin &> /dev/null
cp cleanROM/Gundam\ Battle\ Assault\ 2\ \(USA\)\ \(Track\ 2\).bin GBA2TE\ \(Track\ 2\).bin
echo "FILE \"GBA2TE (Track 2).bin\" BINARY" >> GBA2TE.cue
echo "  TRACK 02 AUDIO" >> GBA2TE.cue
echo "    INDEX 00 00:00:00" >> GBA2TE.cue
echo "    INDEX 01 00:02:00" >> GBA2TE.cue
mednafen GBA2TE.cue &> /dev/null

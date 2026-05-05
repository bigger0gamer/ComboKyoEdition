# String to use for the game's Title ID
# This will automatically rename armips output file, edit SYSTEM.CNF & mkpsxiso .xml all to match
# So you can easily rename the Title ID by just changing this variable and rebuilding
# I recommend keeping something placeholder sounding while dev/testing, like TRUE_OGD.EV
TITLE_ID='GBA2_TED.EV'

# armips
sed s/TITLE_ID/$TITLE_ID/ ComboKyo.asm > temp.asm
armips temp.asm
rm temp.asm

# edit SYSTEM.CNF + .xml && mkpsxiso
cd ../build\ env
cp "GBA2/SYSTEM.CNF" "GBA2/SYSTEM.bak"
sed -i s/SLUS_014.18/$TITLE_ID/ "GBA2/SYSTEM.CNF"
cp "GBA2.xml" "GBA2.bak"
sed -i s/SLUS_014.18/$TITLE_ID/ "GBA2.xml"
sed -i s/SLUS_014.18/$TITLE_ID/ "GBA2.xml"
mkpsxiso -y -q -o temp.bin -c temp.cue -l $TITLE_ID "GBA2.xml"

# split bin
rm GBA2TE.cue "GBA2TE (Track 1).bin" "GBA2TE (Track 2).bin"
binmerge -s temp.cue GBA2TE
rm temp.bin temp.cue

# restore clean SYSTEM.CNF + .xml
mv "GBA2/SYSTEM.bak" "GBA2/SYSTEM.CNF"
mv "GBA2.bak" "GBA2.xml"

# open output in emulator
mednafen GBA2TE.cue &> /dev/null

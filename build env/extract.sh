binmerge Gundam\ Battle\ Assault\ 2\ \(USA\).cue GBA2
dumpsxiso GBA2.bin
rm GBA2.cue GBA2.bin
mkdir cleanROM
mv Gundam\ Battle\ Assault\ 2\ \(USA\).cue cleanROM
mv Gundam\ Battle\ Assault\ 2\ \(USA\)\ \(Track\ 1\).bin cleanROM
mv Gundam\ Battle\ Assault\ 2\ \(USA\)\ \(Track\ 2\).bin cleanROM

cd GBA2/XA
xa-deinterleaver CDXA00.XA
mkdir /GBA2/XA/CDXA00/ext/

cd songs

rm ../../build\ env/GBA2/XA/CDXA00/ext/*
find -wholename "*.xa" -exec cp {} ../../build\ env/GBA2/XA/CDXA00/ext/ \;\

rm ../../build\ env/GBA2/XA/CDXA00/CDXA00_ALL.csv
cat ../../build\ env/GBA2/XA/CDXA00/CDXA00.csv >> ../../build\ env/GBA2/XA/CDXA00/CDXA00_ALL.csv
cat CDXA00_EXT.csv >> ../../build\ env/GBA2/XA/CDXA00/CDXA00_ALL.csv

cd ../../build\ env/GBA2/XA/
xa-interleaver CDXA00/CDXA00_ALL.csv
xa-sector-table CDXA00_ALL_NEW.XA ../../../src/payload/musicTablePayload.bin 6212 10
mv CDXA00_ALL_NEW.XA CDXA00.XA

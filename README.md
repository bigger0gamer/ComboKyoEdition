# ComboKyo Edition
This is a ROM hack of Gundam Battle Assault 2 (USA) with the following features:

- 60FPS Gameplay
- "Hidden Mechs" in 2P VS
- Player 2 Input Lag Fix
- Random Stage Suggestion
- Random Mobile Suit (Select Button)
- Everything Unlocked (No Save File Needed)
- Random Music (Optional, Not Default)
- Expanded Game Options Menu!
- Pilot Display Off By Default
- The game ID has been changed to `GBA2_TEX.XX` in releases, with X.XX being replaced with a given version (Ex: `1.04` represents Version 1 Release Canidate 4).
  - If built from source, the game ID will remain as `SLUS_014.18` unless you change it manually.

You can find a patch for this ROM hack under the [releases section](https://github.com/bigger0gamer/ComboKyoEdition/releases), building is not necessary unless you'd like to make further modifications to the game. 60FPS gameplay is best enjoyed in duckstation with a 180% CPU overclock applied.

## Dependencies

If you'd like to build this ROM hack from source, you'll need the following dependencies:

- [armips](https://github.com/Kingcom/armips) v0.11 or newer
- [psximager](https://github.com/cebix/psximager) v2.2 or newer
- [binmerge](https://github.com/putnam/binmerge), only needed for initial setup of the build environment because psxrip is stinky doo doo that relies on sloppy assumptions.
- A copy of Gundam Battle Assault 2 matching the below MD5 hashs for each track. A mismatch on the second track shouldn't prevent a successful build, but it's listed here for completeness anyways.
  - Track 1 `.bin`: `3000a1b7ff191c1efe1aaf18f79a0ed5`
  - Track 2 `.bin`: `2d7b5e8e94a91bf5423b2356f6a34863`
  - [Hashes obtained from Redump.org](http://redump.org/disc/6795/)
- If you want to expand on this ROM hack, you'll want a PS1 emulator with debugger of your choice. I personally use [mednafen](https://mednafen.github.io/), but feel free to use PCSX-R or duckstation or whatever else is more comfortable for you, but being able to launch a ROM on it from command line will be desired.
- A text editor, probably.

Listed are just versions used to build the release patch. Using older versions is likely feasible but untested. Using something other than psximager is also likely possible, but that also isn't my problem.

## Building

### Setting up the build environment

This guide assumes you are running some flavor of linux, and that you already have the dependencies installed. Alter these commands for your OS as necessary.

Copy a bin/bin/cue of GBA2 into the `build env` directory named `Gundam Battle Assualt 2 (USA) (Track 1).bin`, `Gundam Battle Assualt 2 (USA) (Track 2).bin` and `Gundam Battle Assualt 2 (USA).cue`. Then simply run `extract.sh`. This will automatically binmerge your copy of the game, extract all of the game data to a folder named `GBA2`, and copy your original ROM into a folder named `cleanROM`. You will need the Track 2 bin file for building, so don't remove it.

### Changing the Title ID (Optional)

If you'd like to change the game's Title ID, you should do so now. This was done in the release patch for two reasons: To make the game stand out on duckstation's game list from the vanilla game, and to met Arkadyzja's unique title ID requirement for having a ROM hack added to it's supported game list.

If neither of this matters to you, you may skip this step, but I recommend making a backup copy of `SLUS_014.18`, as armips will directly edit this file otherwise, and any change made will be irreverable without re-extracting it from the original bin/cue again (annoying).

In the `/src/ComboKyo.asm` source file, find the following line:

```
.openfile "../build env/GBA2/SLUS_014.18",0x8000F800
```

and alter it to show the following:

```
.openfile "../build env/GBA2/SLUS_014.18","../build env/GBA2/XXXX_XXX.XX",0x8000F800
```

where `XXXX_XXX.XX` is any title ID of your choosing. As far as I'm aware, it doesn't strictly have to follow that naming convention, and you could use `MAIN.EXE` or `JOEMAMA`, but I leave that decision up to you. If you are continueing this project after I've dropped it off, I used `GBA2_TEX.XX` to represent "Gundam Battle Assault 2 Tournament Edition vX.XX", so you can keep that title ID and just update the version number accordingly.

That only informs armips to copy the original main exe to a new file and edit that. Now we'll need to edit `/build env/GBA2/SYSTEM.CNF` to inform the PS1 of the correct file to boot the game with. Open SYSTEM.CNF in a text editor, and edit this line to match your new title ID.

```
BOOT = cdrom:\SLUS_014.18;1
```

And finally, we need to tell psximager to include our new exe file, not the original. Find the following line in `/build env/GBA2.cat` and edit it to match the new title ID.

```
  file SLUS_014.18
```

### Compiling

All that's left to do is `cd` your way to `/src` and run the `build.sh` script provided. It should contain the following:

```
armips ComboKyo.asm
cd ../build\ env/
psxbuild -c GBA2.cat GBA2TE.bin &> /dev/null
cp cleanROM/Gundam\ Battle\ Assault\ 2\ \(USA\)\ \(Track\ 2\).bin GBA2TE\ \(Track\ 2\).bin
echo "FILE \"GBA2TE (Track 2).bin\" BINARY" >> GBA2TE.cue
echo "  TRACK 02 AUDIO" >> GBA2TE.cue
echo "    INDEX 00 00:00:00" >> GBA2TE.cue
echo "    INDEX 01 00:02:00" >> GBA2TE.cue
mednafen GBA2TE.cue &> /dev/null
```

`armips ComboKyo.asm` builds all of the code into the game data, and `psxbuild -c GBA2.cat GBA2TE.bin` builds that back into a new bin/bin/cue named `GBA2TE.bin`/`GBA2TE (Track2).bin`/`GBA2TE.cue` for use in an emulator or disc burning software. Feel free to replace `mednafen GBA2TE.cue` with the command for your preferred emulator. You can change the new file name if you'd like, but if you do not specify a new file name, psximager will overwrite the original image. Keeping a backup of the original image somewhere else is advised, just in case. I also choose to encasulate all the commands after armips into a pipe to null because during development, I didn't care for those commands making a verbose mess out of my terminal output so I could focus on errors from armips, but they are not necessary.

## Credits

ComboKyo - for having completed 90% of the reverse engineering necessary for this project before I started this project including stuff like 60FPS gameplay, unlock everything, and for having made the "Hidden Mechs Selectable in 2P VS" Gameshark cheat code. Hell, it's his insight and researching prowess that lead to the breakthough necessary to get the ball rolling on a proper V1 release, unlike the sad "functionally complete but unpolished" release that was v0.03, to say nothing about the further contributions to the latest version. This project wouldn't be possible without him, and primarily features his work on gameshark cheats, and so I've named this hack after him.

Kingcom - for making armips. Holy *fuck* is this such a great and powerful tool for PS1 ROM hacking. It is far and away better than what I was doing before when making DRA True OG Edition, and I never could have made such a good tool on my own. Thank you.

The developer of mednafen - for making by far my favorite emulator by miles, especially for PS1. Thank you, anonymous coward.

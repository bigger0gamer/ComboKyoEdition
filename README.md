# ComboKyo Edition
This is a ROM hack of Gundam Battle Assault 2 (USA) with the following features:

- 60FPS gameplay enabled by default. You can return to 30FPS gameplay by going into the options and setting "Pilot Display" to "Off".
  - Pilot Display is now forced off, regardless of what the options menu says.
- Hidden mechs are selectable in 2P VS, in the same fashion as you do for ComboKyo's hidden mech gameshark cheats. They should only be available in 2P VS to my knowledge.
  - When you pick any mobile suit and are at the handicap screen, press one of the following buttons to pick the given mobile suit. A voice line matching the suit name should play.
   - L1: The O
   - L2: Zed Gundam
   - R1: Qubeley
   - R2: Hamma Hamma
- Player 2 input lag fix
  - Player 2 normally has an extra frame of input lag that Player 1 doesn't have when the game is running at 60PFS. In the vanilla game, this usually isn't that important as this only occurs in menus, but becomes pretty important when gameplay is being played at 60FPS too.
- Random stage suggestion at stage select. Like 60FPS, this can be disabled in the options menu by setting "Hit Display" to "Off".
  - Hit Display is now forced on, regardless of what the options menu says.
- Everything unlocked by deafult (main menu modes, MS in Street, MS in other modes, stages, sound test). If you find anything that isn't unlocked, or the game crashes in any single player modes, let me know and I'll investigate.
- "Best Theme" will play if either play is Ball, or the unused "Acguy Theme" will play when either player is Acguy (Acguy theme takes priority over Best theme).
- The game ID has been changed to `GBA2_TEX.XX` in releases, with X.XX being replaced with a given version (Ex: `0.03` represents 0.03beta).
  - If built from source, the game ID will remain as `SLUS_014.18` unless you change it manually.

Only thing not implemented is texture edits of any kind. Whenever the hell I can figure out how to get texture data into and out of the games archive format, I plan to edit:
- Pilot Display and Hit Display to 60FPS and Random Stage respectively, to match their new functionality.
- A cheat sheet for hidden mechs in the 2P VS menu (probably replacing "Versus 2P in the corner).
- Another texture somewhere saying "ComboKyo Edition", to denote the use of this ROM hack.

You can find a patch for this ROM hack under the releases section, building is not necessary unless you'd like to make further modifications to the game. 60FPS gameplay is best enjoyed in duckstation with a 180% CPU overclock applied.

## Dependencies

If you'd like to build this ROM hack from source, you'll need the following dependencies:

- [armips](https://github.com/Kingcom/armips) v0.11 or newer
- [psximager](https://github.com/cebix/psximager) v2.2 or newer
- A copy of Gundam Battle Assault 2 matching the below MD5 hashs for each track, and merged into a single bin file. If your copy has a bin file for each track, then you'll need to merge them with [binmerge](https://github.com/putnam/binmerge). A mismatch on the second track shouldn't prevent a successful build, but it's listed here for completeness anyways.
  - Track 1 `.bin`: `3000a1b7ff191c1efe1aaf18f79a0ed5`
  - Track 2 `.bin`: `2d7b5e8e94a91bf5423b2356f6a34863`
  - [Hashes obtained from Redump.org](http://redump.org/disc/6795/)
- If you want to expand on this ROM hack, you'll want a PS1 emulator with debugger of your choice. I personally use [mednafen](https://mednafen.github.io/), but feel free to use PCSX-R or duckstation or whatever else is more comfortable for you, but being able to launch a ROM on it from command line will be desired.
- A text editor, probably.

Listed are just versions used to build the release patch. Using older versions is likely feasible but untested. Using something other than psximager is also likely possible, but that also isn't my problem.

## Building

### Setting up the build environment

This guide assumes you are running some flavor of linux, and that you already have the dependencies installed. Alter these commands for your OS as necessary.

Copy a bin/cue of GBA2 into the `build env` directory named `GBA2.bin` and `GBA2.cue` (please make sure the cue correctly lists `GBA2.bin` in a text editor). Then open a terminal in the `build env` directory and run the following command:

```
psxrip GBA2.cue
```

When done, this should create a new directory, `GBA2`, containing all the data on the disc. Your directory tree should look like this when done.

```
/src
-*Source files and shit*
/build env
-GBA2.bin
-GBA2.cat
-GBA2.cue
-GBA2.sys
-/GBA2
--SLUS_014.28
--SYSTEM.CNF
--/DATA
---*game data*
--/XA
---*game data*
```

### Changing the Title ID (Optional)

If you'd like to change the game' Title ID, you should do so now. This was done in the release patch for two reasons: To make the game stand out on duckstation's game list from the vanilla game, and to met Arkadyzja's requirements for having a ROM hack added to it's supported game list.

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
{
cd ../build\ env/
psxbuild -c GBA2.cat GBA2TE.bin
mednafen GBA2TE.cue
} &> /dev/null
```

`armips ComboKyo.asm` builds all of the code into the game data, and `psxbuild -c GBA2.cat GBA2TE.bin` builds that back into a new bin/cue named `GBA2.bin`/`GBA2.cue` for use in an emulator or disc burning software. Feel free to replace `mednafen GBA2TE.cue` with the command for your preferred emulator. You can change the new file name if you'd like, but if you do not specify a new file name, psximager will overwrite the original image. Keeping a backup of the original image somewhere else is advised, just in case. I also choose to encasulate all the commands after armips into a pipe to null because during development, I didn't care for those commands making a verbose mess out of my terminal output so I could focus on errors from armips, but they are not necessary.

## Pre-github releases

I didn't bother uploading source code to github until I liked the state this hack was in (but I really wish I didn't get stumped at the last inch, man I suck at dealing with compressed archives), and thus I released a couple beta versions before this github repo. For completeness sake, here is a hash of these versions to help identify which old version you have.

0.01beta: `GBA2TE_0.01` `SHA-1: FDDC4E31C3DA2AC68CE48AC63321B8470A94F923`
0.02beta: `GBA2TE_0.01` `SHA-1: C8A928D0C20460AE721EE5772CCC882C4534A49B`

## Credits

ComboKyo - for having completed 90% of the reverse engineering necessary for this project before I started this project including stuff like 60FPS gameplay, unlock everything, and for having made the "Hidden Mechs Selectable in 2P VS" Gameshark cheat code. This project wouldn't be possible without him, and primarily features his work on gameshark cheats, and so I've named this hack after him.

Kingcom - for making armips. Holy *fuck* is this such a great and powerful tool for PS1 ROM hacking. It is far and away better than what I was doing before when making DRA True OG Edition, and I never could have made such a good tool on my own. Thank you.

The developer of mednafen - for making by far my favorite emulator by miles, especially for PS1. Thank you, anonymous coward.

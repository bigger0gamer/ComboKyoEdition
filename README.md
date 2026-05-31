# ComboKyo Edition
This is a ROM hack of Gundam Battle Assault 2 (USA) with the following features:

- 60FPS Gameplay
- "Hidden Mechs" in 2P VS
- Player 2 Input Lag Fix
- Random Stage Suggestion
- Random Mobile Suit (Select Button)
- Everything Unlocked (No Save File Needed)
- Custom Music
- Expanded Game Options Menu!
- Pilot Display Off By Default
- The game ID has been changed to `GBA2_TEX.XX` in releases, with X.XX being replaced with a given version (Ex: `1.04` represents Version 1 Release Canidate 4).

You can find a patch for this ROM hack under the [releases section](https://github.com/bigger0gamer/ComboKyoEdition/releases), building is not necessary unless you'd like to make further modifications to the game. 60FPS gameplay is best enjoyed in duckstation with a 180% CPU overclock applied.

## Dependencies

If you'd like to build this ROM hack from source, you'll need the following dependencies:

- [armips](https://github.com/Kingcom/armips) v0.11 or newer
- [mkpsxiso](https://github.com/Lameguy64/mkpsxiso) v2.10 or newer
- [binmerge](https://github.com/putnam/binmerge)
- A copy of Gundam Battle Assault 2 matching the below MD5 hashs for each track. A mismatch on the second track shouldn't prevent a successful build, but it's listed here for completeness anyways.
  - Track 1 `.bin`: `3000a1b7ff191c1efe1aaf18f79a0ed5`
  - Track 2 `.bin`: `2d7b5e8e94a91bf5423b2356f6a34863`
  - [Hashes obtained from Redump.org](http://redump.org/disc/6795/)
- [`xa-interleaver`](https://github.com/N4gtan/xa-interleaver) and `xa-deinterleaver` v1.12 or newer
- [`xa-sector-table`](https://github.com/bigger0gamer/xa-interleaver)
  - You'll have to build this yourself, as it's a tool I cobbled together just for this ROM hack.
  - This repo also contains `xa-interleaver` and `xa-deinterleaver`, so you could technically get everything from here but I don't recommend that as I don't intend to mantain it. Nagtan's repository will likely be more up to date, and also has prebuilt releases for convenience.
- If you want to expand on this ROM hack, you'll want a PS1 emulator with debugger of your choice. I personally use [mednafen](https://mednafen.github.io/), but feel free to use PCSX-R or duckstation or whatever else is more comfortable for you, but being able to launch a ROM on it from command line will be desired.
- A text editor, probably.

Listed are just versions used to build the release patch. Using older versions is likely feasible but untested. Using something other than psximager is also likely possible, but that also isn't my problem.

## Building

### Setting up the build environment

This guide assumes you are running some flavor of linux, and that you already have the dependencies installed. Alter these commands for your OS as necessary.

Copy a bin/bin/cue of GBA2 into the `build env` directory named `Gundam Battle Assualt 2 (USA) (Track 1).bin`, `Gundam Battle Assualt 2 (USA) (Track 2).bin` and `Gundam Battle Assualt 2 (USA).cue`. Then simply run `extract.sh`. This will automatically binmerge your copy of the game, extract all of the game data to a folder named `GBA2`, and copy your original ROM into a folder named `cleanROM`. You will need the Track 2 bin file for building, so don't remove it.

### Changing the Title ID

The build script for this hack assumes you'll change the game's Title ID, since outputting to a different file name that doesn't overwrite original files is just convienent (and also needed to have a ROM hack added to Arkadyzja). By default, this is `GBA2_TED.EV`, but for releases you should change this inside of `src/build.sh`.

### Adding Custom Music

As of version v1.1 (currently unreleased), ComboKyo Edition can now add new music to the game, providing an option to listen to only the original music, pick between new and original tracks based on player 2's character, or pick between new and original tracks at random. To make the "music track based on player 2's character" part of the feature easy, I decided to include each characters assigned track in order of their character ID, which means this feature requires a small amount of manual work. Details on that can be found in `src/songs/assembly_required.txt`.

The basic overview is that `extract.sh` will deinterleave `XA/CDXA00.XA` in the game's files, `pack_xa.sh` is a small script to copy any uninterleaved `.xa` files in `src/songs` into the build environment and interleave them together with the original tracks, and then you simply run `build.sh` to complete the process. Importantly though, you'll have to manually specify in `src/songs/CDXA00_EXT.csv` each `.xa` file you'll include in it's intended order and give it a proper XA channel (0-7, 7-0, repeat but you start at 5 going down) for the interleaving to go smoothly. 

As a consequence of how custom music was implemented in the hack code, a `.bin` file with a table of each track's starting sector, length in sectors, and XA channel is needed for everything to work correctly. This is too obnoxious to do manually, so this is what I made `xa-sector-table` to do. Basically, `xa-deinterleaver` already has all the code to find each track's starting sector, end sector, and XA channel among other things, so instead of re-inventing the wheel I just made a slight modification of it that skips the part where is saves the deinterleaved tracks and manifest file, and writes a binary file with this needed data instead. The main limitation to this approach is the assumption that you'll only assign each character a new track, and not any of the original tracks, but you can work around this by adding a really short silent track in it's place, then manually hex editing that character's track entry in the music sector table in a hex editor to point to the original song without having to throw everything out and rebuild it by hand. Big thanks to Nagtan for having already coded the hard part and using the MIT license.

I didn't explicitly list [`psxavenc`](https://github.com/WonderfulToolchain/psxavenc) as a dependency, since I choose not to automate converting audio files to XA format, but you'll probably want it.

### Compiling

All that's left to do is `cd` your way to `/src` and run the `build.sh` script provided. It should look something like this:

```
armips ComboKyo.asm
cd ../build\ env/
mkpsxiso -y -q -o temp.bin -c temp.cue -l $TITLE_ID "GBA2.xml"
mednafen GBA2TE.cue &> /dev/null
```

`armips ComboKyo.asm` builds all of the code into the game data, and `mkpsxiso -y -q -o temp.bin -c temp.cue -l $TITLE_ID "GBA2.xml"` builds that back into a new bin/bin/cue named `GBA2TE.bin`/`GBA2TE (Track2).bin`/`GBA2TE.cue` for use in an emulator or disc burning software. Feel free to replace `mednafen GBA2TE.cue` with the command for your preferred emulator.

## Credits

ComboKyo - for having completed 90% of the reverse engineering necessary for this project before I started this project including stuff like 60FPS gameplay, unlock everything, and for having made the "Hidden Mechs Selectable in 2P VS" Gameshark cheat code. Hell, it's his insight and researching prowess that lead to the breakthough necessary to get the ball rolling on a proper V1 release, unlike the sad "functionally complete but unpolished" release that was v0.03, to say nothing about the further contributions to the latest version. This project wouldn't be possible without him, and primarily features his work on gameshark cheats, and so I've named this hack after him.

Kingcom - for making armips. Holy *fuck* is this such a great and powerful tool for PS1 ROM hacking. It is far and away better than what I was doing before when making DRA True OG Edition, and I never could have made such a good tool on my own. Thank you.

The developer of mednafen - for making by far my favorite emulator by miles, especially for PS1. Thank you, anonymous coward.

# curse-nula
A NuLA version of Pharoah's Curse for the BBC Micro

![Screenshot](screenshot.png)

# Tools required

To build and apply the patch you'll need these tools:

* [beebasm](https://github.com/stardot/beebasm)
* [png2bbc](https://github.com/dave-f/png2bbc)
* [snap](https://github.com/dave-f/snap)

The graphics were extracted from the original binary using a small Go program, but this is not required to build the game, and was just used in the early stages of development.  I also used my own [bbc-disgo](https://github.com/dave-f/bbc-disgo) to disassemble the game, but again, this is not required unless you want to go any further with it.

# Building

Edit the `makefile` to point at the tools detailed above and running `make` should build `curse-nula.ssd` which can then be loaded into a BBC Micro emulator, preferably one that supports the VideoNuLA, eg [b2](https://github.com/tom-seddon/b2)

# Thanks

Chris Hogg - Art  
Tom Seddon - b2 Emulator and NuLA detection code  
Rob Coleman - NuLA hardware

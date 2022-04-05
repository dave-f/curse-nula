# curse-nula
A NuLA version of Pharoah's Curse for the BBC Micro

# Tools required

To build and apply the patch you'll need these tools:

* [beebasm](https://github.com/stardot/beebasm)
* [png2bbc](https://github.com/dave-f/png2bbc)
* [snap](https://github.com/dave-f/snap)

# Building

Edit the `makefile` to point at the tools detailed above and running `make` should build `curse-nula.ssd` which can then be loaded into a BBC Micro emulator, preferably one that supports the VideoNuLA, eg [b2](https://github.com/tom-seddon/b2)

# Thanks

Chris Hogg - Art  
Tom Seddon - b2 Emulator and NuLA detection code  
Rob Coleman - NuLA hardware

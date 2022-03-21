# Makefile for BBC Micro Pharoah's Curse NuLA Version
# 28 February 2022
#

BEEBEM       := C:/Dave/b2/b2_Debug
PNG2BBC      := ../png2bbc/x64/Release/png2bbc.exe
SNAP         := ../snap/Release/snap.exe
BEEBEM_FLAGS := -b -0
BEEBASM      := ../beebasm/beebasm.exe
BLANK_SSD    := res/blank.ssd
OUTPUT_SSD   := curse-nula.ssd
MAIN_ASM     := main.asm
RM           := del
CP           := copy

#
# Generated graphics
GFX_OBJECTS := $(shell $(PNG2BBC) -l gfxscript)

#
# Phony targets
.PHONY: all clean run gfx

all: $(OUTPUT_SSD)

$(OUTPUT_SSD): $(MAIN_ASM) Makefile loader.bas
	$(SNAP) res/curse.bin snake.patch 7591 bin/curse.new
	$(SNAP) bin/curse.new bin/player.bin 7911
#	$(SNAP) bin/curse.new level.patch 1467
#	$(SNAP) bin/curse.new pharaoh.patch 9311
#	$(SNAP) bin/curse.new pharaoh.patch 9357
#	$(SNAP) bin/curse.new pharaoh.patch 9403
#	$(SNAP) bin/curse.new pharaoh.patch 9449
	$(BEEBASM) -i $(MAIN_ASM) -di $(BLANK_SSD) -do $(OUTPUT_SSD)

gfx:
	$(PNG2BBC) gfxscript

$(GFX_OBJECTS): gfxscript
	$(PNG2BBC) gfxscript

clean:
	$(RM) $(OUTPUT_SSD)
	$(RM) /Q bin\*.*

run:
	$(BEEBEM) $(BEEBEM_FLAGS) $(OUTPUT_SSD)

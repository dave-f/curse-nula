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

#
# Make sure the bin directory exists
ifeq ("$(OS)","Windows_NT")
$(shell if not exist bin mkdir bin)
else
$(shell mkdir -p bin)
endif

#
# Generated graphics
GFX_OBJECTS := $(shell $(PNG2BBC) -l gfxscript)

#
# Input graphic file(s)
SRC_GRAPHIC := $(shell $(PNG2BBC) -i gfxscript)

#
# Phony targets
.PHONY: all clean run

all: $(OUTPUT_SSD)

$(OUTPUT_SSD): $(MAIN_ASM) Makefile loader.bas $(GFX_OBJECTS)
	$(SNAP) res/curse.bin bin/player.bin 7911 bin/curse.new
	$(SNAP) bin/curse.new bin/brick.bin 6391
	$(SNAP) bin/curse.new bin/dazed.bin 6471
	$(SNAP) bin/curse.new bin/ring.bin 6631
	$(SNAP) bin/curse.new bin/goblet.bin 6711
	$(SNAP) bin/curse.new bin/passage.bin 6791
	$(SNAP) bin/curse.new bin/door.bin 6951
	$(SNAP) bin/curse.new bin/key.bin 7431
	$(SNAP) bin/curse.new bin/lock.bin 7511
	$(SNAP) bin/curse.new bin/enemy.bin 7591
	$(SNAP) bin/curse.new bin/torch.bin 8551
	$(SNAP) bin/curse.new bin/dynamite.bin 8791
	$(SNAP) bin/curse.new bin/skull.bin 8871
	$(SNAP) bin/curse.new bin/egg.bin 8951
	$(SNAP) bin/curse.new bin/pharaoh.bin 9311
#   $(SNAP) bin/curse.new level.patch 1467
	$(BEEBASM) -i $(MAIN_ASM) -di $(BLANK_SSD) -do $(OUTPUT_SSD)

$(GFX_OBJECTS): gfxscript $(SRC_GRAPHIC)
	$(PNG2BBC) gfxscript

clean:
	$(RM) $(OUTPUT_SSD)
ifeq ("$(OS)","Windows_NT")
	$(RM) /Q bin\*.*
else
	$(RM) -rf bin/
endif

run:
	$(BEEBEM) $(BEEBEM_FLAGS) $(OUTPUT_SSD)

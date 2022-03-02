# Makefile for BBC Micro Pharoah's Curse NuLA Version
# 28 February 2022
#

BEEBEM       := C:/Dave/b2/b2_Debug
#BEEBEM       := C:/Dave/beebjit_win_0.9.6/beebjit
PNG2BBC      := ../png2bbc/Release/png2bbc.exe
SNAP         := ../snap/Release/snap.exe
BEEBEM_FLAGS := -b -0
#BEEBEM_FLAGS := -0 $(OUTPUT_SSD)
BEEBASM      := ../beebasm/beebasm.exe
#GAME_SSD     := res/blank.ssd
OUTPUT_SSD   := curse-nula.ssd
MAIN_ASM     := main.asm
RM           := del
CP           := copy

#
# Phony targets
.PHONY: all clean run gfx

all: $(OUTPUT_SSD)

$(OUTPUT_SSD): $(MAIN_ASM) Makefile
	$(SNAP) curse.bin snake.patch 7591 curse.new
#	$(SNAP) curse.new level.patch 1467
#	$(SNAP) curse.new pharaoh.patch 9311
#	$(SNAP) curse.new pharaoh.patch 9357
#	$(SNAP) curse.new pharaoh.patch 9403
#	$(SNAP) curse.new pharaoh.patch 9449
	$(BEEBASM) -i $(MAIN_ASM) -do $(OUTPUT_SSD) -boot CURSE

clean:
	$(RM) $(OUTPUT_SSD)
	$(RM) /Q bin\*.*

run:
	cd c:/Dave/beebjit_win_0.9.6
	$(BEEBEM) $(BEEBEM_FLAGS) $(OUTPUT_SSD)

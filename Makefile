# Makefile for BBC Micro Pharoah's Curse NuLA Version
# 28 February 2022
#

BEEBEM       := C:/Dave/b2/b2_Debug
PNG2BBC      := ../png2bbc/Release/png2bbc.exe
SNAP         := ../snap/Release/snap.exe
BEEBEM_FLAGS := -b -0
BEEBASM      := ../beebasm/beebasm.exe
GAME_SSD     := res/blank.ssd
OUTPUT_SSD   := curse-nula.ssd
MAIN_ASM     := main.asm
RM           := del
CP           := copy

#
# Phony targets
.PHONY: all clean run gfx

all: $(OUTPUT_SSD)

$(OUTPUT_SSD): $(MAIN_ASM) curse.bin curse.new
	$(BEEBASM) -i $(MAIN_ASM) -do $(OUTPUT_SSD) -boot CURSE

clean:
	$(RM) $(OUTPUT_SSD)
	$(RM) /Q bin\*.*

run:
	$(BEEBEM) $(BEEBEM_FLAGS) $(OUTPUT_SSD)

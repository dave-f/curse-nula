; Pharoah's Curse  : NuLA version
; 22 Feb -- 08 April 2022

ORG &900
GUARD &A00

.START:
    LDA &70
    BNE NULA
    LDX #LO(LOADER_NORMAL)
    LDY #HI(LOADER_NORMAL)
    JSR &FFF7
    JMP START_GAME

.NULA:
    LDX #LO(LOADER_NULA)
    LDY #HI(LOADER_NULA)
    JSR &FFF7
    LDA #12
    JSR &FFEE
    LDX #0

.PROGRAM_PAL:
    LDA PAL,X
    STA &FE23
    INX
    CPX #32
    BNE PROGRAM_PAL

.PATCHITEM1:
    LDX #0

.PATCHLOOP1:
    LDA MUMMY_TEXT,X
    BEQ PATCHITEM2
    STA &2E17,X
    INX
    JMP PATCHLOOP1

.PATCHITEM2:
    LDX #0

.PATCHLOOP2:
    LDA SCARAB_TEXT,X
    BEQ PATCHITEM3
    STA &2E25,X
    INX
    JMP PATCHLOOP2

.PATCHITEM3:
    LDX #0

.PATCHLOOP3:
    LDA EYE_TEXT,X
    BEQ TEXT_DONE
    STA &2E33,X
    INX
    JMP PATCHLOOP3

.TEXT_DONE:

    ; On the initial score screen, make colour 15 map to colour 15
    LDA #&0F
    STA &2D98

    ; Do not set up the normal palette when entering game
    LDA #&EA
    STA &1C42
    STA &1C43
    STA &1C44

    ; Do not do anything with colour 11
    LDA #&EA
    STA &1D76
    STA &1D77
    STA &1D78

    ; Set up enemy colour table to 15,15,2,1
    LDA #&0F
    STA &3FAC
    STA &3FAD
    LDA #&02
    STA &3FAE
    LDA #&01
    STA &3FAF

.START_GAME:

    ; Start game with number of enemies selected
    LDA &71
    STA &1F45
    JMP &1900

.PAL:
    INCBIN "bin/game.pal"

.LOADER_NULA:
    EQUS "LOAD CURSE",13

.LOADER_NORMAL:
    EQUS "LOAD ORG",13

.MUMMY_TEXT:
    EQUS "MUMMY",0

.SCARAB_TEXT:
    EQUS "SCARAB",0

.EYE_TEXT:
    EQUS "EYE   ",0

.END:
    PUTFILE "bin/curse.new","Curse",&1900,&1900
    PUTFILE "res/curse.bin","Org",&1900,&1900
    PUTFILE "bin/title.bin","Title",&3000,&3000
    PUTBASIC "loader.bas","Loader"
    PRINT "Code takes",END-START,"bytes"
    SAVE "Patcher",START,END

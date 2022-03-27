; Pharoah's Curse  : NuLA version
; 22 Feb 2022 -- 

ORG &900

.START:
.LOAD_NULA:
    LDX #LO(LOADER_NULA)
    LDY #HI(LOADER_NULA)
    JMP DO_LOAD

.LOAD_NORMAL:
    LDX #LO(LOADER_NORMAL)
    LDY #HI(LOADER_NORMAL)

.DO_LOAD:
    JSR &FFF7
    LDX #0

.PROGRAM_PAL:
    LDA PAL,X
    STA &FE23
    INX
    CPX #32
    BNE PROGRAM_PAL

.START_GAME:
    JMP &1900

.PAL:
    INCBIN "bin/game.pal"

.LOADER_NULA:
    EQUS "LOAD CURSE",13

.LOADER_NORMAL:
    EQUS "LOAD ORG",13

.END:
    PUTFILE "bin/curse.new","CURSE",&1900,&1900
    PUTFILE "res/curse.bin","ORG",&1900,&1900
    PUTBASIC "loader.bas","Loader"
    SAVE "PATCHER",START,END

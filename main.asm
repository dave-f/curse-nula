; Pharoah's Curse  : NuLA version
; 22 Feb 2022 -- 

ORG &900
.START:
    RTS
.END:

    PUTFILE "curse.new","CURSE",&1900,&1900
    PUTFILE "curse.bin","ORG",&1900,&1900
    PUTBASIC "loader.bas","Loader"
    SAVE "dave",START,END

REM  ** Pharaoh's  Curse **
REM  ** NuLA Restoration **
REM  Version 1.0 April 2022
REM Archaeology Dave Footitt
REM  Restoration Chris Hogg
REM
MODE 7
DIM REGS 4
A%=234
X%=0
Y%=0
!REGS = USR &FFF4
IF REGS?1 <> 0 PRINT '"Not compatible with TUBE":END
*FX200,3
VDU23,0,8,&30,0;0;0;
*FX9
*FX10
*FX151,32,16
*FX19
E%=FNTM
*FX151,34,68
*FX19
G%=FNTM
NULA%=E%/G%>0.75
MODE 7
PROCTITLE
PRINT
IF NULA% PRINTTAB(12)"NuLA Detected OK" ELSE PRINT" No NuLA detected - normal game will run";
PRINT
PROCKEYS
PRINT'
*FX 4,1
*FX 15
PRINT " Select fewer enemies for an easier game"
PRINT
INPUTTAB(12)"Enemies (1-5)",ENEMIES%
?&71 = FNCLAMP(ENEMIES%,1,5)+1
IF NULA% ?&70=1 ELSE ?&70=0
IF NULA% ?&FE22=&40
REM PRINT
REM PRINT ?&70,?&71
MODE 7
PRINT '"Loading..."
CLOSE #0
*RUN PATCHER
END
DEFFNTM:LOCALI%,T%:TIME=0:FORI%=1TO5:*FX19
NEXT:T%=TIME:=T%
DEFFNCLAMP(N%,L%,H%):IF N%<L% THEN N%=L% ELSE IF N%>H% THEN N%=H%
=N%
DEFPROCTITLE
PRINT CHR$(132);CHR$(157);"      ";CHR$(135);CHR$(156);CHR$(141);" Pharaoh's  Curse  ";CHR$(132);CHR$(157)
PRINT CHR$(131);CHR$(157);"      ";CHR$(135);CHR$(156);CHR$(141);" Pharaoh's  Curse  ";CHR$(131);CHR$(157)
PRINT CHR$(132);CHR$(157);"      ";CHR$(135);CHR$(156);CHR$(141);" NuLA Restoration  ";CHR$(132);CHR$(157)
PRINT CHR$(131);CHR$(157);"      ";CHR$(135);CHR$(156);CHR$(141);" NuLA Restoration  ";CHR$(131);CHR$(157)
ENDPROC
DEFPROCKEYS
PRINT
PRINTTAB(15)"Z - Left"
PRINTTAB(15)"X - Right"
PRINTTAB(15)": - Up"
PRINTTAB(15)"/ - Down"
PRINTTAB(10)"RETURN - Shine torch"
PRINTTAB(11)"SHIFT - Drop dynamite"
PRINTTAB(15)"F - Freeze"
PRINTTAB(15)"S - Start"
PRINTTAB(15)"Q - Quiet"
PRINTTAB(15)"L - Loud"
PRINTTAB(10)"ESCAPE - Give up"
ENDPROC

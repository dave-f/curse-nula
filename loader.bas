REM Pharaoh's Curse : NuLA version v0.1
REM By Dave Footitt and Chris Hogg 2022
REM
MODE7
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
IF NULA% GOTO 23 ELSE MODE7:PRINT '"No NuLA detected!"':GOTO 33
MODE2
VDU 23,1,0;0;0;
*FX4,1
PROCPAL
REM *LOAD JETFONT
REM *LOAD JETPIC
REM *LOAD JETLOGO
REM CALL &900
REM VDU 23,1,1;0;0;0;
REM COLOUR11:PRINTTAB(0,7)"     NuLA ReFuel"'':COLOUR 3
*FX15
INPUT "Lives",LIVES%
INPUT "Snakes (1-5)",SNAKES%
?&70 = FNCLAMP(LIVES%,1,99)
?&71 = FNCLAMP(SNAKES%,1,5)
IF NULA% ?&72=1 ELSE ?&72=0
REM IF NULA% ?&FE22=&40
REM MODE 7
PRINT "Loading..."
CLOSE #0
*RUN CURSE
END
DEFFNTM:LOCALI%,T%:TIME=0:FORI%=1TO5:*FX19
NEXT:T%=TIME:=T%
DEFFNCLAMP(N%,L%,H%):IF N%<L% THEN N%=L% ELSE IF N%>H% THEN N%=H%
=N%
DEFPROCPAL
?&FE23=&00 : ?&FE23=&00
?&FE23=&19 : ?&FE23=&86
?&FE23=&23 : ?&FE23=&31
?&FE23=&3F : ?&FE23=&B7
?&FE23=&45 : ?&FE23=&43
?&FE23=&5F : ?&FE23=&0F
?&FE23=&60 : ?&FE23=&FF
?&FE23=&7F : ?&FE23=&FF
ENDPROC

;*******************************************************
;*                 Code Produced by the                *
;*             PROTON+ Compiler. Version 2.1.3         *
;* Copyright Rosetta Technologies/Crownhill Associates *
;*              Written by Les Johnson. 2003           *
;*******************************************************
	NOLIST

	#include "C:\work\DERECE~1\saat.PBP" 

	LIST
SANIYE Equ 61
DAKIKA Equ 62
SAAT Equ 63
AY Equ 64
GUN Equ 65
YIL Equ 66
_X Equ 67
_Y Equ 68
_Z Equ 69
POL Equ 70
AYR Equ 71
_I Equ 72
_T Equ 73
 Variable _T#0=73,_T#1=74,_T#2=75,_T#3=76,_T#4=77,_T#5=78
 Variable _T#6=79
YK Equ 80
HG Equ 81
 Variable HG#0=81,HG#1=82,HG#2=83,HG#3=84,HG#4=85,HG#5=86
 Variable HG#6=87,HG#7=88,HG#8=89
SONUC Equ 90
SONUCH Equ 91
GUN2 Equ 92
GUN2H Equ 93
SC Equ 94
SCH Equ 95
SCD Equ 96
SCDH Equ 97
_B#VR1 Equ 98
	#Define MESG _B#VR1,0
	#Define SEC PORTA,3
	#Define EKSI PORTA,2
	#Define ARTI PORTA,4
	#Define DQ PORTA,1
F1_SOF equ $ ; SAAT.BAS
F1_000016 equ $ ; in [saat.bas] cmcon=7
	Movlw 7
	Movwf CMCON
F1_000017 equ $ ; in [saat.bas] delayms 300
	Movlw 1
	Movwf PP1H
	Movlw 44
	Call dly@w
F1_000018 equ $ ; in [saat.bas] cls
	Call Lcd@Cls
F1_000019 equ $ ; in [saat.bas] busout $d0,7,[16]
	Movlw 208
	Call Busout
	Movlw 7
	Call Busout
	Movlw 16
	Call Busout2
ANA_P
F1_000021 equ $ ; in [saat.bas] gosub tus
	Call TUS
F1_000022 equ $ ; in [saat.bas] cls
	Call Lcd@Cls
F1_000023 equ $ ; in [saat.bas] while 1=1
bc@ll1
F1_000024 equ $ ; in [saat.bas] gosub sicaklik
	Call SICAKLIK
F1_000025 equ $ ; in [saat.bas] if eksi=0 then gosub resetle
	Btfsc PORTA,2
	Goto bc@ll4
	Call RESETLE
bc@ll4
F1_000026 equ $ ; in [saat.bas] wend
	Goto bc@ll1
bc@ll2
SICAKLIK
F1_000031 equ $ ; in [saat.bas] OWrite   dq, 1, [$CC, $44]
	Movlw PORTA
	Movwf GEN
	Movlw 2
	Movwf GENH
	Movlw 1
	Movwf GPR
	Call Ow@rst2
	Movlw 204
	Call ow@out
	Movlw 68
	Call ow@out
MESGUL
F1_000034 equ $ ; in [saat.bas] Oread    dq, 4, [mesg]
	Movlw PORTA
	Movwf GEN
	Movlw 2
	Movwf GENH
	Movlw 4
	Movwf GPR
	Call Ow@in
	Andlw 1
	Skpnz
	Bcf _B#VR1,0
	Skpz
	Bsf _B#VR1,0
F1_000035 equ $ ; in [saat.bas] gosub  saat_goster
	Call SAAT_GOSTER
F1_000036 equ $ ; in [saat.bas] If      mesg = 0 Then mesgul
	Btfsc _B#VR1,0
	Goto bc@ll6
	Goto MESGUL
bc@ll6
F1_000037 equ $ ; in [saat.bas] OWrite  dq, 1, [$CC, $BE]
	Movlw PORTA
	Movwf GEN
	Movlw 2
	Movwf GENH
	Movlw 1
	Movwf GPR
	Call Ow@rst2
	Movlw 204
	Call ow@out
	Movlw 190
	Call ow@out
F1_000038 equ $ ; in [saat.bas] Oread    dq, 2, [sc.LowByte, sc.HighByte]
	Movlw PORTA
	Movwf GEN
	Movlw 2
	Movwf GENH
	Movlw 2
	Movwf GPR
	Call Ow@in
	Movwf SC
	Call Ow@in
	Movwf SCH
	Call Ow@rst1
F1_000039 equ $ ; in [saat.bas] If sc>3000 Then
	Movlw 11
	Subwf SCH,W
	Btfss STATUS,0
	Goto bc@ll8
	Btfss STATUS,2
	Goto cp@lb2
	Movlw 185
	Subwf SC,W
	Btfss STATUS,0
	Goto bc@ll8
cp@lb2
F1_000040 equ $ ; in [saat.bas] pol="-"
	Movlw 45
	Movwf POL
F1_000041 equ $ ; in [saat.bas] sc=~sc + 1
	Comf SC,W
	Movwf PBP#VAR0
	Comf SCH,W
	Movwf PBP#VAR0H
	Movlw 1
	Addwf PBP#VAR0,W
	Movwf SC
	Movfw PBP#VAR0H
	Skpnc
	Addlw 1
	Movwf SCH
F1_000042 equ $ ; in [saat.bas] goto cik
	Goto CIK
F1_000043 equ $ ; in [saat.bas] endif
bc@ll8
F1_000044 equ $ ; in [saat.bas] if sc<=3000 then pol="+"
	Movlw 11
	Subwf SCH,W
	Btfss STATUS,0
	Goto cp@lb3
	Btfss STATUS,2
	Goto bc@ll10
	Movlw 185
	Subwf SC,W
	Btfsc STATUS,0
	Goto bc@ll10
cp@lb3
	Movlw 43
	Movwf POL
bc@ll10
F1_000045 equ $ ; in [saat.bas] if sc=0 then pol=" "
	Movfw SCH
	Iorwf SC,W
	Btfss STATUS,2
	Goto bc@ll12
	Movlw 32
	Movwf POL
bc@ll12
CIK
F1_000047 equ $ ; in [saat.bas] scd=sc/16
	Movfw SC
	Movwf SCD
	Movfw SCH
	Movwf SCDH
	Movlw 4
	Movwf PP0
D@LB1
	Clrc
	Rrf SCDH,F
	Rrf SCD,F
	Decfsz PP0,F
	Goto D@LB1
F1_000048 equ $ ; in [saat.bas] return
	Return
MENU
F1_000051 equ $ ; in [saat.bas] gosub tus
	Call TUS
F1_000052 equ $ ; in [saat.bas] cls
	Call Lcd@Cls
F1_000053 equ $ ; in [saat.bas] print at 1,1,"SAAT AYARI"
	Movlw 128
	Movwf BPFH
	Movlw 128
	Call LCD@crs
	Movlw 'S'
	Call Print
	Movlw 'A'
	Call Print
	Call Print
	Movlw 'T'
	Call Print
	Movlw ' '
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'Y'
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'R'
	Call Print
	Movlw 'I'
	Call Print
F1_000054 equ $ ; in [saat.bas] while arti=1
bc@ll13
	Btfss PORTA,4
	Goto bc@ll14
F1_000055 equ $ ; in [saat.bas] if sec=0 then saat_ayar
	Btfsc PORTA,3
	Goto bc@ll16
	Goto SAAT_AYAR
bc@ll16
F1_000056 equ $ ; in [saat.bas] delayms 5
	Movlw 5
	Call dl@ms
F1_000057 equ $ ; in [saat.bas] wend
	Goto bc@ll13
bc@ll14
F1_000058 equ $ ; in [saat.bas] gosub tus
	Call TUS
F1_000059 equ $ ; in [saat.bas] cls
	Call Lcd@Cls
F1_000060 equ $ ; in [saat.bas] print at 1,1,"TARiH AYARI"
	Movlw 128
	Movwf BPFH
	Movlw 128
	Call LCD@crs
	Movlw 'T'
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'R'
	Call Print
	Movlw 'i'
	Call Print
	Movlw 'H'
	Call Print
	Movlw ' '
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'Y'
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'R'
	Call Print
	Movlw 'I'
	Call Print
F1_000061 equ $ ; in [saat.bas] while arti=1
bc@ll17
	Btfss PORTA,4
	Goto bc@ll18
F1_000062 equ $ ; in [saat.bas] if sec=0 then tarih_ayar
	Btfsc PORTA,3
	Goto bc@ll20
	Goto TARIH_AYAR
bc@ll20
F1_000063 equ $ ; in [saat.bas] delayms 5
	Movlw 5
	Call dl@ms
F1_000064 equ $ ; in [saat.bas] wend
	Goto bc@ll17
bc@ll18
F1_000065 equ $ ; in [saat.bas] goto menu
	Goto MENU
SAAT_AYAR
F1_000068 equ $ ; in [saat.bas] gosub tus
	Call TUS
F1_000069 equ $ ; in [saat.bas] cls
	Call Lcd@Cls
F1_000070 equ $ ; in [saat.bas] yk=1
	Movlw 1
	Movwf YK
F1_000071 equ $ ; in [saat.bas] print at 2,8,"^^"
	Movlw 128
	Movwf BPFH
	Movlw 199
	Call LCD@crs
	Movlw '^'
	Call Print
	Call Print
F1_000072 equ $ ; in [saat.bas] while 1=1
bc@ll21
F1_000073 equ $ ; in [saat.bas] if yk=1 and eksi=0 then dec dakika
	Movlw 1
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Movwf SP#P9
	Movlw 1
	Btfsc PORTA,2
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll24
	Decf DAKIKA,F
bc@ll24
F1_000074 equ $ ; in [saat.bas] if yk=1 and arti=0 then inc dakika
	Movlw 1
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Movwf SP#P9
	Movlw 1
	Btfsc PORTA,4
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll26
	Incf DAKIKA,F
bc@ll26
F1_000075 equ $ ; in [saat.bas] if yk=2 and eksi=0 then dec saat
	Movlw 2
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Movwf SP#P9
	Movlw 1
	Btfsc PORTA,2
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll28
	Decf SAAT,F
bc@ll28
F1_000076 equ $ ; in [saat.bas] if yk=2 and arti=0 then inc saat
	Movlw 2
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Movwf SP#P9
	Movlw 1
	Btfsc PORTA,4
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll30
	Incf SAAT,F
bc@ll30
F1_000077 equ $ ; in [saat.bas] if saat>23 then saat=0
	Movlw 24
	Subwf SAAT,W
	Btfss STATUS,0
	Goto bc@ll32
	Clrf SAAT
bc@ll32
F1_000078 equ $ ; in [saat.bas] if dakika>59 then dakika=0
	Movlw 60
	Subwf DAKIKA,W
	Btfss STATUS,0
	Goto bc@ll34
	Clrf DAKIKA
bc@ll34
F1_000079 equ $ ; in [saat.bas] print at 1,5,dec2 saat,":",dec2 dakika
	Movlw 128
	Movwf BPFH
	Movlw 132
	Call LCD@crs
	Movlw 2
	Movwf GEN4H
	Movfw SAAT
	Call out@decc
	Movlw ':'
	Call Print
	Movlw 2
	Movwf GEN4H
	Movfw DAKIKA
	Call out@decc
F1_000081 equ $ ; in [saat.bas] if sec=0 then
	Btfsc PORTA,3
	Goto bc@ll36
F1_000082 equ $ ; in [saat.bas] inc yk
	Incf YK,F
F1_000083 equ $ ; in [saat.bas] if yk=2 then
	Movlw 2
	Subwf YK,W
	Btfss STATUS,2
	Goto bc@ll38
F1_000084 equ $ ; in [saat.bas] print at 2,5,"^^   "
	Movlw 128
	Movwf BPFH
	Movlw 196
	Call LCD@crs
	Movlw '^'
	Call Print
	Call Print
	Movlw ' '
	Call Print
	Call Print
	Call Print
F1_000085 equ $ ; in [saat.bas] gosub tus
	Call TUS
F1_000086 equ $ ; in [saat.bas] goto saat_cik
	Goto SAAT_CIK
F1_000087 equ $ ; in [saat.bas] endif
bc@ll38
F1_000088 equ $ ; in [saat.bas] if yk>2 then
	Movlw 3
	Subwf YK,W
	Btfss STATUS,0
	Goto bc@ll40
F1_000089 equ $ ; in [saat.bas] cls : print at 1,1,"SAAT AYARLANDI"
	Call Lcd@Cls
	Movlw 128
	Movwf BPFH
	Movlw 128
	Call LCD@crs
	Movlw 'S'
	Call Print
	Movlw 'A'
	Call Print
	Call Print
	Movlw 'T'
	Call Print
	Movlw ' '
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'Y'
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'R'
	Call Print
	Movlw 'L'
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'N'
	Call Print
	Movlw 'D'
	Call Print
	Movlw 'I'
	Call Print
F1_000090 equ $ ; in [saat.bas] DELAYMS 1000
	Movlw 3
	Movwf PP1H
	Movlw 232
	Call dly@w
F1_000091 equ $ ; in [saat.bas] gosub saatver
	Call SAATVER
F1_000092 equ $ ; in [saat.bas] goto ana_p
	Goto ANA_P
F1_000093 equ $ ; in [saat.bas] endif
bc@ll40
F1_000096 equ $ ; in [saat.bas] endif
bc@ll36
SAAT_CIK
F1_000098 equ $ ; in [saat.bas] delayms 120
	Movlw 120
	Call dl@ms
F1_000099 equ $ ; in [saat.bas] wend
	Goto bc@ll21
bc@ll22
TARIH_AYAR
F1_000102 equ $ ; in [saat.bas] GOSUB tus
	Call TUS
F1_000103 equ $ ; in [saat.bas] cls
	Call Lcd@Cls
F1_000104 equ $ ; in [saat.bas] print at 2,11,"^^"
	Movlw 128
	Movwf BPFH
	Movlw 202
	Call LCD@crs
	Movlw '^'
	Call Print
	Call Print
F1_000105 equ $ ; in [saat.bas] yk=1
	Movlw 1
	Movwf YK
F1_000106 equ $ ; in [saat.bas] while 1=1
bc@ll41
F1_000107 equ $ ; in [saat.bas] if eksi=0 and yk=1 then dec yil
	Movlw 1
	Btfsc PORTA,2
	Clrw
	Movwf SP#P9
	Movlw 1
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll44
	Decf YIL,F
bc@ll44
F1_000108 equ $ ; in [saat.bas] if arti=0 and yk=1 then inc yil
	Movlw 1
	Btfsc PORTA,4
	Clrw
	Movwf SP#P9
	Movlw 1
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll46
	Incf YIL,F
bc@ll46
F1_000109 equ $ ; in [saat.bas] if eksi=0 and yk=2 then dec ay
	Movlw 1
	Btfsc PORTA,2
	Clrw
	Movwf SP#P9
	Movlw 2
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll48
	Decf AY,F
bc@ll48
F1_000110 equ $ ; in [saat.bas] if arti=0 and yk=2 then inc ay
	Movlw 1
	Btfsc PORTA,4
	Clrw
	Movwf SP#P9
	Movlw 2
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll50
	Incf AY,F
bc@ll50
F1_000111 equ $ ; in [saat.bas] if eksi=0 and yk=3 then dec gun
	Movlw 1
	Btfsc PORTA,2
	Clrw
	Movwf SP#P9
	Movlw 3
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll52
	Decf GUN,F
bc@ll52
F1_000112 equ $ ; in [saat.bas] if arti=0 and yk=3 then inc gun
	Movlw 1
	Btfsc PORTA,4
	Clrw
	Movwf SP#P9
	Movlw 3
	Subwf YK,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll54
	Incf GUN,F
bc@ll54
F1_000113 equ $ ; in [saat.bas] if yil>99 then yil=0
	Movlw 100
	Subwf YIL,W
	Btfss STATUS,0
	Goto bc@ll56
	Clrf YIL
bc@ll56
F1_000114 equ $ ; in [saat.bas] if ay=0 then ay=1
	Movfw AY
	Btfss STATUS,2
	Goto bc@ll58
	Movlw 1
	Movwf AY
bc@ll58
F1_000115 equ $ ; in [saat.bas] if gun=0 then gun=1
	Movfw GUN
	Btfss STATUS,2
	Goto bc@ll60
	Movlw 1
	Movwf GUN
bc@ll60
F1_000116 equ $ ; in [saat.bas] if ay>12 then ay=1
	Movlw 13
	Subwf AY,W
	Btfss STATUS,0
	Goto bc@ll62
	Movlw 1
	Movwf AY
bc@ll62
F1_000117 equ $ ; in [saat.bas] if yil//4=0 and ay=2 and gun>29 then gun=1
	Movlw 3
	Andwf YIL,W
	Movwf PBP#VAR0
	Clrf PBP#VAR0H
	Movfw PBP#VAR0H
	Iorwf PBP#VAR0,W
	Btfsc STATUS,2
	Goto cp@lb5
	Clrw
	Goto $ + 2
cp@lb5
	Movlw 1
	Movwf SP#P9
	Movlw 2
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Andwf SP#P9,W
	Movwf SP#P9
	Movlw 30
	Subwf GUN,W
	Clrw
	Btfsc STATUS,0
	Movlw 1
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll64
	Movlw 1
	Movwf GUN
bc@ll64
F1_000118 equ $ ; in [saat.bas] if yil//4<>0 and ay=2 and gun>28 then gun=1
	Movlw 3
	Andwf YIL,W
	Movwf PBP#VAR0
	Clrf PBP#VAR0H
	Movfw PBP#VAR0H
	Iorwf PBP#VAR0,W
	Btfss STATUS,2
	Movlw 1
	Movwf SP#P9
	Movlw 2
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Andwf SP#P9,W
	Movwf SP#P9
	Movlw 29
	Subwf GUN,W
	Clrw
	Btfsc STATUS,0
	Movlw 1
	Andwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll66
	Movlw 1
	Movwf GUN
bc@ll66
F1_000120 equ $ ; in [saat.bas] if ay=1 or ay=3 or ay=5 or ay=7 or ay=8 or ay=10 or ay=12 then
	Movlw 1
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Movwf SP#P9
	Movlw 3
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Movwf SP#P9
	Movlw 5
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Movwf SP#P9
	Movlw 7
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Movwf SP#P9
	Movlw 8
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Movwf SP#P9
	Movlw 10
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Movwf SP#P9
	Movlw 12
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll68
F1_000121 equ $ ; in [saat.bas] if gun>31 then gun=1
	Movlw 32
	Subwf GUN,W
	Btfss STATUS,0
	Goto bc@ll70
	Movlw 1
	Movwf GUN
bc@ll70
F1_000122 equ $ ; in [saat.bas] endif
bc@ll68
F1_000125 equ $ ; in [saat.bas] if ay=4 or ay=6 or ay=9 or ay=11 then
	Movlw 4
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Movwf SP#P9
	Movlw 6
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Movwf SP#P9
	Movlw 9
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Movwf SP#P9
	Movlw 11
	Subwf AY,W
	Btfsc STATUS,2
	Movlw 1
	Btfss STATUS,2
	Clrw
	Iorwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll72
F1_000126 equ $ ; in [saat.bas] if gun>30 then gun=1
	Movlw 31
	Subwf GUN,W
	Btfss STATUS,0
	Goto bc@ll74
	Movlw 1
	Movwf GUN
bc@ll74
F1_000127 equ $ ; in [saat.bas] endif
bc@ll72
F1_000128 equ $ ; in [saat.bas] print at 1,5,dec2 gun,"/",dec2 ay,"/",dec2 yil
	Movlw 128
	Movwf BPFH
	Movlw 132
	Call LCD@crs
	Movlw 2
	Movwf GEN4H
	Movfw GUN
	Call out@decc
	Movlw '/'
	Call Print
	Movlw 2
	Movwf GEN4H
	Movfw AY
	Call out@decc
	Movlw '/'
	Call Print
	Movlw 2
	Movwf GEN4H
	Movfw YIL
	Call out@decc
F1_000129 equ $ ; in [saat.bas] if sec=0 then
	Btfsc PORTA,3
	Goto bc@ll76
F1_000130 equ $ ; in [saat.bas] if yk=1 then
	Movlw 1
	Subwf YK,W
	Btfss STATUS,2
	Goto bc@ll78
F1_000131 equ $ ; in [saat.bas] yk=2 : print at 2,8,"^^   " : gosub tus : goto cikis : endif
	Movlw 2
	Movwf YK
	Movlw 128
	Movwf BPFH
	Movlw 199
	Call LCD@crs
	Movlw '^'
	Call Print
	Call Print
	Movlw ' '
	Call Print
	Call Print
	Call Print
	Call TUS
	Goto CIKIS
bc@ll78
F1_000132 equ $ ; in [saat.bas] if yk=2 then
	Movlw 2
	Subwf YK,W
	Btfss STATUS,2
	Goto bc@ll80
F1_000133 equ $ ; in [saat.bas] yk=3 : print at 2,5,"^^   " : gosub tus : goto cikis : endif ;gosub tarihver
	Movlw 3
	Movwf YK
	Movlw 128
	Movwf BPFH
	Movlw 196
	Call LCD@crs
	Movlw '^'
	Call Print
	Call Print
	Movlw ' '
	Call Print
	Call Print
	Call Print
	Call TUS
	Goto CIKIS
bc@ll80
F1_000134 equ $ ; in [saat.bas] if yk=3 then
	Movlw 3
	Subwf YK,W
	Btfss STATUS,2
	Goto bc@ll82
F1_000135 equ $ ; in [saat.bas] yk=1 : cls  : print at 1,1,"TARiH AYARLANDI" : gosub tarihver : gosub tus : delayms 900 : goto ana_p : endif
	Movlw 1
	Movwf YK
	Call Lcd@Cls
	Movlw 128
	Movwf BPFH
	Movlw 128
	Call LCD@crs
	Movlw 'T'
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'R'
	Call Print
	Movlw 'i'
	Call Print
	Movlw 'H'
	Call Print
	Movlw ' '
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'Y'
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'R'
	Call Print
	Movlw 'L'
	Call Print
	Movlw 'A'
	Call Print
	Movlw 'N'
	Call Print
	Movlw 'D'
	Call Print
	Movlw 'I'
	Call Print
	Call TARIHVER
	Call TUS
	Movlw 3
	Movwf PP1H
	Movlw 132
	Call dly@w
	Goto ANA_P
bc@ll82
F1_000136 equ $ ; in [saat.bas] endif
bc@ll76
CIKIS
F1_000138 equ $ ; in [saat.bas] delayms 150
	Movlw 150
	Call dl@ms
F1_000139 equ $ ; in [saat.bas] wend
	Goto bc@ll41
bc@ll42
F1_000140 equ $ ; in [saat.bas] GOTO ana_p
	Goto ANA_P
SAAT_GOSTER
F1_000143 equ $ ; in [saat.bas] gosub saatal
	Call SAATAL
F1_000144 equ $ ; in [saat.bas] print at 1,1,dec2 saat,":",dec2 dakika,":",dec2 saniye,at 1,12,pol, dec2 scd,223,"C",_
	Movlw 128
	Movwf BPFH
	Movlw 128
	Call LCD@crs
	Movlw 2
	Movwf GEN4H
	Movfw SAAT
	Call out@decc
	Movlw ':'
	Call Print
	Movlw 2
	Movwf GEN4H
	Movfw DAKIKA
	Call out@decc
	Movlw ':'
	Call Print
	Movlw 2
	Movwf GEN4H
	Movfw SANIYE
	Call out@decc
	Movlw 139
	Call LCD@crs
	Movfw POL
	Call Print
	Movlw 2
	Movwf GEN4H
	Movfw SCDH
	Movwf PP2H
	Movfw SCD
	Movwf PP2
	Call out@dec
	Movlw 223
	Call Print
	Movlw 'C'
	Call Print
	Movlw 192
	Call LCD@crs
	Movlw 2
	Movwf GEN4H
	Movfw GUN
	Call out@decc
	Movlw '/'
	Call Print
	Movlw 2
	Movwf GEN4H
	Movfw AY
	Call out@decc
	Movlw '/'
	Call Print
	Movlw '2'
	Call Print
	Movlw '0'
	Call Print
	Movlw 2
	Movwf GEN4H
	Movfw YIL
	Call out@decc
F1_000146 equ $ ; in [saat.bas] if sec=0 then menu
	Btfsc PORTA,3
	Goto bc@ll84
	Goto MENU
bc@ll84
F1_000147 equ $ ; in [saat.bas] delayms 100
	Movlw 100
	Call dl@ms
F1_000148 equ $ ; in [saat.bas] return
	Return
SAATAL
F1_000151 equ $ ; in [saat.bas] busin $d0,0,[t[0],t[1],t[2],t[3],t[4],t[5],t[6]]
	Movlw 208
	Call Busout
	Clrw
	Call Busout
	Call Busin2
	Movfw PP1
	Movwf _T#0
	Call Busin2
	Movfw PP1
	Movwf _T#1
	Call Busin2
	Movfw PP1
	Movwf _T#2
	Call Busin2
	Movfw PP1
	Movwf _T#3
	Call Busin2
	Movfw PP1
	Movwf _T#4
	Call Busin2
	Movfw PP1
	Movwf _T#5
	Call Busin2
	Movfw PP1
	Movwf _T#6
F1_000152 equ $ ; in [saat.bas] for i=0 to 6
	Clrf _I
fr@lb86
	Movlw 7
	Subwf _I,W
	Btfsc STATUS,0
	Goto nx@lb87
F1_000153 equ $ ; in [saat.bas] t[i]=10*(t[i]/16)+(t[i]//16)
	Clrf PP7H
	Movlw 10
	Movwf PP7
	Movfw _I
	Addlw _T
	Movwf FSR
	Movfw INDF
	Movwf PBP#VAR1
	Clrf PP8H
	Movfw PBP#VAR1
	Movwf PP8
	Movlw 4
	Movwf PP0
D@LB2
	Clrc
	Rrf PP8H,F
	Rrf PP8,F
	Decfsz PP0,F
	Goto D@LB2
	Movfw PP7H
	Movwf PP3H
	Movfw PP7
	Movwf PP3
	Movfw PP8H
	Movwf PP1H
	Movfw PP8
	Movwf PP1
	Call m@py
	Movwf PP7
	Movfw PP2H
	Movwf PP7H
	Movfw _I
	Addlw _T
	Movwf FSR
	Movfw INDF
	Movwf PBP#VAR2
	Clrf PP8H
	Movfw PBP#VAR2
	Movwf PP8
	Movlw 15
	Andwf PP8,F
	Clrf PP8H
	Movfw PP7
	Addwf PP8,W
	Movwf PBP#VAR0
	Movfw _I
	Addlw _T
	Movwf FSR
	Movfw PBP#VAR0
	Movwf INDF
F1_000154 equ $ ; in [saat.bas] next
	Incfsz _I,F
	Goto fr@lb86
nx@lb87
F1_000155 equ $ ; in [saat.bas] saniye=t[0] : dakika=t[1] : saat=t[2] : gun=t[4] : ay=t[5] : yil=t[6]
	Movfw _T#0
	Movwf SANIYE
	Movfw _T#1
	Movwf DAKIKA
	Movfw _T#2
	Movwf SAAT
	Movfw _T#4
	Movwf GUN
	Movfw _T#5
	Movwf AY
	Movfw _T#6
	Movwf YIL
F1_000156 equ $ ; in [saat.bas] Return
	Return
SAATVER
F1_000159 equ $ ; in [saat.bas] dakika=16*(dakika Dig 1)+dakika//10
	Clrf PP7H
	Movlw 16
	Movwf PP7
	Clrf PP8H
	Movfw DAKIKA
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Movlw 1
	Call dig
	Clrf PP8H
	Movwf PP8
	Movfw PP7H
	Movwf PP3H
	Movfw PP7
	Movwf PP3
	Movfw PP8H
	Movwf PP1H
	Movfw PP8
	Movwf PP1
	Call m@py
	Movwf PP7
	Movfw PP2H
	Movwf PP7H
	Clrf PP8H
	Movfw DAKIKA
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Clrf PP1H
	Movlw 10
	Movwf PP1
	Call d@vd
	Movfw PP2H
	Movwf PP8H
	Movfw PP2
	Movwf PP8
	Movfw PP7
	Addwf PP8,W
	Movwf DAKIKA
F1_000160 equ $ ; in [saat.bas] saat=16*(saat Dig 1)+saat//10
	Clrf PP7H
	Movlw 16
	Movwf PP7
	Clrf PP8H
	Movfw SAAT
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Movlw 1
	Call dig
	Clrf PP8H
	Movwf PP8
	Movfw PP7H
	Movwf PP3H
	Movfw PP7
	Movwf PP3
	Movfw PP8H
	Movwf PP1H
	Movfw PP8
	Movwf PP1
	Call m@py
	Movwf PP7
	Movfw PP2H
	Movwf PP7H
	Clrf PP8H
	Movfw SAAT
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Clrf PP1H
	Movlw 10
	Movwf PP1
	Call d@vd
	Movfw PP2H
	Movwf PP8H
	Movfw PP2
	Movwf PP8
	Movfw PP7
	Addwf PP8,W
	Movwf SAAT
F1_000161 equ $ ; in [saat.bas] busout $d1,0,[0,dakika,saat]
	Movlw 209
	Call Busout
	Clrw
	Call Busout
	Clrw
	Call Busout
	Movfw DAKIKA
	Call Busout
	Movfw SAAT
	Call Busout2
F1_000162 equ $ ; in [saat.bas] Return
	Return
TARIHVER
F1_000165 equ $ ; in [saat.bas] gun=16*(gun Dig 1)+gun//10
	Clrf PP7H
	Movlw 16
	Movwf PP7
	Clrf PP8H
	Movfw GUN
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Movlw 1
	Call dig
	Clrf PP8H
	Movwf PP8
	Movfw PP7H
	Movwf PP3H
	Movfw PP7
	Movwf PP3
	Movfw PP8H
	Movwf PP1H
	Movfw PP8
	Movwf PP1
	Call m@py
	Movwf PP7
	Movfw PP2H
	Movwf PP7H
	Clrf PP8H
	Movfw GUN
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Clrf PP1H
	Movlw 10
	Movwf PP1
	Call d@vd
	Movfw PP2H
	Movwf PP8H
	Movfw PP2
	Movwf PP8
	Movfw PP7
	Addwf PP8,W
	Movwf GUN
F1_000166 equ $ ; in [saat.bas] ay=16*(ay Dig 1)+ay//10
	Clrf PP7H
	Movlw 16
	Movwf PP7
	Clrf PP8H
	Movfw AY
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Movlw 1
	Call dig
	Clrf PP8H
	Movwf PP8
	Movfw PP7H
	Movwf PP3H
	Movfw PP7
	Movwf PP3
	Movfw PP8H
	Movwf PP1H
	Movfw PP8
	Movwf PP1
	Call m@py
	Movwf PP7
	Movfw PP2H
	Movwf PP7H
	Clrf PP8H
	Movfw AY
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Clrf PP1H
	Movlw 10
	Movwf PP1
	Call d@vd
	Movfw PP2H
	Movwf PP8H
	Movfw PP2
	Movwf PP8
	Movfw PP7
	Addwf PP8,W
	Movwf AY
F1_000167 equ $ ; in [saat.bas] yil=16*(yil Dig 1)+yil//10
	Clrf PP7H
	Movlw 16
	Movwf PP7
	Clrf PP8H
	Movfw YIL
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Movlw 1
	Call dig
	Clrf PP8H
	Movwf PP8
	Movfw PP7H
	Movwf PP3H
	Movfw PP7
	Movwf PP3
	Movfw PP8H
	Movwf PP1H
	Movfw PP8
	Movwf PP1
	Call m@py
	Movwf PP7
	Movfw PP2H
	Movwf PP7H
	Clrf PP8H
	Movfw YIL
	Movwf PP8
	Movfw PP8H
	Movwf PP0H
	Movfw PP8
	Movwf PP0
	Clrf PP1H
	Movlw 10
	Movwf PP1
	Call d@vd
	Movfw PP2H
	Movwf PP8H
	Movfw PP2
	Movwf PP8
	Movfw PP7
	Addwf PP8,W
	Movwf YIL
F1_000168 equ $ ; in [saat.bas] busout $d1,4,[gun,ay,yil]
	Movlw 209
	Call Busout
	Movlw 4
	Call Busout
	Movfw GUN
	Call Busout
	Movfw AY
	Call Busout
	Movfw YIL
	Call Busout2
F1_000169 equ $ ; in [saat.bas] return
	Return
RESETLE
F1_000175 equ $ ; in [saat.bas] busout $d1,0,[0,0,0,1,1,1,0]
	Movlw 209
	Call Busout
	Clrw
	Call Busout
	Clrw
	Call Busout
	Clrw
	Call Busout
	Clrw
	Call Busout
	Movlw 1
	Call Busout
	Movlw 1
	Call Busout
	Movlw 1
	Call Busout
	Clrw
	Call Busout2
F1_000176 equ $ ; in [saat.bas] Return
	Return
TUS
F1_000179 equ $ ; in [saat.bas] delayms 70
	Movlw 70
	Call dl@ms
F1_000180 equ $ ; in [saat.bas] while sec=0 or arti=0 or eksi=0
bc@ll87
	Movlw 1
	Btfsc PORTA,3
	Clrw
	Movwf SP#P9
	Movlw 1
	Btfsc PORTA,4
	Clrw
	Iorwf SP#P9,W
	Movwf SP#P9
	Movlw 1
	Btfsc PORTA,2
	Clrw
	Iorwf SP#P9,W
	Btfsc STATUS,2
	Goto bc@ll88
F1_000181 equ $ ; in [saat.bas] delayus 200
	Movlw 200
	Call dl@us
F1_000182 equ $ ; in [saat.bas] wend
	Goto bc@ll87
bc@ll88
F1_000183 equ $ ; in [saat.bas] return
	Return
F1_000186 equ $ ; in [saat.bas] end
Pb@lb90
	Sleep
	Goto Pb@lb90
	END


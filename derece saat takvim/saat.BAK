device=16f628
lcd_rspin portb.2
lcd_enpin portb.3
dim  saniye, dakika, saat, ay, gun, yil,x,y,z,pol,ayr,i,t[7],yk,hg[9]
dim sonuc as word
dim gun2 as word
dim sc as word
dim scd as word
dim mesg as bit
Symbol sec=PORTA.3
Symbol eksi=PORTA.2
Symbol arti=PORTA.4
scl_pin=PORTB.0
sda_pin=PORTB.1
symbol dq=porta.1
cmcon=7
delayms 300
cls 
busout $d0,7,[16] 
ana_p:
gosub tus
cls
while 1=1 
gosub sicaklik 
if eksi=0 then gosub resetle
wend


'-------------------------------------------------------------------------
sicaklik:
    OWrite   dq, 1, [$CC, $44]
    
mesgul:
    Oread    dq, 4, [mesg]
	gosub  saat_goster  
    If      mesg = 0 Then mesgul 
    OWrite  dq, 1, [$CC, $BE]
    Oread    dq, 2, [sc.LowByte, sc.HighByte]
    If sc>3000 Then
    pol="-"
    sc=~sc + 1
	goto cik
	endif
  if sc<=3000 then pol="+"
  if sc=0 then pol=" "
 cik:
	scd=sc/16  
    return	  
''        ------------------------------------------------------------------------ 
menu: 
gosub tus
cls
print at 1,1,"SAAT AYARI"
while arti=1
if sec=0 then saat_ayar
delayms 5
wend
gosub tus
cls
print at 1,1,"TARiH AYARI" 
while arti=1
if sec=0 then tarih_ayar
delayms 5
wend
goto menu

saat_ayar:
gosub tus
cls
yk=1
print at 2,8,"^^"
while 1=1
if yk=1 and eksi=0 then dec dakika
if yk=1 and arti=0 then inc dakika
if yk=2 and eksi=0 then dec saat
if yk=2 and arti=0 then inc saat 
if saat>23 then saat=0
if dakika>59 then dakika=0 
print at 1,5,dec2 saat,":",dec2 dakika

	if sec=0 then
        inc yk
        if yk=2 then 
		print at 2,5,"^^   "
		gosub tus
		goto saat_cik
			 endif
                if yk>2 then 
                       cls : print at 1,1,"SAAT AYARLANDI"
					   DELAYMS 1000
                        gosub saatver
                        goto ana_p
                endif 
				;gosub tus 
				
	endif	
	saat_cik:		
delayms 120
wend
'-------------------------------------------------------------
tarih_ayar:
GOSUB tus
cls
print at 2,11,"^^"
yk=1
while 1=1
if eksi=0 and yk=1 then dec yil
if arti=0 and yk=1 then inc yil
if eksi=0 and yk=2 then dec ay
if arti=0 and yk=2 then inc ay
if eksi=0 and yk=3 then dec gun
if arti=0 and yk=3 then inc gun
if yil>99 then yil=0
if ay=0 then ay=1
if gun=0 then gun=1
if ay>12 then ay=1
if yil//4=0 and ay=2 and gun>29 then gun=1
if yil//4<>0 and ay=2 and gun>28 then gun=1

if ay=1 or ay=3 or ay=5 or ay=7 or ay=8 or ay=10 or ay=12 then
if gun>31 then gun=1
endif


if ay=4 or ay=6 or ay=9 or ay=11 then
if gun>30 then gun=1
endif
print at 1,5,dec2 gun,"/",dec2 ay,"/",dec2 yil
if sec=0 then 
if yk=1 then
yk=2 : print at 2,8,"^^   " : gosub tus : goto cikis : endif 
if yk=2 then 
yk=3 : print at 2,5,"^^   " : gosub tus : goto cikis : endif ;gosub tarihver
if yk=3 then
yk=1 : cls  : print at 1,1,"TARiH AYARLANDI" : gosub tarihver : gosub tus : delayms 900 : goto ana_p : endif
endif
cikis:
delayms 150
wend
GOTO ana_p
'--------------------------------------------------------------
saat_goster:  
gosub saatal
print at 1,1,dec2 saat,":",dec2 dakika,":",dec2 saniye,at 1,12,pol, dec2 scd,223,"C",_
at 2,1,dec2 gun,"/",dec2 ay,"/20",dec2 yil
if sec=0 then menu
delayms 100
return	
;-------------------------------------------------------------
saatal:
busin $d0,0,[t[0],t[1],t[2],t[3],t[4],t[5],t[6]]
for i=0 to 6
t[i]=10*(t[i]/16)+(t[i]//16)
next 
saniye=t[0] : dakika=t[1] : saat=t[2] : gun=t[4] : ay=t[5] : yil=t[6]   
Return
'---------------------------------------------------------------------------
saatver:
dakika=16*(dakika Dig 1)+dakika//10
saat=16*(saat Dig 1)+saat//10
busout $d1,0,[0,dakika,saat] 
Return 
'---------------------------------------------------------------------------
tarihver:
gun=16*(gun Dig 1)+gun//10
ay=16*(ay Dig 1)+ay//10			  
yil=16*(yil Dig 1)+yil//10
busout $d1,4,[gun,ay,yil]
return
'---------------------------------------------------------------------------
 
'---------------------------------------------------------------------------
'saati kurma alt programi
resetle:
busout $d1,0,[0,0,0,1,1,1,0]
Return	
'---------------------------------------------------------------------------
tus:
delayms 70
while sec=0 or arti=0 or eksi=0 
delayus 200
wend
return


end

#include<16f877.h>   
#fuses xt,nowdt,noprotect                       // sigortalar� ayarla
#use delay(clock=4000000)              // 4 Mhz kristal i�in gecikmeleri ayarla
#define calis output_high(pin_d0);     // cal��ma an�nda yanacak led tan�mland�
#define dur   output_low(pin_d0);      // ledi geri s�nd�rmek i�in gerekli tan�mlama

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////                          
////////////  ana program ba�lang�c� //////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
// program timer2 sayac�n�n  T1CKI  ucundan gelen darbeleri  saymas� esas� ile �al���r     /////              
// devir say�s� dei�keni ve timer1 yani ayn� adrese tan�ml� olan sayac de�i�keni s�f�rlan�r   /////
// program 100 milisaniye aral�klarla 1 saniye bekletilir. bu esnada TMR0 gelen palsleri      /////
// saymaya devam eder. toplam 1 saniye sonunda tmr1 (sayac) �n de�eri diskte 24 delik oldu�u  /////
// ve ayar yani option registerinin tmr0 i�in de�eri 1/16 ya ayarland��u i�in elde edilen     /////
// de�er tam olarak bir saniyedeki devir say�s�n� verir. bu sonu� 60 ile �arp�larak bir       /////
// dakikadaki de�er elde edilmi� olunur. devrenin ikinci bir g�revi de motorun h�z kontro-    /////
// l�n�n yap�lmas�d�r.RA0 kanal� ilgili h�z kontrol potunun ayar ucuna ba�lan�r.   /////
// ilgili komutlar ile analog bilgi al�narak bir de�i�kene ve ard�ndan pwm darbe geni�li�ine  /////
// atan�r. bu sayede motorun h�z kontrol�de yap�lm�� olunur.  her sat�r i�in gerekli a��klama /////
// a�a��da yap�lm��t�r                                                                        /////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
                                             
void main()                                     
{                                  
                                                                                                                                 
unsigned int16 devir,sayac;                                                                                                    
unsigned int8 i,PVM;

setup_timer_1(T1_external|T1_div_by_1);   
setup_ccp1(ccp_pwm); 
setup_adc_ports( RA0_ANALOG );      
set_adc_channel(0);                

ana_p:
set_pwm1_duty(0);         
dur;                               
printf(lcd_putc,"iLKER-SERKAN" );
delay_ms(50);
lcd_gotoxy(1,2);                            
printf(lcd_putc,"STARTA BAS" ) ; 
 
 do
   {
    if(input(pin_d2)) break;      
   delay_ms(50);                   
   }
   while(1);      
 
lcd_putc("\fMOTOR CALISIYOR");                  
calis; 
lcd_putc("\f");                         
for(;;)        
{           
pvm=read_adc();    
printf(lcd_putc,"MOTOR CALISIYOR");               
DELAY_MS(30);
set_pwm1_duty(pvm); 
devir=0;                            
set_timer1(0);                            
//////////////////////////////////////////////////////////////////////////////////////
// bu k�s�m 100 ms aral�klarla durdurma butonuna bas�l�p bas�lmad���n� kontrol eder //
// bu arada  timer0 gelen palsleri sayar                                            //
//////////////////////////////////////////////////////////////////////////////////////
   for(i=0;i<10;i++)
   {                                                   
   delay_ms(100);
      if(input(pin_d3)) {goto ana_p;}  // durdurma butonuna bas�ld� ise ana_p ye git
   }
/////////////////////////////////////////////////////////////////////////////////////
sayac=get_timer1(); 
devir=sayac;                             // devir sayac�na say�lan de�eri ata
devir=devir*60/24;                         
printf(lcd_putc,"devir=%lud/d",devir);
}  
 
                                                      

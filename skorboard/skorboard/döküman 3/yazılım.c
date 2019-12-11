#include<16f877a.h>
#fuses xt
#use delay(clock=4000000)
#define s1a  pin_c2
#define s10  pin_c1
#define s1e  pin_c0
#define s2a  pin_c3
#define s20  pin_d1
#define s2e  pin_d0
#define arti pin_d2
#define sec  pin_d3
#define eksi pin_c4
#define siren pin_c5
unsigned int8  skor1,skor2,s1,d1,sn,kontrol;
unsigned int16 toplam,bitis;
void tus()
{
   delay_ms(80);
   while(!input(s1a) || !input(s10) || !input(s1e) || !input(s2a) || !input(s20) || !input(s2e) || !input(sec) || !input(arti) || !input(eksi)  );
}

unsigned int8 cevir(veri)
unsigned int8 sonuc;

void zaman()
{
      s1  = s_oku(2);  
      d1  = s_oku(1);
      sn  = s_oku(0);
      s1  = cevir(s1);
      d1  = cevir(d1);
      sn  = cevir(sn);
      bitis  = s1*60;
      bitis += d1;
      if(bitis >= toplam)
      {
      kontrol = 1;
      }
      lcd_gotoxy(1,5);
      printf(lcd_putc "%02u:%02u:%02u",s1,d1,sn);
}

void main()
{

delay_ms(200);
lcd_init();
s_init();
delay_ms(100);

output_low(siren);
   while(true)
   {
      lcd_putc("\f");
      lcd_putc("OYUN S");
      lcd_putc(0);
      lcd_putc("RESiNi");
      lcd_gotoxy(2,1);
      lcd_putc("GiRiNiZ");
      tus();
         while(input(sec));
      tus();
      lcd_putc("\f");
      s1 = 0;
      d1 = 0;
         lcd_putc("^^");
         while(input(sec))
         {
               if(!input(arti))
                  d1++;
               if(!input(eksi))
                  d1--;
               if(d1>=60)
                  d1 = 0;
            lcd_gotoxy(1,5);      
            printf(lcd_putc "%02u:%02u",s1,d1);
            delay_ms(150);               
         }
      tus();
      lcd_gotoxy(2,5);
      lcd_putc("^^   ");
         while(input(sec))
         {
               if(!input(arti))
                  s1++;
               if(!input(eksi))
                  s1--;
               if(s1>=24)
                  s1 = 0;
            lcd_gotoxy(1,5);      
            printf(lcd_putc "%02u:%02u",s1,d1);
            delay_ms(150);               
         }
      lcd_putc("OYUNU BASLAT");
      tus();
         while(input(sec));
      tus();      
      skor1 = 0;
      skor2 = 0;
      kontrol  = 0;
      s_yaz(0,0);
      s_yaz(1,0);
      s_yaz(2,0);
      lcd_putc("\f");
         while(input(sec) && !kontrol )
         {
               if(!input(s1a))
                  skor1++;
               if(!input(s10))
                  skor1 = 0;
               if(!input(s1e))
                  skor1--;
               if(skor1>99)
                  skor1 = 0;
                  
               if(!input(s2a))
                  skor2++;
               if(!input(s20))
                  skor2 = 0;
               if(!input(s2e))
                  skor2--;
               if(skor2>99)

            printf(lcd_putc "%02u",skor2);
            printf(lcd_putc "%02u",skor1);   
               if(!input(s1a) || !input(s10) || !input(s1e) || !input(s2a) || !input(s20) || !input(s2e))
               {
                        zaman();
                        delay_ms(50);
                        tus();
               }
            zaman();
            delay_ms(100);  
         }
      tus();
      lcd_putc("\f");
      lcd_putc("OYUN TAMAMLANDI");
         while(input(sec))
         {
            output_toggle(siren);
            delay_ms(300);
         }
      output_low(siren);   
      lcd_putc("\f");
      printf(lcd_putc "1.SKOR = %u",skor2);
      printf(lcd_putc "2.SKOR = %u",skor1);     
      tus();
         while(input(sec));
      tus();   
   }

}


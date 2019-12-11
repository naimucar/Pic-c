#include<16f628.h> 
#fuses nowdt,intrc_io,nomclr
#use delay(clock=4000000)
      

#define pin_a  pin_b1
#define pin_b  pin_b6     
#define pin_c  pin_b4
#define pin_d  pin_b5               
#define pin_e  pin_b2
#define pin_f  pin_b0                                            
#define pin_g  pin_b7                   
#define ct1    pin_a2              
#define ct2    pin_a3

unsigned int8 const tablo[10]=  // 7 segment ekranda karakterleri
{63 , // 0 karakteri            // göstermek için gerekli tablo                                
 6  , // 1 karakteri                                             
 91 , // 2 karakteri
 79 , // 3 karakteri
 102, // 4 karakteri
 109, // 5 karakteri
 125, // 6 karakteri
 7  , // 7 karakteri                                            
 127, // 8 karakteri
 111, // 9 karakteri
};  
                          

void digit_goster(unsigned int8 veri)  // tek digit göstermek için gerekli program                              
{
                                                                                  
   output_bit(pin_a,tablo[veri]&1);    // a segmenti bilgisi                                   
   output_bit(pin_b,tablo[veri]&2);    // b segmenti bilgisi
   output_bit(pin_c,tablo[veri]&4);    // c segmenti bilgisi    
   output_bit(pin_d,tablo[veri]&8);    // d segmenti bilgisi                  
   output_bit(pin_e,tablo[veri]&16);   // e segmenti bilgisi                    
   output_bit(pin_f,tablo[veri]&32);   // f segmenti bilgisi                    
   output_bit(pin_g,tablo[veri]&64);   // g segmenti bilgisi                    
}   

void ekran(unsigned int8 sayi)
{
unsigned int8 digit0,digit1,i;
                    
 digit0 = sayi % 10;                  // sayının 0. digitini ayıkla  
 digit1 = sayi / 10;                  // sayının 1. digitini ayıkla                            
  
  output_low(ct1);                    // 0. digitin ortak katodunu sıfıra çek                               
  digit_goster(digit0);               // sayıyı ekrana yolla                                      
  delay_ms(5);                        // sayının görünmesi için 5 ms bekle                     
  output_high(ct1);                   // ortak katodu diğer digit bilgisini de göstermemesi için +5 volta(I)'e çek                                   
                                      
  output_low(ct2);
  digit_goster(digit1);
  delay_ms(5);
  output_high(ct2);       
 }          
}    

void main()
{                                                                    
unsigned int8 f;
while(true)
{
while(!input(pin_a1));
f = 20;
do
{
ekran(f);
}while(f-- != 0);
output_high(ct1);
output_high(ct2);
output_high(pin_a0);
delay_ms(20);
output_float(pin_a0);
output_float(pin_a1);

}     

}                        

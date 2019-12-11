     #include<16f877a.h>
#device adc = 10
#fuses nowdt,xt                  
#use delay(clock=4000000)
#include<ekran.h>                   
#USE FAST_iO(E)           
unsigned int8  k=0,s=0,x=0,i=0;
unsigned int16 bilgi_1=0,bilgi_2=0,bilgi,z=0,y=0,d=0;                     
float  V1=0,V2=0,VAK=0,A=0,R=0,h=0,n=0;

void main()
{             
set_tris_e(0xff) ;                          
output_b(0x00);                               
setup_adc(ADC_CLOCK_INTERNAL);                             
setup_adc_ports(AN0_AN1_AN2_AN3_AN4 );              
                                             
lcd_init();                                               
printf(lcd_putc,"\f");             
delay_ms(300);   

   
                                 
while(1)                                      
{                                                    
 basla:                                           
                                               
/////////AKIM//////////////////////      
set_adc_channel(0);
delay_us(50);                             
bilgi=read_adc();                                        
A=0.005*bilgi; 
h=0.005*bilgi*1000;           
lcd_gotoxy(1,1);                                                   
printf(lcd_putc,"I=%1.1fmA ",h);
delay_ms(50);                              
                                                             
//////AKÜ////////////////                                   
set_adc_channel(3);                                 
delay_us(50);                   
bilgi=read_adc();                                  
VAK=0.005*bilgi*4;                                                                                                         
lcd_gotoxy(2,11);           
printf(lcd_putc,"A=%1.1f",VAK);                                   
                                                              

 
//////OPAMP SONRASI =V2     //////////
set_adc_channel(2);                                                               
delay_us(50);
bilgi_2=read_adc();                        
V2=0.005*bilgi_2;                                           
         v2=v2*100;   
 
       
            if(input(pin_e0)==0)                               
                    {  delay_ms(200);
                      
                      i++;                           
                       if(i==1)
                       {
                       if(V1<=400)
                       {   d=0;z=0;y=0;x=0;s=0; 
                       write_eeprom(0,0);      
                       write_eeprom(1,0);
                       z=bilgi_2&0x00ff;                                                          
                       y=bilgi_2&0xff00 ; 
                       y=y>>8;                                        
                       write_eeprom(0,z);      
                       write_eeprom(1,y);                       
                       x=read_eeprom(0);  
                       s=read_eeprom(1); 
                       D=make16(s,x); 
                       d=(float)d/2;
                       printf(lcd_putc,"\fDV=%f",(float)d);
                       lcd_gotoxy(2,1); 
                      printf(lcd_putc,"HAFIZAYA ALINDI");delay_ms(1000);
                       LCD_PUTC("\f");
                     }
                        else
                        {   
                        d=0;z=0;y=0;x=0;s=0;
                        write_eeprom(0,0);        
                       write_eeprom(1,0);
                       z=bilgi_1&0x00ff;
                       y=bilgi_1&0xff00 ; 
                       y=y>>8;
                       write_eeprom(0,z);      
                       write_eeprom(1,y);                       
                       x=read_eeprom(0);  
                       s=read_eeprom(1); 
                       D=make16(s,x); 
                       d=(float)d*5;
                      // printf(lcd_putc,"\fx=%f",(float)d);delay_ms(3000);
                       printf(lcd_putc,"\fDV=%f",(float)d);
                       lcd_gotoxy(2,1); 
                      printf(lcd_putc,"HAFIZAYA ALINDI");delay_ms(1000);
                       LCD_PUTC("\f");
                        }                                                                       
                        }
if(i==5){i=0; write_eeprom(0,0);0,x=0,z=0,y=0,s=0,d=0; printf(lcd_putc,"\fHAFIZA SiLiNDi");DELAY_MS(1000); printf(lcd_putc,"\f");v1=0;v2=0; }               
                     }

                                
                                                                                                   
   if(v2>=400)                                                                    
 {     goto f; }                                                                                                   
 else                                                                   
 {   lcd_gotoxy(2,1);                                                 
    printf(lcd_putc,"V=%1.1fmV ",v2-(float)d);               
    r=(v2-(float)d)/(a*1000); 
  lcd_gotoxy(1,12);                                                 
    printf(lcd_putc,"R=%1.2f ",r);  
    
 goto basla;                                                  
 }                                                                          
                                                         
   
                                                              
 f:  
   v2=0;                                                                
   ///////OPAMP ÖNCESÝ =V1     ////////////////////////
set_adc_channel(1); 
delay_us(100);                                     
bilgi_1=read_adc(); 
 delay_ms(100);                                                                                                            
V1=0.005*bilgi_1;                    
  v1=(v1*1000) ;                                                         
     if(v1>=1000)
     { v1=v1/1000;                                                         
    lcd_gotoxy(2,1);   
    printf(lcd_putc,"V=%1.3fV  ",v1-(float)d/1000); 
    r=(v1-(float)d)/a; 
  lcd_gotoxy(1,12);                                                                  
    printf(lcd_putc,"R=%1.2f ",r);                         
   }  
   else
     {                                                          
   lcd_gotoxy(2,1);                                                  
   printf(lcd_putc,"V=%1.1fmV ",v1-(float)d); 
   r=(v1-(float)d)/(a*1000);                             
  lcd_gotoxy(1,12);                                                 
    printf(lcd_putc,"R=%1.2f ",r);
   goto basla;
   }                    
                                                                           
goto basla;                                                             
                                                
 

                                           
}}   
                                                                


                                                       
                                       

                                                                 
                                               

#include<16f877A.h>
#fuses nowdt,xt
#use delay(clock=4000000)
int8 tus[5],h[5],i=0,t,k,sd,bekle,ark;
#int_ext 
   void tara()
   {
      disable_interrupts(int_ext); 
      set_tris_b(0xff);
      delay_cycles(100);
////////////////////////////////////// 
      output_low(pin_b1);      
      if(!input(pin_b4))
         t = 1;              
      if(!input(pin_b5)) 
         t = 4;                            
      if(!input(pin_b6))
         t = 7;      
      if(!input(pin_b7))       
         t = 10;                         
      output_high(pin_b1);
//////////////////////////////////////
      output_low(pin_b2);          
      if(!input(pin_b4))
         t = 2;                              
      if(!input(pin_b5))
         t = 5; 
      if(!input(pin_b6))
         t = 8;    
      if(!input(pin_b7))
         t = 0;
      output_high(pin_b2);                     
//////////////////////////////////////
      output_low(pin_b3);
      if(!input(pin_b4))
         t = 3;
      if(!input(pin_b5))                                      
         t = 6;                                                                                                
      if(!input(pin_b6))
         t = 9;    
      if(!input(pin_b7))
         t = 11;    
      output_high(pin_b3);
//////////////////////////////////////
      k = 1;
      for(ark=0;ark<255;++ark)
      {
      delay_cycles(255);        
      }
      i++;                      
      tus[i] = t;                                                
      set_tris_b(0xff);                   
   } 
void hata()
{
         disable_interrupts(int_ext);
         output_high(pin_d1);
         delay_ms(1000);           
         output_low(pin_d1);
         i = 0; 
         enable_interrupts(int_ext);
}
   
void main()                             
{                        
ext_int_edge(h_to_l); 
enable_interrupts(global);
enable_interrupts(int_ext);

   if(read_eeprom(0) != 0)
   {
      for(i=0;i<5;i++)
      { write_eeprom(i,i); }
   }                    
   for(i=1;i<5;++i)
   { h[i] = read_eeprom(i); }
 i = 0;
 sd = 0; 
 bekle = 0;
 set_tris_b(0xff);
 while(true)            
 {                       
   while(!k);                        
      disable_interrupts(int_ext);
      output_high(pin_d3);
      delay_ms(150);      
      output_low(pin_d3);
     
      
      // þifre doðru girildi ise //
      if(i == 5 && t == 11 && tus[1] == h[1] &&  tus[2] == h[2] && tus[3] == h[3] && tus[4] == h[4] )
      {
         disable_interrupts(int_ext);    
         output_high(pin_d0);
         delay_ms(5000);
         output_low(pin_d0);
         i = 0; 
         enable_interrupts(int_ext);
      }
      // þifre deðiþtirme onayý //
      else if(i == 5 && t == 10 && tus[1] == h[1] &&  tus[2] == h[2] && tus[3] == h[3] && tus[4] == h[4] ) 
      {                                                                                                    
         sd = 1;
         output_high(pin_d2);
         i = 0;
      }
      // þifre deðiþtirme //
      else if(i == 5 && t == 10 && sd == 1  ) 
      { 
         for(i=1;i<5;i++)
         {                                 
            write_eeprom(i,tus[i]); 
            h[i] = tus[i];
            delay_ms(5);  
         }
  
        output_low(pin_d2);           
        i = 0;           
      }
      // hatalý þifre girildi ise //   
      
      else if(i == 5 && (tus[1] != h[1] ||  tus[2] != h[2] || tus[3] != h[3] || tus[4] != h[4] )) 
      {
         hata(); 
            if(bekle++>2)       
            {                     
               disable_interrupts(int_ext);
                  for(i=0;i<50;i++)        
                  { 
                     output_toggle(pin_d1);
                     delay_ms(100);
                  } 
               output_low(pin_d1);                                 
               bekle = 0; 
               i = 0; 
            }                                
         enable_interrupts(int_ext);
      }
      else if(i > 5)
      {
         hata(); 
      } 
      else if(i<5 && (t == 10 || t == 11 ))
      {
         hata();
      }
      k = 0; 
       enable_interrupts(int_ext);
 }                    
}
                                                    

#include<16f877a.h>
#fuses nowdt,xt
#use delay(clock=4000000) 
#define k1 pin_b7
#define k2 pin_b2
#define k3 pin_d5  
#define k4 pin_c4
#define k5 pin_c1    
#define s1 pin_b6
#define s2 pin_b1                         
#define s3 pin_d4 
#define s4 pin_d3 
#define s5 pin_c2 
#define y1 pin_b5                
#define y2 pin_b0
#define y3 pin_c7                  
#define y4 pin_d2 
#define y5 pin_c3 
#define yk1 pin_b4
#define yk2 pin_d7 
#define yk3 pin_c6
#define yk4 pin_e2
#define yk5 pin_d1                
#define yy1 pin_b3 
#define yy2 pin_d6
#define yy3 pin_c5 
#define yy4 pin_c0 
#define yy5 pin_d0  


                                          

                                              


void main()
{
output_b(0);
output_c(0);
output_d(0);
output_low(pin_e2);  
   while(true)
   { 
      output_high(k1);
      output_high(k2);
      output_high(k3);
      output_high(k4);
      output_high(yk1);
      output_high(yk2);
      output_high(yk3);
      output_high(yk4);
      output_high(yk5);    
      output_high(y5);                            
      delay_ms(6000); 
      output_low(yk4);
      output_high(yy4);
      delay_ms(1500);
      output_low(yy4);
      output_high(yk4);
      delay_ms(1500);
      
      output_low(y5);
      output_high(s5);
      delay_ms(1000);
      output_low(s5);
      output_high(k5);
      output_high(s4);
      delay_ms(1000);
      output_low(s4);
      output_low(k4);
      output_high(y4);
      delay_ms(4000); 
      output_low(yk3);
      output_high(yy3);
      output_high(pin_e0);
         while(!input(pin_e1));
      output_low(pin_e0);
      //delay_ms(1500);
      output_low(yy3);
      output_high(yk3);
      delay_ms(1500);
                              
      output_low(y4);
      output_high(s4);
      delay_ms(1000);
      output_low(s4);                                                   
      output_high(k4);
      output_high(s3);
      delay_ms(1000);
      output_low(s3);
      output_low(k3);
      output_high(y3);   
      delay_ms(4000);
      output_low(yk2);
      output_high(yy2);
      delay_ms(1500);
      output_low(yy2);
      output_high(yk2);
      delay_ms(1500);
      
      output_low(y3);
      output_high(s3);
      delay_ms(1000);
      output_low(s3);
      output_high(k3);
      output_high(s2);                                                 
      delay_ms(1000);
      output_low(s2);
      output_low(k2);
      output_high(y2); 
      delay_ms(4000);
      output_low(yk1);
      output_high(yy1);
      delay_ms(1500);
      output_low(yy1);
      output_high(yk1);         
      delay_ms(1500);
      
      output_low(y2);
      output_high(s2);
      delay_ms(1000);
      output_low(s2);
      output_high(k2);
      output_high(s1);
      delay_ms(1000);
      output_low(s1);
      output_low(k1);                  
      output_high(y1);
      delay_ms(4000);
      output_low(yk5);
      output_high(yy5);     
      delay_ms(2000);
      output_low(yy5);
      output_high(yk5);
      delay_ms(2000);
      
                            
      output_low(y1);
      output_high(s1);
      delay_ms(1000);
      output_low(s1);     
      output_high(k1);
      output_high(s5);
      delay_ms(1000);
      output_low(s5);
      output_low(k5);
           
      
   }                          
   }

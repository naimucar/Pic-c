////////////////////////////////////////////////////////////////
// 4x20 lcd lerin 4 Mhz üstünde (max 16MHz) de çalýþmasý için //
// bu rutini kullanýn										  //
////////////////////////////////////////////////////////////////
#define LCD_DB4   PIN_B4 
#define LCD_DB5   PIN_B5 
#define LCD_DB6   PIN_B6 
#define LCD_DB7   PIN_B7 

#define LCD_E     PIN_B3 
#define LCD_RS    PIN_B2 
      

//======================================== 

#define lcd_type 2        // 0=5x7, 1=5x10, 2=2 lines 
#define lcd_line_two 0x40 // LCD RAM address for the 2nd line 
byte lcdline;

int8 const LCD_INIT_STRING[4] = 
{ 
 0x20 | (lcd_type << 2), // Func set: 4-bit, 2 lines, 5x8 dots 
 0xc,                    // Display on 
 1,                      // Clear display 
 6                       // Increment cursor 
 }; 
                              

//------------------------------------- 
void lcd_send_nibble(int8 nibble) 
{ 
// Note:  !! converts an integer expression 
// to a boolean (1 or 0). 
 output_bit(LCD_DB4, !!(nibble & 1)); 
 output_bit(LCD_DB5, !!(nibble & 2));  
 output_bit(LCD_DB6, !!(nibble & 4));    
 output_bit(LCD_DB7, !!(nibble & 8));    

 delay_cycles(10); 
 output_high(LCD_E); 
 delay_us(20); 
 output_low(LCD_E); 
} 
 
// Send a byte to the LCD. 
void lcd_send_byte(int8 address, int8 n) 
{ 
output_low(LCD_RS); 


if(address) 
   output_high(LCD_RS); 
else 
   output_low(LCD_RS); 
      
 delay_cycles(10); 


output_low(LCD_E); 

lcd_send_nibble(n >> 4); 
lcd_send_nibble(n & 0xf); 
} 

//---------------------------- 
void lcd_init(void) 
{ 
int8 i; 

output_low(LCD_RS); 
output_low(LCD_E); 
delay_ms(20); 
for(i=0 ;i < 3; i++) 
   { 
    lcd_send_nibble(0x03); 
    delay_ms(15); 
   } 

lcd_send_nibble(0x02); 

for(i=0; i < sizeof(LCD_INIT_STRING); i++) 
   { 
    lcd_send_byte(0, LCD_INIT_STRING[i]); 
    
   } 

} 

//---------------------------- 

void lcd_gotoxy( BYTE y, BYTE x) {
   BYTE address;

   switch(y) {
     case 1 : address=0x80;break;
     case 2 : address=0xc0;break;
     case 3 : address=0x94;break;
     case 4 : address=0xd4;break;
   }
   address+=x-1;
   lcd_send_byte(0,address);
} 

//----------------------------- 


void lcd_putc( char c) {
   switch (c) {
     case '\f'   : lcd_send_byte(0,1);
                   lcdline=1;
                   delay_ms(10);
                                           break;
     case '\n'   : lcd_gotoxy(1,++lcdline); break;
     case '\b'   : lcd_send_byte(0,0x10);  break;
     default     : lcd_send_byte(1,c);     break;
   }
}

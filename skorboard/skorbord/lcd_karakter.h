////////////////////////////////////////////////////////////////
// bu rutin lcd de harici karakter olusturmak için kullanýlýr //
// 8 hafýza adresinden birini secin ve ilgili komutlarý       // 
// 0 ýncý adreste itibaren yükleyin							  //
////////////////////////////////////////////////////////////////
void tr_karekter(int8 hafiza,int8 adres0, int8 adres1,
int8 adres2,int8 adres3,int8 adres4,int8 adres5,int8 adres6)
{
switch(hafiza)
{
case 0 : hafiza=0x40; break;
case 1 : hafiza=0x48; break;
case 2 : hafiza=0x50; break;
case 3 : hafiza=0x58; break;
case 4 : hafiza=0x60; break;
case 5 : hafiza=0x68; break;
case 6 : hafiza=0x70; break;
case 7 : hafiza=0x78; break;
}                                         
lcd_send_byte(0,hafiza);
lcd_putc(adres0);   
lcd_putc(adres1);     
lcd_putc(adres2);
lcd_putc(adres3);
lcd_putc(adres4);
lcd_putc(adres5);              
lcd_putc(adres6);
lcd_putc(0); 
}

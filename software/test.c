void _actual_start()
{
     volatile float a,b,c;
     a = 10.1;
     b = 1.565;
     c = a+b;
     c = c*c;
        
   // volatile char* tx = (volatile char*) 0x108;
   // const char* hello = "HI";
   // while (*hello) {
    //    *tx = *hello;
    //    hello++;
   // }

	volatile int *ptr  = (volatile int*)0x108;
	*ptr = (int)c;

     while(1);
}
  

void _actual_start()
{
     volatile float a,b,c;
     a = 10.1;
     b = 1.565;
     c = a+b;
     c = c*c/0;
        
 // volatile char* tx = (volatile char*) 0x108;
  //  const char* hello = "HI";
 //   while (*hello) {
   //    *tx = *hello;
   //    hello++;
    //}

	volatile float *ptr  = (volatile float*)0x108;
	*ptr =  c;

     while(1);
}
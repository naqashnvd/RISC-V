  

void _actual_start()
{
     //volatile float a,b,c;
	//volatile int d;
     //a = 10.1;
     //b = 1.565;
     //c = a+b;
     //c = c*b;
      // d = (int)c + '0'; 

 volatile char* tx = (volatile char*) 0x108;
  const char* hello = "HELLO WORLD";
   while (*hello) {
    *tx = *hello;
     hello++;
   }

//	volatile float *ptr  = (volatile float*)0x108;
//	*ptr =  c;

//	volatile char *ptr  = (volatile char*)0x108;
//	*ptr =  d;

     while(1);
}
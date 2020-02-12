void float_uart(float);
void string_uart(char*);
void _start()
{
	volatile float y[10]={0};
    volatile float x[10]={0};
    volatile float h[10]={0};
    
    volatile int m=5;
    volatile int n=5;
    volatile int lenC = m+n-1;
    volatile float x_in[5]={1.25,5.54,3.65,4.21,5.59};
    volatile float h_in[5]={10.24,5.64,9.0,1.4,5.5};
   
    //padding of zeors
    for(int i=0;i<=lenC;i++){
        if(i<m){
            x[i]=x_in[i];
        }else{
            x[i]=0;
            }
    }
    for(int j=0;j<=lenC;j++){
        if(j<n){
            h[j]=h_in[j];
        }else{
            h[j]=0;
            }
    }
    //convolution operation 
     for(int i=0;i<lenC;i++){          
        y[i]=0;
        for(int j=0;j<=i;j++){
            y[i]=y[i]+(x[j]*h[i-j]);
        }
    }
    //displaying the o/p
   for(int i=0;i<lenC;i++){
		float_uart(y[i]);
    }
    
    //End of transmission
    int EOT = 04;
    volatile int *ptr  = (volatile int*)0x108; 
	*ptr =  EOT;
   
     while(1);
}


void float_uart(float f){
	volatile int i ;
	 i = *(int *)&f;
	volatile int temp[4];
	for(int j=0;j<4;j++){
		temp[j] = (i >> 8*j) & 255;
	}	 
	for(int j=3;j>=0;j--){
		volatile int *ptr  = (volatile int*)0x108; 
		*ptr =  temp[j];
	}
}

void string_uart(char* str){
volatile char* tx = (volatile char*) 0x108;
  while (*str) {
  	*tx = *str;
  	str++;
  }
}

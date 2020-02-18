void float_uart(float);
void string_uart(char*);
int mod(int,int);
int divd(int,int);
void int_string(char str[], int num);

void _start()
{
	volatile float y[10]={0};
    volatile float x[10]={0};
    volatile float h[10]={0};
    
    volatile int m=5;
    volatile int n=5;
    volatile int lenC = m+n-1;
    volatile float x_in[5]={-5.24,53.6,8.251,-8.69,7.12};
    volatile float h_in[5]={0,1,2,3,-5};
   
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
    string_uart("Result:");
    //New Line
    int NL = 10;
    volatile int *ptr  = (volatile int*)0x108; 
	*ptr =  NL;
    //displaying the o/p
   for(int i=0;i<lenC;i++){
		float_uart(y[i]);
		*ptr =  NL; //New line
    }

    //End of transmission
    int EOT = 04;
    *ptr =  EOT;

     while(1);
}


void float_uart(float f){
    if(f < 0){
        string_uart("-");
        f = -f;
    }
	char str[5];
	int i1 = (int)f;
 	float f2 = (f - i1);
	if(f2 < 0){
		i1--;
		f2 = (f - i1);
	 }
	int i2 = (int)(f2 * 10);
	int_string(str,i1);
	if(str[0] == '\0'){
	    string_uart("0");
	}else{
	    string_uart(str);
	}
	string_uart(".");
	int_string(str,i2);
	if(str[0] == '\0'){
	    string_uart("0");
	}else{
	    string_uart(str);
	}
}

void string_uart(char* str){
volatile char* tx = (volatile char*) 0x108;
  while (*str) {
  	*tx = *str;
  	str++;
  }
}

int mod(int a,int b){ // a % b
    while (a>=b){
        a-=b;
    }
    return a;
}
int divd(int a,int b){ // a / b
    int count = 0;
    while (a>=b){
        a-=b;
        count++;
    }
    return count;
}
void int_string(char str[], int num){
    int i, rem, len = 0, n;
    n = num;
    while (n != 0)
    {
        len++;
        n = divd(n,10);
    }
    for (i = 0; i < len; i++)
    {
        rem = mod(num,10);
        num = divd(num,10);
        str[len - (i + 1)] = rem + '0';
    }
    str[len] = '\0';
}
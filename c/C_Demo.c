//typeof:
#include <stdio.h>

#define SUB_ABS(x,y) ({typeof(x)_x=x;typeof(y)_y=y;(_x)>(_y)?(_x)-(_y):(_y)-(_y);})

void main()
{
	int x=-6;
	int y=-9;
	int abs=SUB_ABS(++x,y);
	
	printf("++x和y之差的绝对为:%d\n",abs);
	
	return ;
}



//元素偏移
#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)


//异常堆栈信息输出
#include <stdio.h> 
#include <stdlib.h>
#include <execinfo.h>

#define MAX_LEVEL 10

void call_2()
{
 	int i = 0;
 	void* buffer[MAX_LEVEL] = {0}; 
 	int size=backtrace(buffer, MAX_LEVEL); 
 	char **strings = backtrace_symbols (buffer, size);
     	printf ("Obtained %zd stack frames.\n", size);
     	for (i = 0; i < size; i++)
	     	printf ("%s\n", strings[i]);
	free(strings);

 	return;
}

int main(int argc, char* argv[])
{
 	call_2(); 

 	return 0;
}


//backtrace 指针实现
int backtrace(void** buffer, int size)
{
	int  n ;
	int* p = &n;
	int  i = 0; 

	int ebp = *(p+5);
	int eip = *(p+6); 

	for(i = 0; i < size; i++)
	{
		buffer[i] = (void*)eip;
		p = (int*)ebp;
		ebp = *p;
		eip = *(p+1);
	} 

	return size;
}


//setjmp
#include <stdio.h>   
#include <setjmp.h>   
  
int main()  
{  
      
    double a,b;  
  
    printf("请输入被除数：");  
    scanf("%lf",&a);  
    printf("请输入除数：");  
  
    if(setjmp(buf)==0)  
    {  
        scanf("%lf",&b);  
        if(0==b)  
			longjmp(buf,1);    
        printf("相除的结果为：%f\n",a/b);  
    }  
    else  
        printf("出现错误除数为0\n");  
  
    return 0;  
}  

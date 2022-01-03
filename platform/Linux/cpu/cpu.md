# CPU

### affinity

在Linux系统中能够将一个或多个进程绑定到一个或多个处理器上运行
线程绑定 CPU 核 _sched_setaffinity

一个CPU的亲合力掩码用一个 cpu_set_t 结构体来表示一个 CPU 集合,下面的几个宏分别对这个掩码集进行操作:
	CPU_ZERO() 清空一个集合
	CPU_SET() 与 CPU_CLR() 分别对将一个给定的CPU号加到一个集合或者从一个集合中去掉
	CPU_ISSET() 检查一个 CPU 号是否在这个集合中

下面两个函数就是用来设置获取线程 CPU 亲和力状态: 
	sched_setaffinity(pid_t pid, unsigned int cpusetsize, cpu_set_t *mask) 
    该函数设置进程为pid的这个进程，让它运行在mask所设定的CPU上。如果pid的值为0，则表示指定的是当前进程，使当前进程运行在mask所设定的那些CPU上。第二个参数cpusetsize是mask所指定的数的长度。通常设定为 sizeof(cpu_set_t)。如果当前pid所指定的进程此时没有运行在mask所指定的任意一个CPU上，则该指定的进程会从其它CPU上迁移到mask的指定的一个CPU上运行。
	sched_getaffinity(pid_t pid, unsigned int cpusetsize, cpu_set_t *mask) 
    该函数获得 pid 所指示的进程的 CPU 位掩码，并将该掩码返回到 mask 所指向的结构中。即获得指定pid当前可以运行在哪些CPU上。同样，如果pid的值为0。也表示的是当前进程

```c
num = sysconf(_SC_NPROCESSORS_CONF);  //获取核数
cpu_set_t mask;  //CPU核的集合
cpu_set_t get;   //获取在集合中的CPU
int *a = (int *)arg; 
printf("the a is:%d\n",*a);  //显示是第几个线程
CPU_ZERO(&mask);    //置空
CPU_SET(*a,&mask);   //设置亲和力值
if (sched_setaffinity(0, sizeof(mask), &mask) == -1)//设置线程CPU亲和力
if (sched_getaffinity(0, sizeof(get), &get) == -1)//获取线程CPU亲和力
if (CPU_ISSET(i, &get))//判断线程与哪个CPU有亲和力
```
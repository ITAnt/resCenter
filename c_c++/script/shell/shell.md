**shell脚本中的特殊变量**

**1. $# 传递到脚本的参数个数**

**2. $\* 以一个单字符串显示所有向脚本传递的参数。与位置变量不同，此选项参数可超过9个3. $$ 脚本运行的当前进程ID号4. $! 后台运行的最后一个进程的进程ID号5. $@ 与$#相同，但是使用时加引号，并在引号中返回每个参数6. $- 显示shell使用的当前选项，与set命令功能相同**

|             |                                            |
| :---------- | :----------------------------------------- |
| **$0**      | **脚本名字**                               |
| **$1**      | **位置参数 #1**                            |
| **$2 - $9** | **位置参数 #2 - #9**                       |
| **${10}**   | **位置参数 #10**                           |
| **$#**      | **位置参数的个数**                         |
| **"$\*"**   | **所有的位置参数(作为单个字符串) \***      |
| **"$@"**    | **所有的位置参数(每个都作为独立的字符串)** |
| **${#\*}**  | **传递到脚本中的命令行参数的个数**         |
| **${#@}**   | **传递到脚本中的命令行参数的个数**         |
| **$?**      | **返回值**                                 |
| **$$**      | **脚本的进程ID(PID)**                      |
| **$-**      | **传递到脚本中的标志(使用set)**            |
| **$_**      | **之前命令的最后一个参数**                 |
| **$!**      | **运行在后台的最后一个作业的进程ID(PID)**  |
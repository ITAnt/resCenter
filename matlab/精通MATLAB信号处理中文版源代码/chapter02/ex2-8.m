clear
n=0:50;
A=3;a=-1/9;b=pi/5;
x=A*exp((a+i*b)*n);
subplot(2,2,1)
stem(n,real(x),'fill');
grid on
title('ʵ��');
axis([0,30,-2,2]),xlabel('n')
subplot(2,2,2)
stem(n,imag(x),'fill');
grid on
title('�鲿');
axis([0,30,-2,2]) ,xlabel('n')
subplot(2,2,3)
stem(n,abs(x),'fill'),grid on
title('ģ'),axis([0,30,0,2]) ,xlabel('n')
subplot(2,2,4)
stem(n,angle(x),'fill');
grid on
title('���');
axis([0,30,-4,4]) ,xlabel('n')

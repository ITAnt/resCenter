clc;
N=32;
x_delta=zeros(1,N);
x_delta(1)=1;
p=[1,-1,0]
d=[1,0.75,0.125];
h1_delta=filter(p,d,x_delta);
subplot(211);
stem(0:N-1,h1_delta,'r');hold off;
xlabel('����1�ĵ�λ������Ӧ');
x_unit=ones(1,N);
h1_unit=filter(p,d,x_unit);
subplot(212);
stem(0:N-1,h1_unit,'r');hold off;
xlabel('����1�Ľ�Ծ��Ӧ');

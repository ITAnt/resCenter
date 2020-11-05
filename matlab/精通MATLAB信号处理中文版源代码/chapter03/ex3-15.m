clear all;
fs=200;          %����Ƶ��
N=128;            %���ݸ���
n=0:N-1;
t=n/fs;          %���ݶ�Ӧ��ʱ������
x=0.5*sin(2*pi*20*t)+2*sin(2*pi*60*t);       %ʱ�����ź�
subplot(2,2,1);plot(t,x);
xlabel('ʱ��/s');ylabel('x');
title('ԭʼ�ź�');
grid on;

y=fft(x,N);   %����Ҷ�任
mag=abs(y);   %�õ������
f=n*fs/N;     %Ƶ������
subplot(2,2,2);plot(f(1:N/2),mag(1:N/2)*2/N);
xlabel('Ƶ��/Hz');ylabel('���');
title('ԭʼ�źŵ�FFT');
grid on;

xifft=ifft(y);      %���и���Ҷ��任
realx=real(xifft);   %��ȡ����Ҷ��任��ʵ��
ti=[0:length(xifft)-1]/fs;  %����Ҷ��任��ʱ������
subplot(2,2,3);plot(ti,realx);
xlabel('ʱ��/s');ylabel('x');
title('���ø���Ҷ��任�õ����ź�');
grid on;

yif=fft(xifft,N);   %������Ҷ��任�õ���ʱ�����źŽ��и���Ҷ�任
mag=abs(yif);
f=[0:length(y)-1]'*fs/length(y);    %Ƶ������
subplot(2,2,4);plot(f(1:N/2),mag(1:N/2)*2/N);
xlabel('Ƶ��/Hz');ylabel('���');
title('����IFFT�õ��źŵĿ��ٸ���Ҷ�任');
grid on;

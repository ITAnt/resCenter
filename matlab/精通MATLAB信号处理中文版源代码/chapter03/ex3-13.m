clear all;
fs=100;          %����Ƶ��
Ndata=32;        %���ݳ���
N=32;            %FFT�����ݳ���
n=0:Ndata-1;
t=n/fs;          %���ݶ�Ӧ��ʱ������
x=0.5*sin(2*pi*20*t)+2*sin(2*pi*60*t);       %ʱ�����ź�
y=fft(x,N);        %�źŵĸ���Ҷ�任
mag=abs(y);        %��ȡ���
f=(0:N-1)*fs/N;    %��ʵƵ��
subplot(2,2,1);plot(f(1:N/2),mag(1:N/2)*2/N);
xlabel('Ƶ��/Hz');ylabel('���');
title('Ndata=32; FFT���Բɵ����=32');
grid on;

Ndata=32;        %���ݳ���
N=128;           %FFT���õ����ݳ���
n=0:Ndata-1;
t=n/fs;          %ʱ������
x=0.5*sin(2*pi*20*t)+2*sin(2*pi*60*t);       %ʱ�����ź�
y=fft(x,N);
mag=abs(y);
f=(0:N-1)*fs/N;    %��ʵƵ��
subplot(2,2,2);plot(f(1:N/2),mag(1:N/2)*2/N);
xlabel('Ƶ��/Hz');ylabel('���');
title('Ndata=32; FFT���Բɵ����=128');
grid on;

Ndata=136;        %���ݳ���
N=128;           %FFT���õ����ݳ���
n=0:Ndata-1;
t=n/fs;          %ʱ������
x=0.5*sin(2*pi*20*t)+2*sin(2*pi*60*t);       %ʱ�����ź�
y=fft(x,N);
mag=abs(y);
f=(0:N-1)*fs/N;    %��ʵƵ��
subplot(2,2,3);plot(f(1:N/2),mag(1:N/2)*2/N);
xlabel('Ƶ��/Hz');ylabel('���');
title('Ndata=136; FFT���Բɵ����=128');
grid on;

Ndata=136;        %���ݳ���
N=512;           %FFT���õ����ݳ���
n=0:Ndata-1;
t=n/fs;          %ʱ������
x=0.5*sin(2*pi*20*t)+2*sin(2*pi*60*t);       %ʱ�����ź�
y=fft(x,N);
mag=abs(y);
f=(0:N-1)*fs/N;    %��ʵƵ��
subplot(2,2,4);plot(f(1:N/2),mag(1:N/2)*2/N);
xlabel('Ƶ��/Hz');ylabel('���');
title('Ndata=136; FFT���Բɵ����=512');
grid on;

fs=22050;
[x,fs,bits]=wavread('qq.wav');
%sound(x)
t=0:(size(x)-1);
x2=rand(1,length(x))';   %����һ��x����һ�µ�����ź�   
y=x+x2;
%������������
t=0:(n-1);	
Au=0.03;
d=[Au*sin(2*pi*500*t)]';
y=x+d;
wp=0.25*pi;
ws=0.3*pi;
wdelta=ws-wp;
N=ceil(6.6*pi/wdelta);              %ȡ��
wn=(0.2+0.3)*pi/2;
b=fir1(N,wn/pi,hamming(N+1));       %ѡ�񴰺���������һ����ֹƵ��
figure(1)
freqz(b,1,512)
f2=filter(bz,az,y)
figure(2)
subplot(2,1,1)
plot(t,y)
title('�˲�ǰ��ʱ����');
subplot(2,1,2)
plot(t,f2);
title('�˲����ʱ����');
sound(f2);                    %�����˲���������ź�
F0=fft(f1,1024);
f=fs*(0:511)/1024;
figure(3)
y2=fft(y,1024);
subplot(2,1,1);
plot(f,abs(y2(1:512)));             %�����˲�ǰ��Ƶ��ͼ
title('�˲�ǰ��Ƶ��')
xlabel('Ƶ��');
ylabel('��ֵ');
subplot(2,1,2)
F1=plot(f,abs(F0(1:512)));          %�����˲����Ƶ��ͼ
title('�˲����Ƶ��')
xlabel('Hz');
ylabel('��ֵ');

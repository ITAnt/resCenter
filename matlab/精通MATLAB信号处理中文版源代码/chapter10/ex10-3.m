clear
fs=22050;                  %�����źŲ���Ƶ��Ϊ22050
[x,fs,bits]=wavread('qq.wav');  
sound(x,fs,bits);           %���������ź�
y1=fft(x,1024);           %���ź���1024��FFT�任
f=fs*(0:511)/1024;
figure(1)
plot(x)                   %��ԭʼ�����źŵ�ʱ����ͼ
title('ԭʼ�����ź�ʱ��ͼ');
xlabel('ʱ��');
ylabel('��ֵ');
figure(2)
freqz(x)                  %����ԭʼ�����źŵ�Ƶ����Ӧͼ
title('Ƶ����Ӧͼ')
figure(3)
plot(f,abs(y1(1:512)));
title('ԭʼ�����ź�Ƶ��')
xlabel('Ƶ��');
ylabel('����');

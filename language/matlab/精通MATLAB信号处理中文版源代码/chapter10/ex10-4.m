fs=22050;                  %�����źŲ���Ƶ��Ϊ22050
[x,fs,bits]=wavread('qq.wav'); %��ȡ�����źŵ����ݣ���������x
%sound(x)
%t=0:1/22050:(size(x)-1)/22050;
y1=fft(x,1024);           %���ź���1024��FFT�任
f=fs*(0:511)/1024;
x1=rand(1,length(x))';   %����һ��x����һ�µ�����ź�  
x2=x1+x;
%t=0:(size(x)-1);        %������������
%Au=0.3;
%d=[Au*sin(6*pi*5000*t)]';
%x2=x+d; 
sound(x2);
figure(1)
subplot(2,1,1)
plot(x)                   %��ԭʼ�����źŵ�ʱ��ͼ��
title('ԭ�����ź�ʱ��ͼ')
subplot(2,1,2)
plot(x2)                   %��ԭʼ�����źŵ�ʱ��ͼ��
title('�Ӹ�˹�����������ź�ʱ��ͼ')
xlabel('ʱ��');
ylabel('����');
y2=fft(x2,1024);
figure(2)
subplot(2,1,1)
plot(abs(y1))
title('ԭʼ�����ź�Ƶ��');
xlabel('Hz');
ylabel('fudu');
subplot(2,1,2)
plot(abs(y2))
title('���������ź�Ƶ��');
xlabel('Ƶ��');
ylabel('����');

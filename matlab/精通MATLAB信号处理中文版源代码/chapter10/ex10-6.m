Ft=8000;
Fp=1000;
Fs=1200;
wp=2*pi*Fp/Ft;
ws=2*pi*Fs/Ft;
fp=2*Ft*tan(wp/2);
fs=2*Fs*tan(wp/2);
[n11,wn11]=buttord(wp,ws,1,50,'s'); %���ͨ�˲����Ľ����ͽ�ֹƵ��
[b11,a11]=butter(n11,wn11,'s');    %��S���Ƶ����Ӧ�Ĳ��� 
[num11,den11]=bilinear(b11,a11,0.5); %����˫���Ա任ʵ��Ƶ����ӦS��Z��ı任 
[x,fs,nbits]=wavread ('qq.wav');
n = length (x) ;         %��������źŵĳ���
t=0:(n-1);
x2=rand(1,length(x))';   %����һ��x����һ�µ�����ź�   
y=x+x2;
%������������
%t=0:(size(x)-1);
%Au=0.03;
%d=[Au*sin(2*pi*500*t)]';
%y=x+d;
figure(1)
f2=filter(num11,den11,y)
subplot(2,1,1)
plot(t,y)
title('�˲�ǰ�ļӸ�˹����ʱ����');
subplot(2,1,2)
plot(t,f2);                         %�����˲����ʱ��ͼ
title('�˲����ʱ����');
sound(f1);                    %�����˲�����ź�
F0=fft(f1,1024);
f=fs*(0:511)/1024;
figure(2)
y2=fft(y,1024);
subplot(2,1,1);
plot(f,abs(y2(1:512)));             %�����˲�ǰ��Ƶ��ͼ
title('�˲�ǰ�Ӹ�˹������Ƶ��')
xlabel('Ƶ��');
ylabel('��ֵ');
subplot(2,1,2)
F1=plot(f,abs(F0(1:512)));          %�����˲����Ƶ��ͼ
title('�˲����Ƶ��')
xlabel('Hz');
ylabel('��ֵ');

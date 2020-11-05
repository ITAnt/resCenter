[x,fs,bits]=wavread('qq.wav');
%sound(x)
%��������ϳ�
x2=rand(1,length(x))';   %����һ��x����һ�µ�����ź�   
y=x+x2;
%������������
%t=0:(size(x)-1);
%Au=0.3;
%d=[Au*sin(2*pi*500*t)]';
%y=x+d;
wp=0.1*pi;
ws=0.4*pi;
Rp=1;
Rs=15;
Fs=22050;
Ts=1/Fs;
wp1=2/Ts*tan(wp/2);                 %��ģ��ָ��ת��������ָ��
ws1=2/Ts*tan(ws/2); 
[N,Wn]=buttord(wp1,ws1,Rp,Rs,'s');  %ѡ���˲�������С����
[Z,P,K]=buttap(N);                  %����butterworthģ���˲���
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2lp(Bap,Aap,Wn);   
[bz,az]=bilinear(b,a,Fs);      %��˫���Ա任��ʵ��ģ���˲����������˲�����ת��
[H,W]=freqz(bz,az);                 %����Ƶ����Ӧ����
figure(1)
plot(W*Fs/(2*pi),abs(H))
grid
f1=filter(bz,az,y);
figure(2)
subplot(2,1,1)
plot(y)                          %�����˲�ǰ��ʱ��ͼ
title('�˲�ǰ��ʱ����');
subplot(2,1,2)
plot(f1);                         %�����˲����ʱ��ͼ
title('�˲����ʱ����');
sound(f1);                    %�����˲�����ź�
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
xlabel('Ƶ��');
ylabel('��ֵ');

clear all;
Nwin=20;     % ��������
n=0:Nwin-1;  % �����������
w=bartlett(Nwin); 
subplot(131);stem(n,w);  %���������
xlabel('n');ylabel('w(n)');
grid on;
Nf=512;  %����������Ƶ�����Ե����ݵ���
Nwin=20;     % ���������ݳ���
[y,f]=freqz(w,1,Nf);
mag=abs(y);  %��ô�������Ƶ����
w=bartlett(Nwin); 
subplot(132);plot(f/pi,20*log10(mag/max(mag)));  %���ƴ������ķ�Ƶ����
xlabel('��һ��Ƶ��');ylabel('���/dB');
grid on;
w=blackman(Nwin);
[y,f]=freqz(w,1,Nf);
mag=abs(y);  %��ô�������Ƶ����
subplot(133);plot(f/pi,20*log10(mag/max(mag)));  %���ƴ������ķ�Ƶ����
xlabel('��һ��Ƶ��');ylabel('���/dB');
grid on;

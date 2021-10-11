clear all;
wp=2000*2*pi;  
ws=3000*2*pi;   %�˲�����ֹƵ��
Rp=3;      
Rs=15;   %ͨ�����ƺ����˥��
Fs=9000;           %����Ƶ��
Nn=256;              %����freqz���õ�Ƶ�ʵ���
[N,wn]=buttord(wp,ws,Rp,Rs,'s');       %ģ���˲�������С����
[z,p,k]=buttap(N);    %���ģ���ͨԭ��Butterworth�˲���
[Bap,Aap]=zp2tf(z,p,k);   %����㼫��������ʽת��Ϊ���ݺ�����ʽ
[b,a]=lp2lp(Bap,Aap,wn);  %����Ƶ��ת��
[bz,az]=impinvar(b,a,Fs);
% ����������Ӧ���䷨�õ������˲����Ĵ��ݺ���
figure;
[h,f]=freqz(bz,az,Nn,Fs);        %���������˲����ķ�Ƶ���Ժ���Ƶ����
subplot(221);
 plot(f,20*log10(abs(h)));
xlabel('Ƶ��/Hz');  
ylabel('���/dB');
grid on;
subplot(222);
plot(f,180/pi*unwrap(angle(h)));
xlabel('Ƶ��/Hz');  
ylabel('��λ/^o');
grid on;
f1=1000;  f2=2000;   %�����źŵ�Ƶ��
N=100;    %���ݳ���
dt=1/Fs;  n=0:N-1;  %����ʱ����
t=n*dt;   %ʱ������
x=tan(2*pi*f1*t)+0.5*sin(2*pi*f2*t);  %�˲��������ź�
subplot(223);plot(t,x);
title('�����ź�');   %���������ź�
y=filtfilt(bz,az,x);  %�ú���filtfilt�������źŽ����˲�
y1=filter(bz,az,x);   %��filter�����������źŽ����˲�
subplot(224);plot(t,y,t,y1,':');
title('����ź�'); xlabel('ʱ��/s');
legend('filtfilt����','filter����');  

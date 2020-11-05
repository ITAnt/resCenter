T=1;								%���ò�������Ϊ1
fs=1/T;							%����Ƶ��Ϊ���ڵ���
wp=[0.30*pi,0.75*pi];
ws=[0.35*pi,0.65*pi];
 Wp=(2/T)*tan(wp/2);  
Ws=(2/T)*tan(ws/2);				%���ù�һ��ͨ���������ֹƵ��
Ap=20*log10(1/0.8);
As=20*log10(1/0.18);
%����ͨ��������С˥��   
[N,Wc]=buttord(Wp,Ws,Ap,As,'s');
%����butter����ȷ��������˹�˲�������
[B,A]=butter(N,Wc, 'stop','s');
%����butter������ư�����˹�˲���
W=linspace(0,2*pi,400*pi);
%ָ��һ��Ƶ��ֵ 
hf=freqs(B,A,W);
%����ģ���˲����ķ�Ƶ��Ӧ
subplot(121);
plot(W/pi,abs(hf));
%���������˹ģ���˲����ķ�Ƶ�������� 
grid on;
title('������˹ģ���˲���');
xlabel('Frequency/Hz');
ylabel('Magnitude');
[D,C]=bilinear(B,A,fs);
%����˫���Ա任�� 
Hz=freqz(D,C,W);
%����Ƶ����Ӧ
subplot(122);
plot(W/pi,abs(Hz));
%���������˹���ִ����˲����ķ�Ƶ��������
grid on;
title('������˹�����˲���');
xlabel('Frequency/Hz');
ylabel('Magnitude');

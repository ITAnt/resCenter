T=2;							%���ò�������Ϊ2
fs=1/T;						%����Ƶ��Ϊ���ڵ���
Wp=0.30*pi/T; 
Ws=0.35*pi/T;					%���ù�һ��ͨ���������ֹƵ��
Ap=20*log10(1/0.8);
As=20*log10(1/0.18);			%����ͨ��������С˥��   
[N,Wc]=buttord(Wp,Ws,Ap,As,'s');
%����butter����ȷ��������˹�˲�������
[B,A]=butter(N,Wc,'s');
%����butter������ư�����˹�˲���
W=linspace(0,pi,400*pi);		%ָ��һ��Ƶ��ֵ 
hf=freqs(B,A,W);
%����ģ���˲����ķ�Ƶ��Ӧ 
subplot(121);
plot(W/pi,abs(hf)/abs(hf(1)));
%���������˹ģ���˲����ķ�Ƶ�������� 
grid on;
title('������˹ģ���˲���');
xlabel('Frequency/Hz');
ylabel('Magnitude');
[D,C]=impinvar(B,A,fs);
%����������Ӧ���䷨
Hz=freqz(D,C,W);
%����Ƶ����Ӧ 
subplot(122);
plot(W/pi,abs(Hz)/abs(Hz(1)));
%���������˹���ֵ�ͨ�˲����ķ�Ƶ�������� 
grid on;
title('������˹�����˲���');
xlabel('Frequency/Hz');
ylabel('Magnitude');

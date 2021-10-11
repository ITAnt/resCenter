%�����źŹ����׹��ƺ�����غ���
a=[2 0.3 0.2 0.5 0.2 0.4 0.6 0.2 0.2 0.5 0.3 0.2 0.6]; 
%�����ź�
t=0:0.001:0.4;
y=sin(2*pi*t*30)+cos(0.35*pi*t*30)+randn(size(t));
%��������������ź�
x=filter(1,a,y);
%����ͼ���ƣ�512��FFT
subplot(221);
periodogram(x,[],512,1000);
axis([0 500 -50 0]);
xlabel('Ƶ��/HZ');
ylabel('������/dB');
title('����ͼ�����׹���');
grid on;
%welch�����׹���
subplot(222);
pwelch(x,128,64,[],1000);
axis([0 500 -50 0]);
xlabel('Ƶ��/HZ');
ylabel('������/dB');
title('welch�����׹���');
grid on;
subplot(212);
R=xcorr(x);
plot(R);
axis([0 600 -500 500]);
xlabel('ʱ��/t');
ylabel('R(t)/dB');
title('x������غ���');
grid on;

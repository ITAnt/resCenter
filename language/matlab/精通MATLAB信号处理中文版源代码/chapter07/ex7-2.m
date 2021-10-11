clear all;
N=1200; Fs=600;         %���ݳ��ȺͲ���Ƶ��
n=0:N-1; t=n/Fs;        %ʱ������
Lag=100;                %�ӳ�������
randn('state',0);       %���ò���������ĳ�ʼ״̬
x=cos(2*pi*10*t)+0.7*randn(1,length(t));  %ԭʼ�ź�
[c,lags]=xcorr(x,Lag,'unbiased');  %��ԭʼ�źŽ�����ƫ����ع���
subplot(2,2,1); plot(t,x);       %����ԭʼ�ź�x
xlabel('ʱ��/s'); ylabel('x(t)'); 
title('�����������ź�');
grid on;
subplot(2,2,2);plot(lags/Fs,c);   %����x�ź������,lags/FsΪʱ������
xlabel('ʱ��/s'); ylabel('Rx(t)');
title('�����������źŵ������');
grid on;
% �ź�x1
x1=randn(1,length(x));        %����һ��x����һ�µ�����ź�
[c,lags]=xcorr(x1,Lag,'unbiased');  %������ź�x1����ƫ�����
subplot(2,2,3); plot(t,x1);  %��������ź�x1
xlabel('ʱ��/s'); ylabel('x1(t)');
title('�����ź�');
grid on;
subplot(2,2,4); plot(lags/Fs,c);     %��������ź�x1����ƫ�����
xlabel('ʱ��/s'); ylabel('Rx1(t)');
title('�����źŵ������');
grid on

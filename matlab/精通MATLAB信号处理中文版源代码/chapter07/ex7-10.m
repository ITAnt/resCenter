clear all;
randn('state',0 );       %���������ĳ�ʼ״̬
Fs = 2000;              %����Ƶ��
t = 0:1/Fs:.3;          %ʱ������
% �����ź�
x = sin(2*pi*t*200) + randn(size(t));   
pwelch(x,33,32,[],Fs,'twosided');
xlabel('Ƶ��/Hz');
title('����pwelch����ʵ�ֹ����׹���');

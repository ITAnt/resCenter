clear all;
a = [1 -1.2357 2.9504 -3.1607 0.9106];  % ARģ��
% ARģ��Ƶ����Ӧ
randn('state',1);
x = filter(1,a,randn(256,1));    % ���ARģ��
pyulear(x,4) ;
xlabel('Ƶ��/Hz');ylabel('��Թ������ܶ�(dB/Hz)');
title('��Yule-Walker AR�������׹���');
grid on

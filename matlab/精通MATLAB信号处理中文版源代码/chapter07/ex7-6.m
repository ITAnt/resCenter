clear all;
randn('state',0);
Fs = 2000;   
t = 0:1/Fs:.3;
x = sin(2*pi*t*200)+0.1*randn(size(t)); 
periodogram(x,[],'twosided',512,Fs);
xlabel('Ƶ��/kHz');
ylabel('��Թ������ܶ�(dB/Hz)');
title('����ͼ��');

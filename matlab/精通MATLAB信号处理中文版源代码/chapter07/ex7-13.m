clear all;
randn('state',0);
fs = 2000; 
t = 0:1/fs:0.4;
x = sin(2*pi*t*200) + 0.1*randn(size(t));
[Pxx,Pxxc,f] = pmtm(x,3.5,512,fs,0.99);
hpsd = dspdata.psd([Pxx Pxxc],'Fs',fs);
plot(hpsd)
xlabel('Ƶ��/Hz');ylabel('��Թ������ܶ�(dB/Hz)');
title('MTM������');
grid on;

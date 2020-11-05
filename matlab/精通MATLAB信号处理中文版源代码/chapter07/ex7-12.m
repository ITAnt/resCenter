clear all;
Fs=1000;          %����Ƶ��
NFFT=1024;
t=0:1/Fs:1;       %ʱ������
x=sin(2*pi*100*t)+sin(2*pi*200*t)+sin(2*pi*400*t)+randn(size(t));  %�ź�
window1=boxcar(100);
window2=hamming(100);
noverlap=20;         %ָ�������֮����ص���������
[pxx1,f1]=pwelch(x,window1,noverlap,NFFT,Fs);
[pxx2,f2]=pwelch(x,window2,noverlap,NFFT,Fs);
pxx1=10*log10(pxx1);
pxx2=10*log10(pxx2);
subplot(211);plot(f1,pxx1);
title('���δ�');
subplot(212);plot(f2,pxx2);
title('������');

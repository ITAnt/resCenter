clear all;
Fs=2000;             %Ƶ��
t=0:1/Fs:1-1/Fs;     %ʱ������
x=5*sin(2*pi*200*t)+5*cos(2*pi*202*t)+randn(1,length(t));
NFFT=1024;
p=40;
pxx=pmusic(x,p,NFFT,Fs);    %MUSIC����
k=0:floor(NFFT/2-1);
figure;
subplot(211);plot(k*Fs/NFFT,10*log10(pxx(k+1)));
xlabel('Ƶ��/Hz');ylabel('��Թ������ܶ�(dB/Hz)');
title('MUSIC���׹���');
pxx1=peig(x,p,NFFT,Fs);   %������������
k=0:floor(NFFT/2-1);
subplot(212);plot(k*Fs/NFFT,10*log10(pxx1(k+1)));
xlabel('Ƶ��/Hz');ylabel('��Թ������ܶ�(dB/Hz)');
title('�����������׹���');

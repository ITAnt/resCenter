clf;
Fs=2000;
N=1024;Nfft=256;n=0:N-1;t=n/Fs;
randn('state',0);
xn=cos(2*pi*50*t)+2*sin(2*pi*120*t)+randn(1,N);
[Pxx1,f]=pmtm(xn,4,Nfft,Fs);
%�˴������� 
subplot(121),plot(f,10*log10(Pxx1));
xlabel('Ƶ��/Hz');ylabel('������/dB');
title('�ര�ڷ���MTM��NW=4');
grid on;
[Pxx,f]=pmtm(xn,2,Nfft,Fs);
subplot(122),plot(f,10*log10(Pxx));
xlabel('Ƶ��/Hz');ylabel('������/dB');
title('�ര�ڷ���MTM��NW=2');
grid on;

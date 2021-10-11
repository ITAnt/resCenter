clc;clear all;close all;
T=0.48;ts=0.001;
fc=300;fm=200;
fm1=150;fs=1/ts;
t=[0:ts:T];
m=2*cos(2*pi*fm*t)+cos(2*pi*fm1*t);
m_n=m/max(abs(m));
Lssb=m_n.*cos(2*pi*fc*t)+imag(hilbert(m_n)).*sin(2*pi*fc*t);
Ussb=m_n.*cos(2*pi*fc*t)-imag(hilbert(m_n)).*sin(2*pi*fc*t);
f=(1:1024).*fs/1024;
Lssb_spec=abs(fft(Lssb,1024));
Ussb_spec=abs(fft(Ussb,1024));
subplot(121);
plot(f,Lssb_spec);
title('�±ߴ��ź�Ƶ��');
xlabel('f/Hz');
ylabel('Lssb(f)');
subplot(122);
plot(f,Ussb_spec);
title('�ϱߴ��ź�Ƶ��');
xlabel('f/Hz');
ylabel('Ussb(f)');

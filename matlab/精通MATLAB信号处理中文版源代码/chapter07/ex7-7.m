clf;
Fs=2000;
N=512;Nfft=512;
%���ݵĳ��Ⱥ�FFT���õ����ݳ���
n=0:N-1;t=n/Fs;
%���õ�ʱ������
xn=sin(2*pi*50*t)+2*sin(2*pi*120*t)+randn(1,N);
Pxx=10*log10(abs(fft(xn,Nfft).^2)/N);
%Fourier�����ƽ����ƽ��ֵ����ת��ΪdB
f=(0:length(Pxx)-1)*Fs/length(Pxx);
%����Ƶ������
subplot(2,1,1),plot(f,Pxx);
%���ƹ���������
xlabel('Ƶ��/Hz');ylabel('������/dB');
title('����ͼ N=512');
grid on;
Fs=1000;
N=1024;Nfft=1024;
%���ݵĳ��Ⱥ�FFT���õ����ݳ���
n=0:N-1;t=n/Fs;
%���õ�ʱ������
xn=sin(2*pi*50*t)+2*sin(2*pi*120*t)+randn(1,N);
Pxx=10*log10(abs(fft(xn,Nfft).^2)/N);
%Fourier�����ƽ����ƽ��ֵ����ת��ΪdB
f=(0:length(Pxx)-1)*Fs/length(Pxx);
%����Ƶ������
subplot(2,1,2),plot(f,Pxx);
%���ƹ���������
xlabel('Ƶ��/Hz');ylabel('������/dB');
title('����ͼ N=1024');
grid on;

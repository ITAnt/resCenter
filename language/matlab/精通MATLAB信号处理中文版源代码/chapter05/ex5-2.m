function [C,B,A] = dir2fs(h)
% ֱ���͵�Ƶ�ʲ����͵�ת��
% [C,B,A] = dir2fs(h)
% C = ���������в��������������
% B = �����������еķ���ϵ������
% A = �����������еķ�ĸϵ������
% h =  FIR�˲�����������Ӧ����
M = length(h);
H = fft(h,M);
magH = abs(H); phaH = angle(H)';
% check even or odd M
if (M == 2*floor(M/2))
      L = M/2-1;   %  MΪż�� 
     A1 = [1,-1,0;1,1,0];
     C1 = [real(H(1)),real(H(L+2))];
 else
      L = (M-1)/2; % M is odd
     A1 = [1,-1,0];
     C1 = [real(H(1))];
 end
k = [1:L]';
% ��ʼ�� B �� A ����
B = zeros(L,2); A = ones(L,3);
% �����ĸϵ��
A(1:L,2) = -2*cos(2*pi*k/M); A = [A;A1];
% �������ϵ��
B(1:L,1) = cos(phaH(2:L+1));
B(1:L,2) = -cos(phaH(2:L+1)-(2*pi*k/M));
% ��������ϵ��
C = [2*magH(2:L+1),C1]';
close all;
clear;
N=30;
H=[ones(1,4),zeros(1,22),ones(1,4)];
H(1,5)=0.5886;H(1,26)=0.5886;H(1,6)=0.1065;H(1,25)=0.1065;
k=0:(N/2-1);k1=(N/2+1):(N-1);k2=0;
A=[exp(-j*pi*k*(N-1)/N),exp(-j*pi*k2*(N-1)/N),exp(j*pi*(N-k1)*(N-1)/N)];
HK=H.*A;
h=ifft(HK);
fs=15000;
[c,f3]=freqz(h,1);
f3=f3/pi*fs/2;
subplot(221);
plot(f3,20*log10(abs(c)));
title('Ƶ������');
xlabel('Ƶ��/HZ');ylabel('˥��/dB');
grid on;
subplot(222);
title('�����������');
stem(real(h),'.');
line([0,35],[0,0]);
xlabel('n');ylabel('Real(h(n))');
grid on;
t=(0:100)/fs;
W=sin(2*pi*t*750)+sin(2*pi*t*3000)+sin(2*pi*t*6500);
q=filter(h,1,W);
[a,f1]=freqz(W);
f1=f1/pi*fs/2;
[b,f2]=freqz(q);
f2=f2/pi*fs/2;
subplot(223);
plot(f1,abs(a));
title('���벨��Ƶ��ͼ');
xlabel('Ƶ��');ylabel('����')
grid on;
subplot(224);
plot(f2,abs(b));
title('�������Ƶ��ͼ');
xlabel('Ƶ��');ylabel('����')
grid on;

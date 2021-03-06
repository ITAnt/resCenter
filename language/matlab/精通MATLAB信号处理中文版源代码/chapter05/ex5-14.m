clear;
close all;
wd=0.875*pi;N=133;M=(N-1)/2;
nn=-M:M;
n=nn+eps;
hd=sin(wd*n)./(pi*n);           % 理想冲激响应
w=hamming(N)';                  % 海明窗
h=hd.*w;                        % 实际冲激响应
H=20*log10(abs(fft(h,1024)));   % 实际滤波器的分贝幅度特性
HH=[H(513:1024) H(1:512)];
subplot(221),plot(nn,hd,'k');
xlabel('n');title('理想冲激响应');axis([-70 70 -0.1 0.3]);
subplot(222),plot(nn,w,'k');axis([-70 70 -0.1 1.2]);
title('海明窗');xlabel('n');
subplot(223),plot(nn,h,'k');
axis([-70 70 -0.1 0.3]);xlabel('n');title('实际冲激响应');
w=(-512:511)/511;
subplot(224),plot(w,HH,'k');
axis([-1.2 1.2 -140 20]);xlabel('\omega/\pi');title('滤波器分贝幅度特性');
set(gcf,'color','w');

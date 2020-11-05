clear;close all;
wd=0.6*pi;N=65;M=(N-1)/2;
nn=-M:M;
n=nn+eps;
hd=3*((-1).^n).*tan(wd*n)./(pi*n);           % ����弤��Ӧ
w=hamming(N)';                  % ������
h=hd.*w;                        % ʵ�ʳ弤��Ӧ
H=20*log10(abs(fft(h,1024)));   % ʵ���˲����ķֱ���������
HH=[H(513:1024) H(1:512)];
subplot(221),stem(nn,hd,'k');
xlabel('n');title('����弤��Ӧ');axis([-18 18 -0.8 1.2]);
subplot(222),stem(nn,w,'k');axis([-18 18 -0.1 1.2]);
title('������');xlabel('n');
subplot(223),stem(nn,h,'k');
axis([-18 18 -0.8 1.2]);xlabel('n');title('ʵ�ʳ弤��Ӧ');
w=(-512:511)/511;
subplot(224),plot(w,HH,'k');
axis([-1.2 1.2 -140 20]);xlabel('\omega/\pi');title('�˲����ֱ���������');
set(gcf,'color','w');

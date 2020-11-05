clf; 
clear all ; 
close all;  
fs=100;
%������ 
Ts=1/fs;    
t=0:Ts:10;   
gass=2^(1/4)*exp(-pi*(t).^2).*cos(5*pi*t);
% ����һ����˹���� 
subplot(231);
plot(t,gass); 
title('��˹����'); 
xlabel('t'); 
ylabel('����');
grid on;
T=0:Ts:10; 
ft=sin(T.^2+2*T)+sin(T.^2);
%����Ҫ�任���źź��� 
subplot(232);
plot(t,ft); 
title('�źź���'); 
grid on;
xlabel('t');
ylabel('����');
y=fft(ft);
%�ź���FFT�任 
amp=abs(y);
grid on;
subplot(233);
plot(amp); 
title('�źŵ�FFT�任'); 
xlabel('f'); 
ylabel('����');
grid on;
subplot(234);
plot(t,imag(hilbert(ft)));
title('�źŵ�HHT�任');
grid on;
shl=100;
%��˹��ÿ��ƽ�Ƶ��� 
shn=(length(t)-1)/shl;
%���˹��ƽ���ܴ��� 
y2=zeros(shn,2001); 
for k=0:shn-1; 
gassc=2^(1/4)*exp(-pi*(t-k*shl*Ts).^2).*cos(5*pi*t);
%ƽ�ƺ�ĸ�˹���� 
gassc2=gassc/sum(gassc.^2)
%��һ�� 
yl=conv(hilbert(ft),gassc2);
%��ʱ����Ҷ�任�������ź���Gauss��������� 
    y2(k+1,:)=yl; 
end 
[F,T]=size(y2); 
[F,T]=meshgrid(1:T,1:F); 
subplot(235);
mesh(F,T,abs(y2)) 
title('�źų߶ȷֲ�ͼ'); 
xlabel('t'); 
ylabel('f ') 
zlabel('����'); 
subplot(236);
contour(F,T,abs(y2))
%�ȸ���ͼ
title('�ź�ʱƵͼ'); 

xlabel('F(Hz)'); 
ylabel('�߶�')

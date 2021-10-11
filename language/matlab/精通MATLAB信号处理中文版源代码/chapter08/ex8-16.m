snr = 4; 
t=0:1/1000:1-0.001; 
y=sin(3*pi*t); 
n = randn(size(t)); 
s=y+n; 
xd = wden(s,'heursure','s','one',3,'sym8'); 
subplot(3,1,1); 
plot(s); 
xlabel('n'); 
ylabel('幅值'); 
title('含噪信号'); 
subplot(3,1,2); 
plot(y); 
title('原始信号'); 
xlabel('n'); 
ylabel('幅值'); 
subplot(3,1,3); 
plot(xd); 
title('消噪信号'); 
xlabel('样本信号'); 
ylabel('幅值') 

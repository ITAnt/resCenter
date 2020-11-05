clear all;
a = [1 -2.3147 2.9413 -2.1187 0.9105];      %����ARģ��
[H,w] = freqz(1,a,256);     % AR ģ�͵�Ƶ����Ӧ
Hp = plot(w/pi,20*log10(2*abs(H)/(2*pi)),'r'); 
hold on;
randn('state',0);
x = filter(1,a,randn(256,1));           % AR ģ�����
pburg(x,4,511); 
xlabel('Ƶ��/Hz')
ylabel('��Թ������ܶ�(dB/Hz)');
title('Burg��PSD����');
legend('PSDģ�����','PSD�׹���');
grid on;

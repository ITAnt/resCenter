clear all
fn=10000;  
fp=2000;  
fs=3000;  
Rp=4;  
Rs=30;
Wp=fp/(fn/2);%�����һ����Ƶ��
Ws=fs/(fn/2);
[n,Wn]=buttord(Wp,Ws,Rp,Rs);
%��������ͽ�ֹƵ��
[b,a]=butter(n,Wn);
%����H(z)���ӡ���ĸ����ʽϵ��
[H,F]=freqz(b,a,1000,8000);
%����H(z)�ķ�Ƶ��Ӧ,freqz(b,a,�������,��������)
subplot(121)
plot(F,20*log10(abs(H))) 
xlabel('Ƶ�� (Hz)'); ylabel('��ֵ(dB)') 
title('��ͨ�˲���')
axis([0 4000 -30 3]);
grid on
subplot(122)
pha=angle(H)*180/pi;
plot(F,pha);
xlabel('Ƶ�� (Hz)'); ylabel('��λ')
grid on

fn=10000;  
fp=[900,1200];  
fs=[600,1700];  
Rp=4;  
Rs=30;
Wp=fp/(fn/2);
%�����һ����Ƶ��
Ws=fs/(fn/2);
[n,Wn]=buttord(Wp,Ws,Rp,Rs);
%��������ͽ�ֹƵ��
[b,a]=butter(n,Wn);
%����H(z)���ӡ���ĸ����ʽϵ��
[H,F]=freqz(b,a,1000,10000);
%����H(z)�ķ�Ƶ��Ӧ,freqz(b,a,�������,��������)
subplot(121)
plot(F,20*log10(abs(H)))
axis([0 5000 -30 3])
xlabel('Ƶ�� (Hz)'); ylabel('��ֵ(dB)') 
grid on
subplot(122)
pha=angle(H)*180/pi;
plot(F,pha)
xlabel('Ƶ�� (Hz)'); ylabel('��λ')
grid on

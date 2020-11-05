Wp=[3*pi*9000,3*pi*16000];
Ws=[3*pi*7000,3*pi*17000];
rp=1;rs=30;                                 %ģ���˲��������ָ��
[N,wso]=cheb2ord(Wp,Ws,rp,rs,'s');           %�����˲����Ľ���
[b,a]=cheby2(N,rs,wso,'s');                  %�����˲�����ϵͳ�����ķ��ӡ���ĸ����
w=0:3*pi*100:3*pi*25000;
[h,w]=freqs(b,a,w);                          %����Ƶ����Ӧ
plot(w/(2*pi),20*log10(abs(h)),'k');
xlabel('f(Hz)');ylabel('����(dB)');grid;

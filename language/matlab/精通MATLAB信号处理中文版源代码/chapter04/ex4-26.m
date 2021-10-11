Wc1=3*pi*9000;
Wc2=3*pi*16000;
rp=2;
rs=25;
Wd1=3*pi*6000;
Wd2=3*pi*20000;           %ģ���˲��������ָ��
B=Wc2-Wc1;
wo=sqrt(Wc1*Wc2);wp=1;
ws2=(Wd2*Wd2-wo*wo)/Wd2/B;
ws1=-(Wd1*Wd1-wo*wo)/Wd1/B;
ws=min(ws1,ws2);                        %Ƶ���任���õ���һ���˲���
[N,wc]=cheb1ord(wp,ws,rp,rs, 's');       %�����б�ѩ��I���˲����Ľ���
[z,p,k]=cheb1ap(N,wc);                  %�����һ���˲������㡢����
[bp,ap]=zp2tf(z,p,k);                   %�����һ���˲�����ϵͳ�������ӡ���ĸϵ��
[b,a]=lp2bp(bp,ap,wo,B);                %����һ��ģ���˲�����ϵͳ�������ӡ���ĸϵ��
w=0:3*pi*130:3*pi*25000;               
[h,w]=freqs(b,a,w);                     %����Ƶ����Ӧ
plot(w/(2*pi),20*log10(abs(h)), 'k'),axis([0,30000,-100,0]);
xlabel('f(Hz)');
ylabel('����(dB)');
grid;

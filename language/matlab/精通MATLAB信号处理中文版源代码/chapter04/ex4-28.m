Wc1=3*pi*9000;
Wc2=3*pi*16000;
rp=2;
rs=25;
Wd1=3*pi*6000;
Wd2=3*pi*20000;           %ģ���˲��������ָ��
B=Wd2-Wd1;wo=sqrt(Wd1*Wd2);wp=1;
ws2=(Wc2*B)/(Wc2*Wc2-wo*wo);ws1=-(Wc1*B)/(Wc1*Wc1-wo*wo);
ws=max(ws1,ws2);                        %Ƶ���任���õ���һ���˲���
[N,wc]=cheb1ord(wp,ws,rp,rs, 's');        %�����б�ѩ��I���˲����Ľ���
[z,p,k]=cheb1ap(N,wc);                  %�����һ���˲������㡢����
[bp,ap]=zp2tf(z,p,k);                   %�����һ���˲�����ϵͳ�������ӡ���ĸϵ��
[b,a]=lp2bs(bp,ap,wo,B);                %����һ��ģ���˲�����ϵͳ�������ӡ���ĸϵ��
w=0:3*pi*130:3*pi*30000;               
[h,w]=freqs(b,a,w);                     %����Ƶ����Ӧ
plot(w/(2*pi),20*log10(abs(h)), 'k'),axis([0,30000,-100,0]);
xlabel('f(Hz)');
ylabel('����(dB)');
grid;

Wp=3*pi*4*12^3;
Ws=3*pi*12*10^3;
rp=1;
rs=30;   %����˲����Ĳ���
wp=1;ws=Ws/Wp;                               %�Բ�����һ��
[N,wc]=cheb2ord(wp,ws,rp,rs, 's');            %�����˲��������������ʼƵ��
[z,p,k]=cheb2ap(N,rs);                       %������㡢���㡢����
[B,A]=zp2tf(z,p,k);                          %����ϵͳ�����Ķ���ʽ
w=0:0.02*pi:pi;
[h,w]=freqs(B,A,w);
plot(w*wc/wp,20*log10(abs(h)),'k');grid;
xlabel('\lambda');ylabel('A(\lambda)/dB');

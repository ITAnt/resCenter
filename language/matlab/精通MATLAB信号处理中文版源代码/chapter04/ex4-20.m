Wp=3*pi*4*12^3;
Ws=2*pi*12*12^3;
rp=2;
rs=25;   %����˲����Ĳ���
wp=1;ws=Ws/Wp;                               %�Բ�����һ��
[N,wc]=ellipord(wp,ws,rp,rs, 's');            %�����˲��������������ʼƵ��
[z,p,k]=ellipap(N,rp,rs);                    %������㡢���㡢����
[B,A]=zp2tf(z,p,k);                          %����ϵͳ�����Ķ���ʽ
w=0:0.03*pi:2*pi;[h,w]=freqs(B,A,w);
plot(w,20*log10(abs(h)),'k');
xlabel('\lambda');ylabel('A(\lambda)/dB');grid;

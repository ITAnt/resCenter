wc=2*1000*tan(2*pi*400/(2*1000));
wt=2*1000*tan(2*pi*317/(2*1000));
[N,wn]=cheb1ord(wc,wt,0.5,19,'s');
%ѡ����С�׺ͽ�ֹƵ��
%��Ƹ�ͨ�˲���
[B,A]=cheby1(N,0.5,wn, 'high','s'); 
%����б�ѩ��I��ģ���˲���
[num,den]=bilinear(B,A,1000);
%�����˲������
[h,w]=freqz(num,den);
f=w/pi*500;
plot(f,20*log10(abs(h)));
axis([0,500,-80,10]);
grid;
xlabel('Ƶ��/Hz')
ylabel('����/dB')

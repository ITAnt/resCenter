Fs=40000;fp=5000;fs=9000;
rp=1;rs=30;
wp=2*fp/Fs;ws=2*fs/Fs;       %���������˲��������ָ��
[N,wc]=buttord(wp,ws,rp,rs); %���������˲����Ľ�����ͨ����ֹƵ��
[b,a]=butter(N,wc);          %���������˲���ϵͳ����
w=0:0.01*pi:pi;
[h,w]=freqz(b,a,w);          %���������˲����ķ�Ƶ��Ӧ
plot(w/pi,20*log10(abs(h)), 'k');axis([0,1,-100,10]);
xlabel('\omega/\pi');ylabel('����(dB)');grid;

function hd=ideal_bs(Wcl,Wch,m); 
alpha=(m-1)/2; 
n=[0:1:(m-1)];
m=n-alpha+eps; 
hd=[sin(m*pi)+sin(Wcl*m)-sin(Wch*m)]./(pi*m)
�����ӳ���2��
function[db,mag,pha,w]=freqz_m2(b,a)
[H,w]=freqz(b,a,1000,'whole');
H=(H(1:1:501))'; w=(w(1:1:501))';
mag=abs(H);
db=20*log10((mag+eps)/max(mag));
pha=angle(H);
����MATLABԴ�������£�
clear all;
Wph=3*pi*6.25/15;
Wpl=3*pi/15;
Wsl=3*pi*2.5/15;
Wsh=3*pi*4.75/15;
tr_width=min((Wsl-Wpl),(Wph-Wsh));
%���ɴ����
N=ceil(4*pi/tr_width);					%�˲�������
n=0:1:N-1;
Wcl=(Wsl+Wpl)/2;						%�����˲����Ľ�ֹƵ��
Wch=(Wsh+Wph)/2;
hd=ideal_bs(Wcl,Wch,N);				%�����˲����ĵ�λ�����Ӧ
w_ham=(boxcar(N))';
string=['���δ�','N=',num2str(N)];
h=hd.*w_ham;						%��ȡȡ��ʵ�ʵĵ�λ������Ӧ
[db,mag,pha,w]=freqz_m2(h,[1]);
%����ʵ���˲����ķ�����Ӧ
delta_w=2*pi/1000;
subplot(241);
stem(n,hd);
title('����������Ӧhd(n)')
axis([-1,N,-0.5,0.8]);
xlabel('n');ylabel('hd(n)');
grid on
subplot(242);
stem(n,w_ham);
axis([-1,N,0,1.1]);
xlabel('n');ylabel('w(n)');
text(1.5,1.3,string);
grid on
subplot(243);
stem(n,h);title('ʵ��������Ӧh(n)');
axis([0,N,-1.4,1.4]);
xlabel('n');ylabel('h(n)');
grid on
subplot(244);
plot(w,pha);title('��Ƶ����');
axis([0,3.15,-4,4]);
xlabel('Ƶ�ʣ�rad��');ylabel('��λ������');
grid on
subplot(245);
plot(w/pi,db);title('�������ԣ�dB��');
axis([0,1,-80,10]);
xlabel('Ƶ�ʣ�pi��');ylabel('�ֱ���');
grid on
subplot(246);
plot(w,mag);title('Ƶ������')
axis([0,3,0,2]);
xlabel('Ƶ�ʣ�rad��');ylabel('��ֵ');
grid on
fs=15000;
t=(0:100)/fs;
x=cos(2*pi*t*750)+cos(2*pi*t*3000)+cos(2*pi*t*6100);
q=filter(h,1,x);
[a,f1]=freqz(x);
f1=f1/pi*fs/2;
[b,f2]=freqz(q);
f2=f2/pi*fs/2;
subplot(247);
plot(f1,abs(a));
title('���벨��Ƶ��ͼ');
xlabel('Ƶ��');ylabel('����')
grid on
subplot(248);
plot(f2,abs(b));
title('�������Ƶ��ͼ');
xlabel('Ƶ��');ylabel('����')
grid on

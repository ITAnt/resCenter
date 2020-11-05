function hd=ideal_lp(wc,M);
%���������ͨ�˲�����������Ӧ
%[hd]=ideal_lp(wc,M)
%hd=����������Ӧ0��M-1
%wc=��ֹƵ��
% M=�����˲����ĳ���
alpha=(M-1)/2;
n=[0:1:(M-1)];
m=n-alpha+eps;
%����һ����С��ֵeps�������0�Ĵ����������
hd=sin(wc*m)./(pi*m);
���г������£�
clear all;
wp1=0.4*pi;
wp2=0.6*pi;
ws1=0.3*pi;
ws2=0.7*pi;
As=150;
tr_width=min((wp1-ws1),(ws2-wp2)); 					%���ɴ���� 
M=ceil(11*pi/tr_width)+1							%�˲�������
n=[0:1:M-1];
wc1=(ws1+wp1)/2;									%�����ͨ�˲������½�ֹƵ��
wc2=(ws2+wp2)/2;									%�����ͨ�˲������Ͻ�ֹƵ��
hd=ideal_lp(wc2,M)-ideal_lp(wc1,M);
w_bla=(blackman(M))';								%����������
h=hd.*w_bla;
%��ȡ�õ�ʵ�ʵĵ�λ������Ӧ
[db,mag,pha,grd,w]=freqz_m(h,[1]);
%����ʵ���˲����ķ�����Ӧ
delta_w=2*pi/1000;
Rp=-min(db(wp1/delta_w+1:1:wp2/delta_w))
%ʵ��ͨ���Ʋ�
As=-round(max(db(ws2/delta_w+1:1:501)))
As=150
subplot(2,2,1);
stem(n,hd);
title('���뵥λ������Ӧhd(n)')
axis([0 M-1 -0.4 0.5]);
xlabel('n');
ylabel('hd(n)')
grid on;
subplot(2,2,2);
stem(n,w_bla);
title('����������w(n)')
axis([0 M-1 0 1.1]);
xlabel('n');
ylabel('w(n)')
grid on;
subplot(2,2,3);
stem(n,h);
title('ʵ�ʵ�λ������Ӧhd(n)')
axis([0 M-1 -0.4 0.5]);
xlabel('n');
ylabel('h(n)')
grid on;
subplot(2,2,4);
plot(w/pi,db);
axis([0 1 -150 10]);
title('������Ӧ(dB)');
grid on;
xlabel('Ƶ�ʵ�λ:pi');
ylabel('�ֱ���')

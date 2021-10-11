clear all;
Rs=30;      %�˲��������˥��Ϊ20dB
[z,p,k]=cheb2ap(4,Rs);  %�������ѩ��II��ģ��ԭ���˲���
 [b,a]=zp2tf(z,p,k);    %����㼫��������ʽת��Ϊ���ݺ�����ʽ
n=0:0.02:4;
[h,w]=freqs(b,a,n);   %��������Ƶ����Ӧ
subplot(121);plot(w,abs(h).^2);  %���ƽ����Ƶ����
xlabel('w/wc');ylabel('����ѩ��II��|H(jw)|^2');
title('����ѩ��II�͵�ͨԭ���˲��� (wc=1)');
grid on;
w1=0.7; w2=1.6;  %������Ҫ����˲���ͨ�������޺�����Ƶ��
w0=sqrt(w1*w2);  %�������ĵ�Ƶ��
bw=w2-w1;        %�������ĵ�Ƶ�����
[bt,at]=lp2bp(b,a,w0,bw);  %Ƶ��ת��
[ht,wt]=freqs(bt,at,n);   %�����˲����ĸ���Ƶ����Ӧ
subplot(122);plot(wt,abs(ht).^2);  %���ƽ����Ƶ����
xlabel('w/wc');ylabel('����ѩ��II��|H(jw)|^2');
title('����ѩ��II�ʹ�ͨ�˲��� (wc=0.7~1.6)');
grid on;

clear all;
Rp=0.5;      %�����˲�����ͨ������Ϊ0.5dB
[z,p,k]=cheb1ap(5,Rp);  %�������ѩ��I��ģ��ԭ���˲���
[b,a]=zp2tf(z,p,k);    %����㼫��������ʽת��Ϊ���ݺ�����ʽ
n=0:0.02:4;
[h,w]=freqs(b,a,n);   %��������Ƶ����Ӧ
subplot(121);plot(w,abs(h).^2);  %���ƽ����Ƶ����
xlabel('w/wc');ylabel('��Բ|H(jw)|^2');
title('����ѩ��I�͵�ͨԭ���˲��� (wc=1)');
grid on;
[bt,at]=lp2hp(b,a,0.6);  %�ɵ�ͨԭ���˲���ת��Ϊ��ֹƵ��Ϊ0.8�ĸ�ͨ�˲���
[ht,wt]=freqs(bt,at,n);   %��������Ƶ����Ӧ
subplot(122);plot(wt,abs(ht).^2);  %���ƽ����Ƶ����
xlabel('w/wc');ylabel('��Բ|H(jw)|^2');
title('����ѩ��I�͸�ͨ�˲��� (wc=0.6)');
grid on;

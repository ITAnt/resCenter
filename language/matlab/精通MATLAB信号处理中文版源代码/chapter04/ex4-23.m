clear all;
Rp=3;  Rs=25;       %ģ��ԭ���˲�����ͨ�����������˥��
[z,p,k]=ellipap(4,Rp,Rs);  %�����Բ�˲���
[b,a]=zp2tf(z,p,k);    %����㼫��������ʽת��Ϊ���ݺ�����ʽ
n=0:0.02:4;
[h,w]=freqs(b,a,n);   %��������Ƶ����Ӧ
subplot(121);plot(w,abs(h).^2);  %���ƽ����Ƶ����
xlabel('w/wc');ylabel('��Բ|H(jw)|^2');
title('ԭ�͵�ͨ��Բ�˲��� (wc=1)');
grid on;
[bt,at]=lp2lp(b,a,0.5);  %��ģ��ԭ�͵�ͨ�˲����Ľ�ֹƵ�ʱ任Ϊ0.5
[ht,wt]=freqs(bt,at,n);   %��������Ƶ����Ӧ
subplot(122);plot(wt,abs(ht).^2);  %���ƽ����Ƶ����
xlabel('w/wc');ylabel('��Բ|H(jw)|^2');
title('ԭ�͵�ͨ��Բ�˲��� (wc=0.6)');
grid on;

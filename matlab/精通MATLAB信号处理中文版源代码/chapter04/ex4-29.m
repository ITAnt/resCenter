clear all;
[z,p,k]=buttap(5);  %��ư�����˼ģ��ԭ���˲���
[b,a]=zp2tf(z,p,k);    %����㼫��������ʽת��Ϊ���ݺ�����ʽ
n=0:0.02:4;
[h,w]=freqs(b,a,n);   %��������Ƶ����Ӧ
subplot(121);
plot(w,abs(h).^2);  %���ƽ����Ƶ����
xlabel('w/wc');ylabel('������˼|H(jw)|^2');
title(' wc=1');
grid on;
w1=0.6; 
w2=1.6;  %������Ҫ��ƴ�������޺�����Ƶ��
w0=sqrt(w1*w2);  %�������ĵ�Ƶ��
bw=w2-w1;        %�������ĵ�Ƶ�����
[bt,at]=lp2bs(b,a,w0,bw);  %Ƶ��ת��
[ht,wt]=freqs(bt,at,n);   %��������˲����ĸ���Ƶ����Ӧ
subplot(122);
plot(wt,abs(ht).^2);  %���ƽ����Ƶ����
xlabel('w/wc');
ylabel('������˼|H(jw)|^2');
title(' wc=0.6~1.6');
grid on;

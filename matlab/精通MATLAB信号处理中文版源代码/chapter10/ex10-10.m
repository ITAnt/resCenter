clear all;
% �����������������źŵ���ǿ
sound=wavread('tt.wav');  %�����źŵĶ���
cound=length(sound);
noise=0.05*randn(1,cound);
y=sound'+noise;
% ��ȡ��������ֵ
[thr,sorh,keepapp]=ddencmp('den','wv',y);
% ���źŽ�������
yd=wdencmp('gbl',y,'db4',2,thr,sorh,keepapp);
subplot(1,2,1); plot(sound);
title('ԭʼ�����ź�');
subplot(1,2,2);plot(yd);
title('ȥ���������ź�');

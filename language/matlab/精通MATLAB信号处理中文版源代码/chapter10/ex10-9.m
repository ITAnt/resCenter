clear all;
% �����������������źŵ���ǿ
sound=wavread('tt.wav');  %�����źŵĶ���
cound=length(sound);
noise=0.05*randn(1,cound);
y=sound'+noise;
% ��С������'db6'���źŽ���3��ֽ�
[C,L]=wavedec(y,3,'db6');
% ���Ƴ߶�1��������׼ƫ��
sigma=wnoisest(C,L,1);
alpha=2;
% ��ȡ��������е���ֵ
thr=wbmpen(C,L,sigma,alpha);
keepapp=1;
% ���źŽ�������
yd=wdencmp('gbl',C,L,'db6',3,thr,'s',keepapp);
subplot(1,2,1); plot(sound);
title('ԭʼ�����ź�');
subplot(1,2,2);plot(yd);
title('ȥ���������ź�');

clear all;
%�����źŵĶ���
sound=wavread('tt.wav');  
% ��С������haar���źŽ���3��ֽ�
[C,L]=wavedec(sound,3,'haar');
alpha=1.5;
% ��ȡ�ź�ѹ������ֵ
[thr,nkeep]=wdcbm(C,L,alpha);
% ���źŽ���ѹ��
[cp,cxd,lxd,per1,per2]=wdencmp('lvd',C,L,'haar',3,thr,'s');
subplot(1,2,1); plot(sound);
title('ԭʼ�����ź�');
subplot(1,2,2);plot(cp);
title('ѹ����������ź�');

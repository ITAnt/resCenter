clear all;
%�����źŵĶ���
sound=wavread('tt.wav');  
% ��С������haar���źŽ���5��ֽ�
[C,L]=wavedec(sound,5,'haar');
% ��ȡ�ź�ѹ������ֵ
[thr,nkeep]=ddencmp('cmp','wv',sound);
% ���źŽ���ѹ��
cp=wdencmp('gbl',C,L,'haar',5,thr,'s',1);
subplot(1,2,1); plot(sound);
title('ԭʼ�����ź�');
subplot(1,2,2);plot(cp);
title('ѹ����������ź�');

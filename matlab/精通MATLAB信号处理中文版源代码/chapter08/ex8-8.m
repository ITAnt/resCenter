clear all;
load whitnois;   %װ��ԭʼwhitnois�ź�
x = whitnois;
% ʹ��db1С�������ź�x����3��ֽ�
t = wpdec(x,3,'db1','shannon');
subplot(2,1,1);plot(x)
title('ԭʼwhitnois�ź�');
% �ع�С�������(2,1)
rcfs = wprcoef(t,[2 1]);
subplot(212); plot(rcfs); 
title('�ع�С�������(2,1)');

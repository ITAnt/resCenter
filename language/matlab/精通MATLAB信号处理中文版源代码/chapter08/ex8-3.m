clear all;
load leleccum;     %װ��ԭʼleleccum�ź�
s=leleccum(1:540);
% ��С������db1���źŽ������߶�С���ֽ�
[C,L]=wavedec(s,3,'db1');
subplot(2,1,1);plot(s);
title('ԭʼ�ź�');
% ��С������db1�����źŵĵ�Ƶ�ع�
a3=wrcoef('a',C,L,'db1');
subplot(2,1,2);plot(a3);
title('С���ع��ź�');

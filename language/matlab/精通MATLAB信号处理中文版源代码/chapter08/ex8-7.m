clear all;
load sumsin;       %% װ��ԭʼsumsin�ź�
s=sumsin(1:500); 
% ȡ�źŵ�ǰ500��������
% ʹ��Shannon��
wpt=wpdec(s,3,'db2','shannon');
% ���źŽ����ع�
rex=wprec(wpt);
subplot(211); plot(s); 
title('ԭʼsumsin�ź�'); 
subplot(212); plot(rex); 
title('�ع�����ź�');

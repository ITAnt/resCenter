clear all;
load sumsin;       %װ��ԭʼsumsin�ź�
s=sumsin(1:500); 
% ȡ�źŵ�ǰ500��������
[c,l] = wavedec(s,3,'db1'); 
subplot(311); plot(s); 
title('ԭʼsumsin�ź�'); 
subplot(312); plot(c); 
title('С��3���ع�') 
xlabel(['�߶�3�ĵ�Ƶϵ���ͳ߶�3,2,1�ĸ�Ƶϵ��'])
% ��ó߶�2��С���ֽ�
[nc,nl] = upwlev(c,l,'db1'); 
subplot(313); plot(nc); 
title('С��2���ع�') 
xlabel(['�߶�2�ĵ�Ƶϵ���ͳ߶�2,1�ĸ�Ƶϵ��'])

load sumsin   %�����ź�
s=sumsin(1:500);
%ȡ�źŵ�ǰ500��������
[c,l]=wavedec(s,3, 'db3');
%���ź�������Ϊ3�Ķ�߶ȷֽ�
a3= wrcoef('a',c,l, 'db3',3);
%�Գ߶�3�ϵĵ�Ƶ�źŽ����ع�
subplot(211);plot(s);title('ԭʼ�ź�')
subplot(212);plot(a3);title ('�ع��ź�');

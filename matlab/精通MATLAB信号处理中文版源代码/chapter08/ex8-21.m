clear all;
load sumsin;    %װ��ԭʼsumsin�ź�
s=sumsin(1:500); 
% ȡ�źŵ�ǰ500��������
figure; 
subplot(6,1,1);plot(s);
ylabel('s');
% ʹ��db3С�����źŽ���5��ֽ�
[C,L]=wavedec(s,5,'db3');
for i=1:5
    % �Էֽ�ĵ�5�㵽��1��ĵ�Ƶϵ�������ع�
    a=wrcoef('a',C,L,'db3',6-i);
    subplot(6,1,i+1); plot(a);   
    ylabel(['a',num2str(6-i)]);
end
figure;
subplot(6,1,1);plot(s);
ylabel('s'); 
for i=1:5
    % �Էֽ�ĵ�6�㵽��1��ĸ�Ƶϵ�������ع�
    d=wrcoef('d',C,L,'db3',6-i);
    subplot(6,1,i+1);plot(d);
    ylabel(['d',num2str(6-i)]);    
end

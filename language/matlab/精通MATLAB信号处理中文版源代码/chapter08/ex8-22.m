clear all;
load wnoislop;          %װ��ԭʼwnoislop�ź�
x= wnoislop;
subplot(6,1,1);plot(x);
ylabel('x');
% ����һά��ɢС���任
[C,L]=wavedec(x,5,'db4');
for i=1:5
    % �Էֽ�ṹ[C,L]�еĵ�Ƶ���ֽ����ع�
    s=wrcoef('a',C,L,'db4',6-i);
    subplot(6,1,i+1);plot(s);
    ylabel(['a',num2str(6-i)]);
end

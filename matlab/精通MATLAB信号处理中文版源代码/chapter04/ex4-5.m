function [b,a]=cas2dir(b0,B,A) 
%�����͵�ֱ���͵�ת��
%a=ֱ���ͷ��Ӷ���ʽϵ��
%b=ֱ���ͷ�ĸ����ʽϵ��
%b0=����ϵ��
%B=����������ϵ��bk��K��3�о���
%A=����������ϵ��ak��K��3�о���
[K,L]=size(B);
b=[1]; 
a=[1];
for i=1:1:K
b=conv(b,B(i,:)); 
a=conv(a,A(i,:)); 
end 
b=b*b0;
��ʵ�ֵ�MATLAB����������£�
clear all
b0=3;
N=30;
B=[1,1,0;1,-3.1415926,1];
A=[1,-0.6,0;1,0.7,0.72];
delta=impseq(0,0,N);
x=[ones(1,5),zeros(1,N-5)];
[b,a]=cas2dir(b0,B,A) 
h=filter(b,a,delta);                %ֱ���͵�λ������Ӧ
y=filter(b,a,x);                  % ?ֱ���������Ӧ
subplot(211);stem(h);
title('������h(n)');
subplot(212);stem(y);
title('������y(n)');

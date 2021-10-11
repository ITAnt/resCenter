function [b,a]=par2dir(C,B,A)
%����ģ�͵�ֱ���͵�ת��
% [b,a]=par2dir(C,B,A)
% CΪ��b�ĳ��ȴ���aʱ�Ķ���ʽ����
% BΪ������bk��K�˶�άʵϵ������
% AΪ������ak��K����άʵϵ������
% bΪֱ���ͷ��Ӷ���ʽϵ��
% aΪֱ���ͷ�ĸ����ʽϵ��
[K,L]=size(A);
R=[];
P=[];
for i=1:1:K
    [r,p,k]=residuez(B(i,:),A(i,:));
    R=[R;r];
    P=[P;p];
end
[b,a]=residuez(R,P,C);
b=b(:)';
a=a(:)';
��ʵ�ֵ�MATLAB����������£�
clear all;
C=0;B=[-13.65 -14.81;32.60 16.37];
A=[1,-2.95,3.14;1,-1,0.5];N=60;
delta=impseq(0,0,N);
[b,a]=par2dir(C,B,A);
h=filter(b,a,delta);
x=[ones(1,5),zeros(1,N-5)];
y=filter(b,a,x);
subplot(211);stem(h);
xlabel('(a) ֱ����h(n)');
subplot(212);stem(y);
xlabel('(a) ֱ����y(n)');

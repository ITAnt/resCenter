function y=parfiltr(C,B,A,x)
%IIR�˲����Ĳ���ʵ��
% y= parfiltr(C,B,A,x)
%yΪ���
%CΪ��B�ĳ��ȵ���A�ĳ���ʱ����ʽ�Ĳ���
%B=����������ϵ��bk��K��2άʵϵ������
%A=����������ϵ��ak��K��3άʵϵ������
%xΪ����
 [K,L]=size(B);
N=length(x);
w=zeros(K+1,N);
w(1,:)=filter(C,1,x);
for i=1:1:K
    w(i+1,:)=filter(B(i,:),A(i,:),x);
end
y=sum(w);
��ʵ�ֵ�MATLAB����������£�
clear
C=0;
N=30;
B=[-13.65,-14.81;32.60,16.37];
A=[1,-2.95,3.14;1,-1,0.5];
delta=impseq(0,0,N);
x=[ones(1,5),zeros(1,N-5)];
h=parfiltr(C,B,A,delta);			%�����͵�λ������Ӧ��deltaָ������������ֵ
y=parfiltr(C,B,A,x);			%�����������Ӧ
subplot(211);stem(h);
title('������h(n)');
subplot(212);stem(y);
title('������y(n)');

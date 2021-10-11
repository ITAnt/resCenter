function [C,B,A]=dir2par(b,a)
%ֱ���ͽṹת��Ϊ������
% [C,B,A]=dir2par(b,a)
%CΪ��b�ĳ��ȵ���a�ĳ���ʱ����ʽ�Ĳ���
%B=����������ϵ��bk��K��2άʵϵ������
%A=����������ϵ��ak��K��3άʵϵ������
%b=ֱ���ͷ��Ӷ���ʽϵ��
%a=ֱ���ͷ�ĸ����ʽϵ��
M=length(b);
N=length(a);
[r1,p1,C]=residuez(b,a);
p=cplxpair(p1,10000000*eps);
I=cplxcomp(p1,p);
r=r1(I);
K=floor(N/2);
B=zeros(K,2);
A=zeros(K,3);
if K*2==N;
    for i=1:2:N-2
        Brow=r(i:1:i+1,:);
        Arow=p(i:1:i+1,:);
        [Brow,Arow]=residuez(Brow,Arow,[]);
        B(fix((i+1)/2),:)=real(Brow);
        A(fix((i+1)/2),:)=real(Arow);
    end
    [Brow,Arow]=residuez(r(N-1),p(N-1),[]);
    B(K,:)=[real(Brow) 0];
    A(K,:)=[real(Arow) 0];
else
    for i=1:2:N-1
       Brow=r(i:1:i+1,:);
        Arow=p(i:1:i+1,:);
        [Brow,Arow]=residuez(Brow,Arow,[]);
        B(fix((i+1)/2),:)=real(Brow);
        A(fix((i+1)/2),:)=real(Arow);
    end
end
�����г����У������û��Զ����д��cplxcomp���������������ҵĸ���������бȽϣ�����һ��
������±꣬�������¸�һ������������������£�
function I=cplxcomp(p1,p2)
%I=cplxcomp(p1,p2)
%�Ƚ���������ͬ������Ԫ�ص�(����)�в�ͬ�±�ĸ�����
%�������������cplxpair()������Ա���������Ƶ�ʼ���ʸ��
%������Ӧ������ʸ��
% p2=cplxpair(p1)
I=[];
for j=1:length(p2)
for i=1:length(p1)
if (abs((p1(i)-p2(j))<0.0001)
I=[I,i];
end
end
end
I=I��;
��ʵ�ֵ�MATLAB����������£�
clear all;
b=[1 -7 13 27 19];
a=[17 13 5 -6 -2];
N=25;
delta=impseq(0,0,N);
[C,B,A]=dir2par(b,a);     
h=parfilter(C,B,A,delta);  
x=[ones(1,5),zeros(1,N-5)];  %��λ��Ծ�ź�
y=casfilter(C,B,A,x);  
subplot(211);stem(h);
xlabel('(a) ֱ����h(n)');
subplot(212);stem(y);
xlabel('(a) ֱ����y(n)');

function [b0,B,A]=dir2cas(b,a);
%��ֱ����ʽΪ������ʽ
%[b0,B,A]=dir2cas(b,a)
%b0=����ϵ��
%B=����������ϵ��bk��K��3�о���
%A=����������ϵ��ak��K��3�о���
%b=ֱ���ͷ��Ӷ���ʽϵ��
%a=ֱ���ͷ�ĸ����ʽϵ��
b0=b(1);b=b/b0;
a0=a(1);a=a/a0;
b0=b0/a0;
%�����ӡ���ĸ����ʽϵ���ĳ��Ȳ�����м���
M=length(b);N=length(a);
if N>M
   b=[b zeros(1,N-M)];
elseif M>N
   a=[a zeros(1,M-N)];N=M;
else
   NM=0;
end
%������ϵ�������ʼ��
K=floor(N/2);B=zeros(K,3);A=zeros(K,3);
if K*2==N
   b=[b 0];
   a=[a 0];
end
%���ݶ���ʽϵ�����ú���roots������еĸ�
%���ú���cplxpair���а�ʵ����С����ĳɶ�����
broots=cplxpair(roots(b));
aroots=cplxpair(roots(a));
%ȡ��������Եĸ��任�ɶ���ʽϵ����Ϊ����
for i=1:2:2*K
   Brow=broots(i:1:i+1,:);
   Brow=real(poly(Brow));
   B(fix(i+1)/2,:)=Brow;
   Arow=aroots(i:1:i+1,:);
   Arow=real(poly(Arow));
   A(fix(i+1)/2,:)=Arow;
end
��ʵ�ֵ�MATLAB����������£�
clear all;
n=0:5;
b=0.2.^n; 
N=30; 
B=[1,-7,13,27,19];
A=[17,13,5,-6,-2];
delta=impseq(0,0,N); 
h=filter(b,1,delta);%ֱ���� 
x=[ones(1,5),zeros(1,N-5)]; 
y=filter(b,1,x); 
subplot(221);stem(h);title('ֱ����h(n)'); 
subplot(222);stem(y);title('ֱ����y(n)');
[b0,B,A]=dir2cas(b,1) 
h=casfilter(b0,B,A,delta); 
y=casfilter(b0,B,A,x);
subplot(223);stem(h);title('������h(n)');
subplot(224);stem(y);title('������y(n)');

L=input('�������źų���L=');
N=input('�������˲�������N=');
%����w(n),v(n),u(n),s(n)��x(n)
a=0.95;
b1=sqrt(12*(1-a^2))/2;
b2=sqrt(3);
w=random('uniform',-b1,b1,1,L);						%����random�����������Ȱ�����
v=random('uniform',-b2,b2,1,L);
u=zeros(1,L);
for i=1:L
  u(i)=1;
end
s=zeros(1,L); 
s(1)=w(1);
for i=2:L,
  s(i)=a*s(i-1)+w(i);
end
  x=zeros(1,L);
  x=s+v;
%���s(n)��x(n)������ͼ
set(gcf,'Color',[1,1,1]);
i=L-100:L;
subplot(2,2,1);
plot(i,s(i),i,x(i),'r:');
title('s(n) & x(n)');
legend('s(n)', 'x(n)');
%���������˲�����h(n)
h1=zeros(N:1);
for i=1:N
     h1(i)=0.238*0.724^(i-1)*u(i);
end
%���ù�ʽ������Rxx��rxs
Rxx=zeros(N,N);
rxs=zeros(N,1);
for i=1:N
     for j=1:N
         m=abs(i-j);
         tmp=0;
         for k=1:(L-m)
             tmp=tmp+x(k)*x(k+m);
         end
         Rxx(i,j)=tmp/(L-m);
     end
end
for m=0:N-1
     tmp=0;
     for i=1: L-m
         tmp=tmp+x(i)*s(m+i);
     end
     rxs(m+1)=tmp/(L-m);
 end
%����FIRά���˲�����h(n)
h2=zeros(N,1);
h2=Rxx^(-1)*rxs;
%��������ά���˲���h(n)������ͼ
i=1:N;
subplot(2,2,2);
plot(i,h1(i),i,h2(i),'r:');
title('h(n) & h~(n)');
legend('h(n) ','h~(n)');
%����Si
Si=zeros(1,L);
Si(1)=x(1);
for i=2:L
Si(i)=0.724*Si(i-1)+0.238*x(i);
end
%���Si(n)��s(n)����ͼ
 i=L-100:L;
 subplot(2,2,3);
 plot(i,s(i),i,Si(i),'r:');
title('Si(n) & s(n)');
legend('Si(n) ','s(n)');
%����Sr
Sr=zeros(1,L);
for i=1:L
     tmp=0;
     for j=1:N-1
         if(i-j<=0)
             tmp=tmp;
         else 
             tmp=tmp+h2(j)*x(i-j);
         end
     end
     Sr(i)=tmp;
 end
%���Si(n)��s(n)����ͼ
i=L-100:L;
subplot(2,2,4);
plot(i,s(i),i,Sr(i),'r:');
title('s(n) & Sr(n)');
legend('s(n) ','Sr(n)');
%����������Ex,Ei��Er
tmp=0;
 for i=1:L
     tmp=tmp+(x(i)-s(i))^2;
end
Ex=tmp/L,										%��ӡ��Ex
tmp=0;
for i=1:L
     tmp=tmp+(Si(i)-s(i))^2;
end
Ei=tmp/L,
tmp=0;
for i=1:L
      tmp=tmp+(Sr(i)-s(i))^2;
end
Er=tmp/L

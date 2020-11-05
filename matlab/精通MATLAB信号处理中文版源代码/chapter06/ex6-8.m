clear all 
N=256;
%�źų��� 
f1=0.025; 
f2=0.2; 
f3=0.21; 
A1=-0.750737; 
p=15;
%ARģ�ͽ״� 
V1=randn(1,N); 
V2=randn(1,N); 
U=0;
%������ֵ 
Q=0.101043;
%�������� 
b=sqrt(Q/2); 
V1=U+b*V1;
%����1*N�׾�ֵΪU,����ΪQ/2�ĸ�˹���������� 
V2=U+b*V2;
%����1*N�׾�ֵΪU,����ΪQ/2�ĸ�˹���������� 
V=V1+j*V2;%����1*N�׾�ֵΪU,����ΪQ�ĸ���˹���������� 
z(1)=V(1,1); 
for n=2:1:N 
    z(n)=-A1*z(n-1)+V(1,n); 
end 
x(1)=6; 
for n=2:1:N 
    x(n)=2*cos(2*pi*f1*(n-1))+2*cos(2*pi*f2*(n-1))+2*cos(2*pi*f3*(n-1))+z(n-1); 
end 
for k=0:1:p 
    t5=0; 
    for n=0:1:N-k-1 
        t5=t5+conj(x(n+1))*x(n+1+k); 
    end 
    Rxx(k+1)=t5/N; 
end 
a(1,1)=-Rxx(2)/Rxx(1); 
p1(1)=(1-abs(a(1,1))^2)*Rxx(1); 
for k=2:1:p 
    t=0; 
    for l=1:1:k-1 
        t=a(k-1,l).*Rxx(k-l+1)+t; 
    end 
    a(k,k)=-(Rxx(k+1)+t)./p1(k-1); 
    for i=1:1:k-1 
        a(k,i)=a(k-1,i)+a(k,k)*conj(a(k-1,k-i)); 
    end 
    p1(k)=(1-(abs(a(k,k)))^2).*p1(k-1); 
end 
for k=1:1:p 
    a(k)=a(p,k); 
end 
f=-0.5:0.0001:0.5; 
f0=length(f); 
for t=1:f0 
    s=0; 
    for k=1:p 
        s=s+a(k)*exp(-j*2*pi*f(t)*k); 
    end 
    X(t)=Q/(abs(1+s))^2; 
end 
 plot(f,10*log10(X)) 
xlabel('Ƶ��'); 
ylabel('PSD(dB)'); 
title('����ط���ARģ���׹���')

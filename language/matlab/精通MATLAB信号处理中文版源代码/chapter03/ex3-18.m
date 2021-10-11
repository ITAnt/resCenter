clear all;
n=0:200-1;
f=200;  fs=3000;
x=cos(2*pi*n*f/fs);
y=dct(x);   %����DCT�任
m=find(abs(y<5));  %������ֵ�Ա任ϵ����ȡ
y(m)=zeros(size(m));
z=idct(y);   %�����޴�����ϵ��DCT���任
subplot(1,2,1);plot(n,x);
xlabel('n');title('����x(n)');
subplot(1,2,2);plot(n,z);
xlabel('n');title('����z(n)');

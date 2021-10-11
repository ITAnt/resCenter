N=456;
B1=[1 0.2544 0.2509 0.1826 0.2401]; 
A1=[4];
w=linspace(0,pi,512);
H1=freqz(B1,A1,w);
%�����źŵ�Ƶ����Ӧ
Ps1=abs(H1).^2;
SPy11=0;%20��AR(4)
SPy14=0;%20��MA(4)
VSPy11=0;%20��AR(4)
VSPy14=0;%20��MA(4)
for k=1:20
%������Э�����ARģ�Ͳ������й���%
y1=filter(B1,A1,randn(1,N)).*[zeros(1,200),ones(1,256)];
[Py11,F]=pcov(y1,4,512,1);%AR(4)�Ĺ���%
[Py13,F]=periodogram(y1,[],512,1);
SPy11=SPy11+Py11;
VSPy11=VSPy11+abs(Py11).^2;
y=zeros(1,256);
for i=1:256
y(i)=y1(200+i);
end
ny=[0:255];
z=fliplr(y);nz=-fliplr(ny); 
nb=ny(1)+nz(1);ne=ny(length(y))+nz(length(z));
n=[nb:ne];
Ry=conv(y,z);
R4=zeros(8,4);
r4=zeros(8,1);
for i=1:8
r4(i,1)=-Ry(260+i);
for j=1:4
R4(i,j)=Ry(260+i-j);
end
end
R4
r4
a4=inv(R4'*R4)*R4'*r4
%������С���˷��õ��Ĺ��Ʋ���
%��MA�Ĳ���b(1)-b(4)���й���%
A1
A14=[1,a4']
%AR�Ĳ���a(1)-a(4)�Ĺ���ֵ
B14=fliplr(conv(fliplr(B1),fliplr(A14)));
%MAģ�͵ķ���
y24=filter(B14,A1,randn(1,N));%.*[zeros(1,200),ones(1,256)];
%�ɹ��Ƴ���MAģ�Ͳ�������
[Ama4,Ema4]=arburg(y24,32),
B1
b4=arburg(Ama4,4)
%���MAģ�͵Ĳ���
%---������---%
w=linspace(0,pi,512);
%H1=freqz(B1,A1,w)
H14=freqz(b4,A14,w);
%�����źŵ�Ƶ����Ӧ
%Ps1=abs(H1).^2;%��ʵ��
Py14=abs(H14).^2;%������
SPy14=SPy14+Py14;
VSPy14=VSPy14+abs(Py14).^2;
end
figure(1)
plot(w./(2*pi),Ps1,w./(2*pi),SPy14/20);
legend('��ʵ������','20��MA(4)���Ƶ�ƽ��ֵ');
grid on;
xlabel('Ƶ��');
ylabel('����');

clear all;
n=40;           %�˲����Ľ���
f=[0 0.5 0.6 1];  %Ƶ������
a=[1 2 0 0];         %�������
w=[1 20];
b=firls(n,f,a,w);    
[h,w1]=freqz(b);   %�����˲�����Ƶ����Ӧ
bb=remez(n,f,a,w);   %����remez����˲���
[hh,w2]=freqz(bb); %�����˲�����Ƶ����Ӧ
figure;
plot(w1/pi,abs(h),'r.',w2/pi,abs(hh),'b-.',f,a,'ms');
%�����˲�����Ƶ��Ӧ
xlabel('��һ��Ƶ��');ylabel('���');

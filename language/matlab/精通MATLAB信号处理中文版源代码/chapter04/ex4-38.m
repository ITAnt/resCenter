clear all;
N=6; 
Rp=3;        %�˲�������
f1=150;
f2=600;    %�˲����ı߽����(Hz)
w1=2*pi*f1;  
w2=2*pi*f2;   %�߽�Ƶ��(rad/s)
[z,p,k]=cheb2ap(N,Rp);  %���Chebyshev I��ԭ�͵�ͨ�˲���
[b,a]=zp2tf(z,p,k);  %ת��Ϊ���ݺ�����ʽ
Wo=sqrt(w1*w2);       %����Ƶ��
Bw=w2-w1;             %Ƶ�����
[bt,at]=lp2bp(b,a,Wo,Bw);  %Ƶ��ת��
[h,w]=freqs(bt,at);    %���㸴��Ƶ����Ӧ
figure;
subplot(2,2,1);semilogy(w/2/pi,abs(h));  %���Ʒ�Ƶ����
xlabel('Ƶ��/Hz'); title('��Ƶͼ');
grid on;
subplot(2,2,2);plot(w/2/pi,angle(h)*180/pi);  %������Ƶ��Ӧ
xlabel('Ƶ��/Hz');ylabel('��λͼ/^o');title('��Ƶͼ');
grid on;
H=[tf(bt,at)];   %��MATLAB�б�ʾ���˲���
[h1,t1]=impulse(H);  %���ϵͳ��������Ӧͼ
subplot(2,2,3);plot(t1,h1); 
xlabel('ʱ��/s');title('������Ӧ');
[h2,t2]=step(H);  %���ϵͳ�Ľ�Ծ��Ӧͼ
subplot(2,2,4);plot(t2,h2); 
xlabel('ʱ��/s');title('��Ծ��Ӧ');

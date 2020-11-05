dt=1/2000;
t=0:dt:0.1;         %����ģ���˲��������ʱ�䷶Χ
% ģ�������ź�
u=tan(2*pi*30*t)+0.5* sin (2*pi*300*t)+2* cos (2*pi*800*t);
subplot(2,2,1);plot(t,u)   %����ģ�������ź�
xlabel('ʱ��/s');title('�����ź�');
[ys,ts]=lsim(H,u,t);       %ģ��ϵͳ������uʱ�����
subplot(2,2,2);plot(ts,ys); %����ģ�������ź�
xlabel('ʱ��/s');title('����ź�');
% ���������ź������
subplot(2,2,3);plot((0:length(u)-1)/(length(u)*dt),abs(fft(u))*2/length(u));
xlabel('Ƶ��/Hz');title('�����ź������');
subplot(2,2,4);
Y=fft(ys);
%��������ź������
plot((0:length(Y)-1)/(length(Y)*dt),abs(Y)*2/length(Y));
xlabel('Ƶ��/Hz');title('����ź������');

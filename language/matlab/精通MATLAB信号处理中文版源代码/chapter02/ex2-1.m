clear all;
N=[-3 -2 -1 0 1 3 3 2 5 6 7 6 9 11];  %Ϊ�������
X=[0 2 3 3 2 3 0 -1 -2 -3 -4 -5 1 2]; %Ϊֵ����
subplot(2,1,1);stem(N,X);  %������ɢֵͼ
hold on;
plot(N,zeros(1,length(X)),'r');
%���ƺ���,zeros(1,N)Ϊ����1��N��Ԫ��ֵΪ�������
set(gca,'box','on');  %�������������ڷ�����
xlabel('���к�');ylabel('����ֵ');
dt=1;      %ʱ����
t=N*dt;    %ʱ������
subplot(2,1,2);plot(t,X);  %������ʱ��ı仯
hold on;
plot(t,zeros(1,length(X)),'r');  %�������
xlabel('ʱ��/s');ylabel('����ֵ');

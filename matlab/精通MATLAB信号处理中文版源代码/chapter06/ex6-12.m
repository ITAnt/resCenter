clear
tic
%s�趨ARMAģ�͵Ķ���ʽϵ����ARMAģ����ֻ�ж���ʽA(q)��C(q)��
a1 = -(0.6)^(1/3);
a2 = (0.6)^(2/3);
a3 = 0;
a4 = 0;
c1 = 0;
c2 = 0;
c3 = 0;
c4 = 0; 
obv = 3000;
%obv��ģ��Ĺ۲���Ŀ�� 
A = [1 a1 a2 a3 a4];
B = [];
%��ΪARMAģ��û�����룬��˶���ʽB�ǿյġ�
C = [1 c1 c2 c3 c4];
D = [];
%��DҲ��Ϊ�յġ�
F = [];
%ARMAģ�����F����ʽҲ�ǿյġ�
m = idpoly(A,B,C,D,F,1,1)
%������������ARMAģ�ͣ������洢��m�С��������Ts��Ϊ1�� 
error = randn(obv, 1);
%����һ��obv*1����̬������С�׼������ģ�͵�����
e = iddata([],error,1);
%��randn��������һ���������С��洢��e�С����������1�롣
%u = [];
%��Ϊ��ARMAģ�ͣ�û����������԰�u��Ϊ�յġ�
y = sim(m,e); 
get(y)
%ʹ��get�������鿴��̬ϵͳ���������ʡ�
r=y.OutputData; 
%��y.OutputData��ȫ��ֵ��������r��r����һ��obv*1�������� 
figure(1)
plot(r)
title('ģ���ź�');
ylabel('��ֵ');
xlabel('ʱ��')
%���y��ʱ��仯�����ߡ� 
figure(2)
subplot(2,1,1)
n=100;
[ACF,Lags,Bounds]=autocorr(r,n,2);
x=Lags(2:n);
y=ACF(2:n);
%ע�������y��ǰ��y����ȫ��ͬ��
h=stem(x,y,'fill','-');
set(h(1),'Marker','.')
hold on
ylim([-1 1]); 
a=Bounds(1,1)*ones(1,n-1);
line('XData',x,'YData',a,'Color','red','linestyle','--')
line('XData',x,'YData',-a,'Color','red','linestyle','--')
ylabel('�����ϵ��')
title('ģ���ź�ϵ��');
subplot(2,1,2)
[PACF,Lags,Bounds]=parcorr(r,n,2);
x=Lags(2:n);
y=PACF(2:n);
h=stem(x,y,'fill','-');
set(h(1),'Marker','.')
hold on
ylim([-1 1]);
b=Bounds(1,1)*ones(1,n-1);
line('XData',x,'YData',b,'Color','red','linestyle','--')
line('XData',x,'YData',-b,'Color','red','linestyle','--')
ylabel('ƫ�����ϵ��')  
m = 3;
R = reshape(r,m,obv/m); 
% ������ r ���γ�m*(obv/m)�ľ���R. 
aggregatedr = sum(R);
% sum(R)�������Rÿһ�еĺ͡��õ���1*(obv/m)������aggregatedr����ʱƵ�鲢��õ������С�
dlmwrite('output.txt',aggregatedr','delimiter','\t','precision',6,'newline','pc');
% ��������˶�r��ʱƵ�鲢�� 
figure(3)
subplot(2,1,1) 
n=100;
bound = 1;
[ACF,Lags,Bounds]=autocorr(aggregatedr,n,2);
x=Lags(2:n);
y=ACF(2:n); 
h=stem(x,y,'fill','-');
set(h(1),'Marker','.')
hold on
ylim([-bound bound]); 
a=Bounds(1,1)*ones(1,n-1);
line('XData',x,'YData',a,'Color','red','linestyle','--')
line('XData',x,'YData',-a,'Color','red','linestyle','--')
ylabel('�����ϵ��')
title('�鲢ģ���ź�ϵ��');
subplot(2,1,2)
[PACF,Lags,Bounds]=parcorr(aggregatedr,n,2);
x=Lags(2:n);
y=PACF(2:n);
h=stem(x,y,'fill','-');
set(h(1),'Marker','.')
hold on
ylim([-bound bound]);
b=Bounds(1,1)*ones(1,n-1);
line('XData',x,'YData',b,'Color','red','linestyle','--')
line('XData',x,'YData',-b,'Color','red','linestyle','--')
ylabel('ƫ�����ϵ��')  
t=toc;

Dt=0.00005;t=-0.005:Dt:0.005;						%ģ���ź�
xa=exp(-2000*abs(t)); 
Ts=0.0002;n=-25:1:25;								%��ɢʱ���ź�
x=exp(-1000*abs(n*Ts));
K=500;k=0:1:K;w=pi*k/K;
%��ɢʱ�丵��Ҷ�任
X=x*exp(-j*n'*w);X=real(X);
w=[-fliplr(w),w(2:501)];
X=[fliplr(X),X(2:501)];
figure
subplot(2,2,1);
plot(t*1000,xa,'.'); 
ylabel('x1(t)'); xlabel('t');
title ('��ɢ�ź�');
hold on
stem(n*Ts*1000,x);hold off
subplot(2,2,2);
plot(w/pi,X,'.');
ylabel('X1(jw)'); xlabel('f');
title('��ɢʱ�丵��Ҷ�任');
Ts=0.001;n=-25:1:25;
%��ɢʱ���ź�
x=exp(-1000*abs(n*Ts));
K=500;k=0:1:K;w=pi*k/K;
%��ɢʱ�丵��Ҷ�任
X=x*exp(-j*n'*w);X=real(X);
w=[-fliplr(w),w(2:501)];
X=[fliplr(X),X(2:501)];
subplot(2,2,3);
plot(t*1000,xa,'.'); 
ylabel('x2(t)'); xlabel('t');
title ('��ɢ�ź�');
hold on
stem(n*Ts*1000,x);hold off
subplot(2,2,4);
plot(w/pi,X,'.');
ylabel('X2(jw)'); xlabel('f');
title('��ɢʱ�丵��Ҷ�任');

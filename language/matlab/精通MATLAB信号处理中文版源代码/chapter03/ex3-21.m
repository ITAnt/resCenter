clear all
a=1/10;
m=2;					%�趨���ڳ߶Ⱥͳ���˹��������
t1=5;t2=6;
%�趨˫�źŵ�λ��
%����˫�źŵ���ά��������ͼ
[t,W]=meshgrid([2:0.2:7],[0:pi/6:3*pi]); 
%����ʱ-Ƶ��ƽ�������
Gs1=(1/(sqrt(2*pi)*a))*exp(-0.5*abs((t1-t)/a).^m).*exp(-i*W*t1);
Gs2=(1/(sqrt(2*pi)*a))*exp(-0.5*abs((t2-t)/a).^m).*exp(-i*W*t2);
Gs=Gs1+Gs2;
subplot(2,3,1);
%����ʵ����ά��������ͼ
mesh(t,W/pi,real(Gs));
axis([2 7 0 3 -1/(sqrt(2*pi)*a) 1/(sqrt(2*pi)*a)]);
title('ʵ��')
xlabel('t(s)'); ylabel('real(Gs)');
subplot(2,3,2);
%�����鲿��ά��������ͼ
mesh(t,W/pi,imag(Gs));
axis([2 7 0 3 -1/(sqrt(2*pi)*a) 1/(sqrt(2*pi)*a)]);
title('�鲿')
xlabel('t(s)'); ylabel('imag(Gs)');
subplot(2,3,3);
%���ƾ���ֵ��ά��������ͼ
mesh(t,W/pi,abs(Gs));
axis([2 7 0 3 -1/(sqrt(2*pi)*a) 1/(sqrt(2*pi)*a)]);
title('����ֵ')
xlabel('t(s)'); ylabel('abs(Gs)');
%����˫�źŵĶ�ά�Ҷ�ͼ
[t,W]=meshgrid([2:0.2:7],[0:pi/20:3*pi]);
%����ʱƵ��ƽ�������
Gs1=(1/(sqrt(2*pi)*a))*exp(-0.5*abs((t1-t)/a).^m).*exp(-i*W*t1);
Gs2=(1/(sqrt(2*pi)*a))*exp(-0.5*abs((t2-t)/a).^m).*exp(-i*W*t2);
Gs=Gs1+Gs2;
subplot(2,3,4);
ss=real(Gs);ma=max(max(ss));
%�������ֵ
pcolor(t,W/pi,ma-ss);
title('ʵ�����ֵ')
xlabel('t(s)'); ylabel('maxreal(Gs)');
colormap(gray(50));shading interp;
subplot(2,3,5);
ss=imag(Gs);ma=max(max(ss));
%�������ֵ
pcolor(t,W/pi,ma-ss);
title('�鲿���ֵ')
xlabel('t(s)'); ylabel('maximag(Gs)');
colormap(gray(50));shading interp;
subplot(2,3,6);
ss=abs(Gs);ma=max(max(ss));
%�������ֵ�����ֵ
pcolor(t,W/pi,ma-ss);
title('����ֵ���ֵ')
xlabel('t(s)'); ylabel('maxabs(Gs)');
colormap(gray(50));
shading interp;

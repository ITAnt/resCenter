%�������(a)ϵͳ�㼫��ֲ�ͼ��ϵͳ��λ������Ӧ 
z=0;							%����ϵͳ���λ�� 
p=0.25;						%����ϵͳ����λ�� 
k=1;							%����ϵͳ����
subplot(221)
zplane(z,p)
grid on;
%����ϵͳ�㼫��ֲ�ͼ
subplot(222);
[num,den]=zp2tf(z,p,k);			%�㼫��ģ��ת��Ϊ���ݺ���ģ�� 
impz(num,den)
%����ϵͳ��λ������Ӧʱ���� 
title('h(n)')
grid on;
%������� 
%�������(b)ϵͳ�㼫��ֲ�ͼ��ϵͳ��λ������Ӧ 
p=1; 
subplot(223);
zplane(z,p)
grid on;
[num,den]=zp2tf(z,p,k); 
subplot(224);
impz(num,den) 
title('h(n)') 
grid on;

function ljdt(A,B)
p=roots(A);						%��ϵͳ����
q=roots(B);						%��ϵͳ���
p=p';							%������������ת��Ϊ������
q=q';							%�����������ת��Ϊ������
x=max(abs([p q 1]));				%ȷ�������귶Χ
x=x+0.1;
y=x;								%ȷ�������귶Χ
clf
hold on
axis([-x x -y y])						%ȷ����������ʾ��Χ
w=0:pi/300:2*pi;
t=exp(i*w);
plot(t)							%����λ԰
axis('square')
plot([-x x],[0 0])					%����������
plot([0 0],[-y y])					%����������
text(0.1,x,'jIm[z]')
text(y,1/10,'Re[z]')
plot(real(p),imag(p),'x')				%������
plot(real(q),imag(q),'o')
title('�㼫��ͼ')					%��ע����
hold off
���г������£�
% �����㼫��ֲ�ͼ��ʵ�ֳ���
a=[3 -2 0 0 0 1];
b=[2 1];
ljdt(a,b)
p=roots(a)
q=roots(b)
pa=abs(p)

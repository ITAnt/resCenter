syms t f2;
f2=t*(2*heaviside(t)-heaviside(t-1))+heaviside(t-1); 
t=-1:0.01:2;
subplot(121);
ezplot(f2,t);
title('ԭ����')
grid on;
ylabel('x(t)');
f=diff(f2,'t',1); 
subplot(122)
ezplot(f,t);
title('���ֺ��� ')
grid on;
ylabel('x(t)')

syms t;
f=sym('cos(t+1)+t');
f1=subs(f,t,-t)
g=1/2*(f+f1);
h=1/2*(f-f1);
subplot(311);ezplot(f,[-8,8]);title('ԭ�ź�');
subplot(312);ezplot(g,[-8,8]);title('ż����');
subplot(313);ezplot(h,[-8,8]);title('�����');

h=[-4 3 -5 -2  5 7 5 -2 -1 8 -3]
M=length(h);
n=0:M-1; 
[Hr,w,a,L]=hr_type1(h);
subplot(2,2,1);
stem(n,h); 
xlabel('n');
ylabel('h(n)');
title('������Ӧ')
grid on
subplot(2,2,3);
stem(0:L,a); 
xlabel('n');
ylabel('a(n)');
title('a(n)ϵ��')
grid on
subplot(2,2,2); 
plot(w/pi,Hr);
xlabel('Ƶ�ʵ�λpi');ylabel('Hr');
title('I�ͷ�����Ӧ')
grid on
subplot(2,2,4);
pzplotz(h,1);
grid on

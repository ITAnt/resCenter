h=[-4 3 -5 -2  5 7 5 -2 -1 8 -3]
M=length(h);
n=0:M-1; 
[Hr,w,d,L]=hr_type4(h);
subplot(2,2,1);
stem(n,h); 
xlabel('n');
ylabel('h(n)');
title('������Ӧ')
grid on
subplot(2,2,3);
stem(1:L,d); 
xlabel('n');
ylabel('d(n)');
title('d(n)ϵ��')
grid on
subplot(2,2,2); 
plot(w/pi,Hr);
xlabel('Ƶ�ʵ�λpi');ylabel('Hr');
title('���ͷ�����Ӧ')
grid on
subplot(2,2,4);
pzplotz(h,1);
grid on

clear all;
t=0:0.002:4;
sys=tf([1,32],[1,4,64]);
h=impulse(sys,t);   %�弤��Ӧ
g=step(sys,t);      %��Ծ��Ӧ
subplot(2,1,1);plot(t,h);
grid on;
xlabel('ʱ��/s');ylabel('h(t)');
title('�弤��Ӧ');
subplot(2,1,2);plot(t,g);
grid on;
xlabel('ʱ��/s');ylabel('g(t)');
title('��Ծ��Ӧ');

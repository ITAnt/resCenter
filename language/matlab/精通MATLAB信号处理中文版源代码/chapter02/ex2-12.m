clear all; close all; clc;
nx=-2:5;x=[9 8 7 6 5 5 5 5];
y=x;ny1=nx+3;ny2=nx-2;
subplot(211),stem(nx,x,'.');axis([-5 9 -1 6]);grid;
xlabel('n');ylabel('x(n)');title('原序列');
subplot(223),stem(ny1,y,'.');axis([-5 9 -1 6]);grid;
xlabel('n');ylabel('y1(n)');title('右移3位后的序列');
subplot(224),stem(ny2,y,'.');axis([-5 9 -1 6]);grid;
xlabel('n');ylabel('y2(n)');title('左移2位后的序列');
set(gcf,'color','w');

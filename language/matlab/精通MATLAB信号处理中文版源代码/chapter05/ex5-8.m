function [A,w,type,tao]=amplres(h)
% h��  FIR�����˲�����������Ӧ
% A��  �˲����ķ�������
% w��  ��[0 2*pi] �����ڼ���Hr ��512��Ƶ�ʵ�
% type��������λ�˲���������
% tao�� �������Ե�Ⱥ����
N=length(h);
tao=(N-1)/2; 
L=floor(tao); 
n=1:L+1;
w=[0:511]*2*pi/512;              
if all(abs(h(n)-h(N-n+1))<1e-8)          
    if mod(N,2)~=0
        A=2*h(n)*cos(((N+1)/2-n)'*w)-h(L+1);
        type=1
    else 
    A=2*h(n)*cos(((N+1)/2-n)'*w);  
        type =2;              
     end
 elseif all(abs(h(n)+h(N-n+1))<1e-8)&&(h(L+1)*mod(N,2)==0)    
    A=2*h(n)*sin(((N+1)/2-n)'*w);        
     if mod(N,2)~=0
        type=3;
    else type=4;        
    end
else error('error����������λ�˲���!') 
end
��MATLABʵ��Դ�������£�
clear all; close all; clc;
h1 = [-3,1,-1,-2,5,6,5,-2,-1,1,-3];
h2 = [-3,1,-1,-2,5,6,6,5,-2,-1,1,-3];
h3 = [-3,1,-1,-2,5,0,-5,2,1,-1,3];
h4= [-3,1,-1,-2,5,6,-6,-5,2,1,-1,3];
[A1,w1,a1,L1]=amplres(h1);
[A2,w2,a2,L2]=amplres(h2);
[A3,w3,a3,L3]=amplres(h3);
[A4,w4,a4,L4]=amplres(h4); 
figure(1),
n1=0:length(h1)-1;
amax = max(h1)+1; amin = min(h1)-1;
subplot(241); 
stem(n1,h1,'k'); 
axis([-1 2*L1+1 amin amax])
text(5,-6,'n'); 
ylabel('h(n)'); 
title('������Ӧ')
subplot(242);
plot(w1,A1,'k');grid;
text(4,-18,'w'); 
ylabel('A(\omega)');
title('I�ͷ�����Ӧ')
n2=0:length(h2)-1;
amax = max(h2)+1; 
amin = min(h2)-1;
subplot(243); 
stem(n2,h2,'k');
axis([-1 2*L2+1 amin amax]);
text(5,-6,'n');
 ylabel('h(n)');
 title('������Ӧ');
subplot(244);plot(w2,A2,'k');
grid;text(4,-28,'w');  
ylabel('A(\omega)');
title('II�ͷ�����Ӧ')
n3=0:length(h3)-1;
amax = max(h3)+1;
amin = min(h3)-1;
subplot(245); 
stem(n3,h3,'k'); 
axis([-1 2*L3+1 amin amax])
text(5,-7,'n');  
ylabel('h(n)'); 
title('������Ӧ')
subplot(246);
plot(w3,A3,'k');
grid;
text(4,-28,'w');
ylabel('A(\omega)');
title('III�ͷ�����Ӧ');
n4=0:length(h4)-1;
amax = max(h4)+1;
amin = min(h4)-1;
subplot(247);
stem(n4,h4,'k');
axis([-1 2*L4+1 amin amax]);
text(5,-8,'n');
ylabel('h(n)');
title('������Ӧ');
subplot(248);
plot(w4,A4,'k');grid;
text(4,-12,'w');
ylabel('A(\omega)');
title('IV�ͷ�����Ӧ');

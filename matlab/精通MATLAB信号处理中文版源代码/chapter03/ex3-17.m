clear all;
clc;
close all;
n=1:100;
x=10*sin(2*pi*n/20)+20*cos(2*pi*n/30);
y=dct(x);
subplot(1,2,1),plot(x),title('ԭʼ�ź�');
subplot(1,2,2),plot(y),title('DCTЧ��');

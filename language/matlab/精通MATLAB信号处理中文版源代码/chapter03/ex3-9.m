clear all;
t=linspace(1e-3,100e-3,10);
xn=sin(100*2*pi*t);    %������������x(n)
N=length(xn);          %������еĳ���
WNnk=dftmtx(N);  
Xk=xn*WNnk;       %����x(n)��DFT
subplot(1,2,1);stem(1:N,xn);
subplot(1,2,2);stem(1:N,abs(Xk));

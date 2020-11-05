N=16;N1=8;
n=0:N-1;k=0:N1-1;
x1n=exp(j*pi*n/8);				%����x1(n)
X1=fft(x1n,N);					%����N��DFT[x1(n)]
X2=fft(x1n,N1);				%����N1��DFT[x1(n)]
x2n=cos(pi*n/8);				%����x2(n)
X3=fft(x2n,N);					%����N��DFT[x2(n)]
X4=fft(x2n,N1);				%����N1��DFT[x2(n)]
subplot(2,2,1);
stem(n,abs(X1),'.');
axis([0,20,0,20]);
ylabel('|X1(k)|')
title('16���DFT[x1(n)]')
subplot(2,2,2);
stem(n,abs(X3),'.');
axis([0,20,0,20]);
ylabel('|X2(k)|')
title('16���DFT[x2(n)]')
subplot(2,2,3);
stem(k,abs(X2),'.');
axis([0,20,0,20]);
ylabel('|X1(k)|')
title('8���DFT[x1(n)]')
subplot(2,2,4);
stem(k,abs(X4),'.');
axis([0,20,0,20]);
ylabel('|X2(k)|')
title('8���DFT[x2(n)]')

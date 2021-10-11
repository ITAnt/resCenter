clear all;
n=0:0.01:2;
for i=1:4,
    switch i
        case 1;
            N=1;
        case 2;
            N=3;
        case 3;
            N=8;
        case 4;
            N=12;
    end;
[z,p,k]=buttap(N);    %��������
[b,a]=zp2tf(z,p,k);   %�õ����ݺ���
[h,w]=freqs(b,a,n);   %���Է���
magh=abs(h);
subplot(2,2,i);plot(w,magh);
axis([0 2 0 1]);
xlabel('w/wc');ylabel('|H(jw)|^2');
title([' filter N=',num2str(N)]);
grid on;
end

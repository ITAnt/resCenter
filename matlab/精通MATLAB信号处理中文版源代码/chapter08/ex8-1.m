snr=4;
%���������
init=2055615866;
%�����������ֵ
[si,xi]=wnoise(1,11,snr,init);
%�������β��źźͺ��������ź�
lev=5;
xd=wden(xi,'heursure','s','one',lev,'sym8');
figure
subplot(231);
plot(si);
axis([1 2048 -15 15]); 
title('ԭʼ�ź�');
subplot(232);
plot(xi);
axis([1 2048 -15 15]); 
title('�������ź�');
ssi=fft(si);
ssi=abs(ssi);
xxi=fft(xi);
absx=abs(xxi);
subplot(233);
plot(ssi);
title('ԭʼ�źŵ�Ƶ��');
subplot(234);
plot(absx);
title('�����źŵ�Ƶ��');%���е�ͨ�˲�
indd2=200:1800;
xxi(indd2)=zeros(size(indd2));
xden=ifft(xxi);%���и���Ҷ���任
xden=real(xden);
xden=abs(xden);
subplot(235);
plot(xd);
axis([1 2048 -15 15]); 
title('С���������ź�');
subplot(236);
plot(xden);
axis([1 2048 -15 15]); 
title('����Ҷ�����������ź�');

clc;
clear all;
snr=4;                                        %���������
%MATLAB����''wnoise''���������ź�
%ԭʼ�ź�Ϊxref������˹���������ź�Ϊx
%�ź�����Ϊblocks���ɺ����в���1������
%���Ⱦ�Ϊ2^11���ɺ����еĲ���11������
%�����snr=4���ɺ����еĲ���snr������
 [xref,x]=wnoise(1,11,snr);
xref=xref(1:2000);                            %ȡ�źŵ�ǰ2000��
x=x(1:2000);                                %ȡ�źŵ�ǰ2000��
%��ȫ��Ĭ����ֵ����ȥ�봦��
 [thr,sorh,keepapp]=ddencmp('den','wv',x);         % ��ȡȫ��Ĭ����ֵ
xd=wdencmp('gbl',x,'sym8',3,thr,sorh,keepapp);    %����ȫ��Ĭ����ֵ���ź�ȥ��
%��������ͼ����������ԭʼ�źźͺ������źŵ�ͼ
figure
subplot(231);plot(xref);                 %����ԭʼ�źŵ�ͼ
title('ԭʼ�ź�');
subplot(234);plot(x);
title('�������ź�');                    %�����������źŵ�ͼ
%�����ø���Ҷ�任����ԭ�źź������źŵ�Ƶ�׷���
dt=1/(2^11);                         %ʱ��ֱ���
Fs=1/dt;                            %����Ƶ��ֱ���
df=Fs/2000;                         
xxref=fft(xref);                      %��ԭʼ�ź������ٸ���Ҷ�任
xxref=fftshift(xxref);                 %��Ƶ��ͼƽ��
xxref=abs(xxref);                    %ȡ����Ҷ�任�ķ�ֵ
xx=fft(x);                          %�Ժ������ź������ٸ���Ҷ�任
xx=fftshift(xx);                      %��Ƶ�װ���
absxx=abs(xx);                      %ȡ����Ҷ�任�ķ�ֵ
ff=-1000*df:df:1000*df-df;            %����Ƶ����
subplot(232);plot(ff,xxref);            %����ԭʼ�źŵ�Ƶ��ͼ
title('ԭʼ�źŵ�Ƶ��ͼ');
subplot(235);plot(ff,absxx);
title('���ź�������Ƶ��ͼ');          %�����������źŵ�Ƶ��ͼ
%���е�ͨ�˲����˲�Ƶ��Ϊ0~200�����Ƶ��
indd2=1:800;                      %0Ƶ��߸�Ƶ��ϵ������
xx(indd2)=zeros(size(indd2));
indd2=1201:2000;
xx(indd2)=zeros(size(indd2));        %0Ƶ�ұ߸�Ƶϵ������
xden=ifft(xx);                     %�˲�����ź�������Ҷ��任
xden=abs(xden);                   %ȡ��ֵ
subplot(233);plot(xd);               %����С��ȥ�������ź�
title('С��ȥ�������ź�');
subplot(236);plot(xden);             %��������Ҷ����ȥ����ź�
title('����Ҷ����ȥ����ź�');

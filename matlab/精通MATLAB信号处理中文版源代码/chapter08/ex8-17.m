[l,h]=wfilters('db10','d');
low_construct=l;
L_fre=20;
%�˲�������
low_decompose=low_construct(end:-1:1);
%��ͨ�ֽ��˲���
for i_high=1:L_fre; %ȷ��h1(n)=(-1)^n,
%��ͨ�ؽ��˲���
if(mod(i_high,2)==0);
coefficient=-1;
else
coefficient=1;
end
high_construct(1,i_high)=low_decompose(1,i_high)*coefficient;
end
high_decompose=high_construct(end:-1:1);
%��ͨ�ֽ��˲���
L_signal=100;
%�źų���
n=1:L_signal;
%ԭʼ�źŸ�ֵ
f=10;
t=0.001;
y=10*cos(2*pi*50*n*t).*exp(-30*n*t)+ randn(size(t));
zero1=zeros(1,60);
%�źż������źŲ���
zero2=zeros(1,30);
noise=[zero1,3*(randn(1,10)-0.5),zero2];
y_noise=y+noise;
subplot(2,3,1);
plot(y);
title('ԭ�ź�');
grid on;
subplot(2,3,4);
plot(y_noise);
title('��������Ⱦ���ź�');
grid on;
check1=sum(high_decompose);
check2=sum(low_decompose);
check3=norm(high_decompose);
check4=norm(low_decompose);
l_fre=conv(y_noise,low_decompose);
%���
l_fre_down=dyaddown(l_fre); 
%��Ƶϸ��
h_fre=conv(y_noise,high_decompose);
h_fre_down=dyaddown(h_fre); 
%�źŸ�Ƶϸ��
subplot(2,3,2)
plot(l_fre_down);
title('С���ֽ�ĵ�Ƶϵ��');
grid on;
subplot(2,3,5);
plot(h_fre_down);
title('С���ֽ�ĸ�Ƶϵ��');
grid on;
% ���봦��
for i_decrease=31:44;
if abs(h_fre_down(1,i_decrease))>=0.000001
h_fre_down(1,i_decrease)=(10^-7);
end
end
l_fre_pull=dyadup(l_fre_down);
%0��ֵ
h_fre_pull=dyadup(h_fre_down);
l_fre_denoise=conv(low_construct,l_fre_pull);
h_fre_denoise=conv(high_construct,h_fre_pull);
l_fre_keep=wkeep(l_fre_denoise,L_signal); 
%ȡ��������Ĳ���,�������Ӱ��
h_fre_keep=wkeep(h_fre_denoise,L_signal);
sig_denoise=l_fre_keep+h_fre_keep; 
%������ź��ع�
%ƽ������
for j=1:2
for i=60:70;
sig_denoise(i)=sig_denoise(i-2)+sig_denoise(i+2)/2;
end;
end;
subplot(2,3,3)
plot(y);
title ('ԭ�ź�');
grid on;
subplot(2,3,6);
plot(sig_denoise);
title ('������ź�');
grid on;

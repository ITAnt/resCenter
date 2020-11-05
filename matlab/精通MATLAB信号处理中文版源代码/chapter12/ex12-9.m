clear all;
azi_num=3000; fr=2000;
lamda0=0.025; sigmav=0.5;
sigmaf=2*sigmav/lamda0;
rand('state',sum(100*clock));  %��������U(0-1)���������
d1=rand(1,azi_num);
rand('state',7*sum(200*clock)+3);
d2=rand(1,azi_num);
xi=2*sqrt(-2*log(d1)).*sin(2*pi*d2);  % �����Ҷ����ĸ�˹����~N(0,1)
coe_num=12;        %���˲���ϵ��,�ø���Ҷ����չ����
for n=0:coe_num
    coeff(n+1)=2*sigmaf*sqrt(pi)*exp(-4*sigmaf^2*pi^2*n^2/fr^2)/fr;
end
for n=1:2*coe_num+1
    if n<=coe_num+1
        b(n)=1/2*coeff(coe_num+2-n);
    else
        b(n)=1/2*coeff(n-coe_num);
    end
end
% ���ɸ�˹���Ӳ�
xxi=conv(b,xi);
xxi=xxi(coe_num*2+1:azi_num+coe_num*2);
xisigmac=std(xxi);
ximuc=mean(xxi);
yyi=(xxi-ximuc)/xisigmac;
muc=10;                  %��λֵ
sigmac=0.6;        %��״����
yyi=sigmac*yyi+log(muc); 
xdata=exp(yyi);        % ������̬�ֲ����Ӳ�����
num=100;  
maxdat=max(abs(xdata));
mindat=min(abs(xdata));
NN=hist(abs(xdata),num);
xpdf1=num*NN/((sum(NN))*(maxdat-mindat));  %��ֱ��ͼ���Ƶĸ����ܶȺ���
xaxis1=mindat:(maxdat-mindat)/num:maxdat-(maxdat-mindat)/num;
th_val=lognpdf(xaxis1,log(muc),sigmac);
subplot(211);plot(xaxis1,xpdf1);
hold on; plot(xaxis1,th_val,'r:');
title('�Ӳ����ȷֲ�');
xlabel('����'); ylabel('�����ܶ�');
signal=xdata;
signal=signal-mean(signal); %�������ܶ�,��ȥ��ֱ������
M=128;
psd_dat=pburg(real(signal),16,M,fr);
psd_dat=psd_dat/(max(psd_dat));  %��һ��
freqx=0:0.5*M;
freqx=freqx*fr/M;
subplot(212);plot(freqx,psd_dat); 
title('�Ӳ�Ƶ��');
xlabel('Ƶ��/Hz'); ylabel('�������ܶ�');
powerf=exp(-freqx.^2/(2*sigmaf.^2));
hold on; plot(freqx,powerf,'r:');

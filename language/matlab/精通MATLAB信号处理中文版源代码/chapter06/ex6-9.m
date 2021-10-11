randn('state',0);
noise=randn(40000,1);  %��̬��˹������
x=filter(1,[1 1/2 1/3 1/4],noise);
x=x(35904:40000);
%��������Ԥ�⺯��lpc������Ԥ��ϵ����������Ԥ������Լ�Ԥ����������ء�
a=lpc(x,3);
est_x=filter([0 -a(2:end)],1,x);  %�źŹ���
e=x-est_x;               %Ԥ�����
[acs,lags]=xcorr(e,'coeff');  %Ԥ������ACS
%�Ƚ�Ԥ���źź�ԭʼ�źţ���ͼ8-8��ʾ
subplot (211);
plot(1:97,x(3001:3097),1:97,est_x(3001:3097),'--');
title('�Ƚ�Ԥ���źź�ԭʼ�ź�'); 
xlabel('Sample Number');ylabel('Amplitude');
grid on;
%����Ԥ����������أ� 
subplot (212);
plot(lags,acs);
title('����Ԥ�����������');
xlabel('Lags');
ylabel('Normalized Value');
grid on;

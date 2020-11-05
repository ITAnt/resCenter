clear all;
dt=0.05;N=1024;
n=0:N-1; t=n*dt;       %ʱ������
f=n/(N*dt);            %Ƶ������
f1=3; f2=10;           %�źŵ�Ƶ�ʳɷ�
x=0.5*cos(2*pi*f1*t)+sin(2*pi*f2*t) +randn(1,N);
subplot(2,2,1);plot(t,x);  %����ԭʼ���ź�
title('ԭʼ�źŵ�ʱ����');xlabel('ʱ��/s');
y=fft(x);        %��ԭ�ź���FFT�任
xlim([0 12]);ylim([-1.5 1.5]);
subplot(2,2,2);plot(f,abs(y)*2/N);   %����ԭʼ�źŵ������
xlabel('Ƶ��/Hz');ylabel('���');
xlim([0 50]);title('ԭʼ�����');
ylim([0 0.8]);
f1=4;f2=8;     %Ҫ��ȥƵ�ʵ����޺�����
yy=zeros(1,length(y));   %������y��ͬ��Ԫ������
for m=0:N-1    %��Ƶ�����ڸ�Ƶ�ʷ�Χ�������NyquistƵ�ʵĲ���ȥ
    % С��NyquistƵ�ʵ��˲���Χ
    if (m/(N*dt)>f1 & m/(N*dt)<f2) | (m/(N*dt)>(1/dt-f2) & m/(N/dt)<(1/dt-f1));
    % ����NyquistƵ�ʵ��˲���Χ
    % 1/dtΪһ��Ƶ������
    yy(m+1)=0;        %���ڴ�Ƶ�ʷ�Χ�ڵ������Ϊ��
    else
        yy(m+1)=y(m+1);   %����Ƶ�ʷ�Χ�����������
    end
end
subplot(2,2,4);plot(f,abs(yy)*2/N)   %�����˲���������
xlim([0 50]);ylim([0 0.5]);
xlabel('Ƶ��/Hz');ylabel('���');
gstext=sprintf('��%4.1f-%4.1fHz��Ƶ�ʱ��˳�',f1,f2);
%���˲���Χ��ʾ��Ϊ����
title(gstext);
subplot(2,2,3);plot(t,real(ifft(yy)));
%�����˲������������ifft�任��ʱ���򲢻�ͼ
title('ͨ��IFFT�ص�ʱ����');
xlabel('ʱ��/s');
ylim([-0.6 0.6]);xlim([0 12]);

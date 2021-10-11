close all; %�ر�����ͼ��
clear all; %������б���
clc;
C=3.0e8;  %����(m/s)
RF=3.140e9/2;  %�״���Ƶ 1.57GHz
Lambda=C/RF;%�״﹤������
PulseNumber=16;   %�ز�������
BandWidth=2.0e6;  %�����źŴ��� ����B=1/�ӣ����������� 
TimeWidth=42.0e-6; %�����ź�ʱ��
PRT=240e-6;   % �״﷢�������ظ�����(s),240us��Ӧ1/2*240*300=36000�������ģ������
PRF=1/PRT;
Fs=2.0e6;  %����Ƶ��
NoisePower=-12;%(dB);%�������ʣ�Ŀ��Ϊ0dB��
SampleNumber=fix(Fs*PRT);%����һ���������ڵĲ�������480��
TotalNumber=SampleNumber*PulseNumber;%�ܵĲ�������480*16=��
BlindNumber=fix(Fs*TimeWidth);%����һ���������ڵ�ä��-�ڵ���������
 TargetNumber=4;%Ŀ�����
SigPower(1:TargetNumber)=[1 1 1 0.25];%Ŀ�깦��,������
TargetDistance(1:TargetNumber)=[3000 8025 15800 8025];%Ŀ�����,��λm   �������Ϊ[3000 8025 9000+(Y*10+Z)*200 8025]
 DelayNumber(1:TargetNumber)=fix(Fs*2*TargetDistance(1:TargetNumber)/C); TargetVelocity(1:TargetNumber)=[50 0 204 100];%Ŀ�꾶���ٶ� ��λm/s   TargetFd(1:TargetNumber)=2*TargetVelocity(1:TargetNumber)/Lambda; %����Ŀ��ಷ��Ƶ��2v/��
 number=fix(Fs*TimeWidth);%�ز��Ĳ�������=��ѹϵ������=��̬����Ŀ+1
if rem(number,2)~=0  %rem����
   number=number+1;
end   %��number��Ϊż��
 
for i=-fix(number/2):fix(number/2)-1
   Chirp(i+fix(number/2)+1)=exp(j*(pi*(BandWidth/TimeWidth)*(i/Fs)^2));%exp(j*fi)*��������������Chirp
end
coeff=conj(fliplr(Chirp));%��Chirp����ת���Ѹ������������ѹϵ��
figure(1);%��ѹϵ����ʵ��
plot(real(Chirp));axis([0 90 -1.5 1.5]);title('��ѹϵ��ʵ��');
SignalAll=zeros(1,TotalNumber);%����������ź�,����0
for k=1:TargetNumber-1 % ���β�������Ŀ��
   SignalTemp=zeros(1,SampleNumber);% һ��PRT
   SignalTemp(DelayNumber(k)+1:DelayNumber(k)+number)=sqrt(SigPower(k))*Chirp;   Signal=zeros(1,TotalNumber);
   for i=1:PulseNumber % 16���ز�����
      Signal((i-1)*SampleNumber+1:i*SampleNumber)=SignalTemp;   end
   FreqMove=exp(j*2*pi*TargetFd(k)*(0:TotalNumber-1)/Fs);%�������ٶ�*ʱ��=Ŀ��Ķ���������
   Signal=Signal.*FreqMove;%���϶������ٶȺ��16������1��Ŀ��
   SignalAll=SignalAll+Signal;%���϶������ٶȺ��16������4��Ŀ��
end
   fi=pi/3;
   SignalTemp=zeros(1,SampleNumber);% һ������
   SignalTemp(DelayNumber(4)+1:DelayNumber(4)+number)=sqrt(SigPower(4))*exp(j*fi)*Chirp;   Signal=zeros(1,TotalNumber);
   for i=1:PulseNumber
      Signal((i-1)*SampleNumber+1:i*SampleNumber)=SignalTemp;
   end
   FreqMove=exp(j*2*pi*TargetFd(4)*(0:TotalNumber-1)/Fs);%�������ٶ�*ʱ��=Ŀ��Ķ���������
   Signal=Signal.*FreqMove;
   SignalAll=SignalAll+Signal;
 
figure(2);
subplot(2,2,1);plot(real(SignalAll),'r-');title('Ŀ���źŵ�ʵ��');grid on;zoom on;
subplot(2,2,2);plot(imag(SignalAll));title('Ŀ���źŵ��鲿');grid on;zoom on;
SystemNoise=normrnd(0,10^(NoisePower/10),1,TotalNumber)+j*normrnd(0,10^(NoisePower/10),1,TotalNumber);
Echo=SignalAll+SystemNoise;% +SeaClutter+TerraClutter��������֮��Ļز�
for i=1:PulseNumber   %�ڽ��ջ�������,���յĻز�Ϊ0
      Echo((i-1)*SampleNumber+1:(i-1)*SampleNumber+number)=0; %����ʱ����Ϊ0
end

subplot(223);plot(real(Echo),'r-');title('�ܻز��źŵ�ʵ��,������Ϊ0');
subplot(224);plot(imag(Echo));title('�ܻز��źŵ��鲿,������Ϊ0');

pc_time0=conv(Echo,coeff);%pc_time0ΪEcho��coeff�ľ��
pc_time1=pc_time0(number:TotalNumber+number-1);%ȥ����̬�� number-1��
figure(3);%ʱ����ѹ����ķ���
subplot(221);plot(abs(pc_time0),'r-');title('ʱ����ѹ����ķ���,����̬��');%pc_time0��ģ������
subplot(222);plot(abs(pc_time1));title('ʱ����ѹ����ķ���,����̬��');%pc_time1��ģ������
Echo_fft=fft(Echo,8192);%��Ӧ����TotalNumber+number-1��FFT, coeff_fft=fft(coeff,8192);
pc_fft=Echo_fft.*coeff_fft;
pc_freq0=ifft(pc_fft);
subplot(223);plot(abs(pc_freq0(1:TotalNumber+number-1)));title('Ƶ����ѹ����ķ���,��ǰ��̬��');
subplot(224);plot(abs(pc_time0(1:TotalNumber+number-1)-pc_freq0(1:TotalNumber+number-1)),'r');
title('ʱ���Ƶ����ѹ�Ĳ��');
pc_freq1=pc_freq0(number:TotalNumber+number-1);
for i=1:PulseNumber
      pc(i,1:SampleNumber)=pc_freq1((i-1)*SampleNumber+1:i*SampleNumber); end
figure(4);
subplot(131);
plot(abs(pc(1,:)));title('Ƶ����ѹ����ķ���,û����̬��');
for i=1:PulseNumber-1  %��������������һ������
   mti(i,:)=pc(i+1,:)-pc(i,:);
end
subplot(132);mesh(abs(mti));title('MTI  result');
 mtd=zeros(PulseNumber,SampleNumber);
for i=1:SampleNumber
   buff(1:PulseNumber)=pc(1:PulseNumber,i);
   buff_fft=fft(buff);
   mtd(1:PulseNumber,i)=buff_fft(1:PulseNumber);
end
subplot(133);mesh(abs(mtd));title('MTD  result');
coeff_fft_c=zeros(1,2*8192);
for i=1:8192
    coeff_fft_c(2*i-1)=real(coeff_fft(i));
    coeff_fft_c(2*i)=imag(coeff_fft(i));
end
echo_c=zeros(1,2*TotalNumber);
for i=1:TotalNumber
    echo_c(2*i-1)=real(Echo(i));
    echo_c(2*i)=imag(Echo(i));
end

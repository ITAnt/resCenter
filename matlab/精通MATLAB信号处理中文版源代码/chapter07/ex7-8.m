clear all;
Fs=1000;
NFFT=256;
p=0.98;     %��������
[b,a]=ellip(5,2,50,0.2);   %���5����Բ���˲���
r=randn(4096,1);
x=filter(b,a,r);        %�԰������˲��õ��ź�x
psd(x,NFFT,Fs,[],0,p);   %PSD����
xlabel('Ƶ��/Hz');ylabel('��Թ������ܶ�(dB/Hz)');

clear all;
wp=0.3*pi; 
ws=0.4*pi;   % �����˲�����ֹƵ��ͨ������
Rp=2; 
Rs=30;            %���˥��
Fs=100;  
Ts=1/Fs;    %����Ƶ��
Nn=256;              %����freqz���õ�Ƶ�ʵ���
wp=2/Ts*cos(wp/2);  
ws=2/Ts*cos(ws/2);  %��Ƶ�ʹ�ʽ����ת��
[n,wn]=ellipord(wp,ws,Rp,Rs,'s');  %����ģ���˲�������С����
[z,p,k]=ellipap(n,Rp,Rs);          %���ģ��ԭ���˲���
[Bap,Aap]=zp2tf(z,p,k);            %��㼫��������ʽת��Ϊ���ݺ�����ʽ
[b,a]=lp2lp(Bap,Aap,wn);          %��ͨת��Ϊ��ͨ�˲�����Ƶ��ת��
[bz,az]=bilinear(b,a,Fs);         %����˫���Ա任���õ������˲������ݺ���
[h,f]=freqz(bz,az,Nn,Fs);         %���Ƶ������
subplot(121);plot(f,20*log10(abs(h)));
xlabel('Ƶ��/Hz');ylabel('���/dB');
grid on;
subplot(122);plot(f,180/pi*unwrap(angle(h)));
xlabel('Ƶ��/Hz');ylabel('��λ/^o');
grid on;

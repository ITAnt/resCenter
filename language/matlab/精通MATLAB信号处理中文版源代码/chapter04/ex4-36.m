clear all;
a = [1 0.5 2];      %�˲������ݺ�����ĸ����ʽϵ��
b = [0.4 0.5 2];    %�˲������ݺ������Ӷ���ʽϵ��
w = logspace(-1,1); 
freqs(b,a,w)
h = freqs(b,a,w);
mag = abs(h);
phase = angle(h);
subplot(2,1,1), loglog(w,mag)      %����˫����������Ʒ�Ƶ��Ӧ
grid on;
xlabel('��Ƶ��');ylabel('���');
subplot(2,1,2), semilogx(w,phase)   %���ð�����������Ƶ��Ӧ
grid on;
xlabel('��Ƶ��');ylabel('��λ');

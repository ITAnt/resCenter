B=[1 -1.3];
A =[1 0];
[H,w]=freqz(B,A,400,'whole');
Hf=abs(H);
Hx=angle(H);
clf
subplot(121)
plot(w,Hf)
title('��ɢϵͳ��Ƶ��������')
xlabel('Ƶ��');ylabel('����')
grid on
subplot(122)
plot(w,Hx)
xlabel('Ƶ��');ylabel('����')
grid on
title('��ɢϵͳ��Ƶ��������')

clear all;
lshaar=liftwave('haar');
%��ӵ���������
els={'p',[-0.25 0.25],0}
lsnew=addlift(lshaar,els);
load noisdopp;
x= noisdopp;
xDec=lwt2(x,lsnew,2)
% ��ȡ��һ��ĵ�Ƶϵ��
ca1=lwtcoef2('ca',xDec,lsnew,2,1)
a1=lwtcoef2('a',xDec,lsnew,2,1)
a2=lwtcoef2('a',xDec,lsnew,2,2)
h1=lwtcoef2('h',xDec,lsnew,2,1)
v1=lwtcoef2('v',xDec,lsnew,2,1)
d1=lwtcoef2('d',xDec,lsnew,2,1)
h2=lwtcoef2('h',xDec,lsnew,2,2)
v2=lwtcoef2('v',xDec,lsnew,2,2)
d2=lwtcoef2('d',xDec,lsnew,2,2)
[cA,cD]=lwt(x,lsnew);
figure(1);
subplot(231);
plot(x);
title('ԭʼ�ź�');
subplot(232);
plot(cA);
title('����С���ֽ�ĵ�Ƶ�ź�');
subplot(233);
plot(cD);
title('����С���ֽ�ĸ�Ƶ�ź�');
%ֱ��ʹ��HaarС������2������С���ֽ�
[cA,cD]=lwt(x,'haar',2);
subplot(234);
plot(x);
title('ԭʼ�ź�');
subplot(235);
plot(cA);
title('2������С���ֽ�ĵ�Ƶ�ź�');
subplot(236);
plot(cD);
title('2������С���ֽ�ĸ�Ƶ�ź�');

close all;
clear all;
clc;
%��ȡ��Ƶ�ź�
[a,fs,nbit]=wavread('qq.wav');
subplot(3,1,1)
plot(a);
title('ԭʼ�����ź�');
%��������ĵ������ظ�����
m=length(a);
chongfudian=160;								%ѡȡ�ظ��ĵ���Ϊ64
L=250-chongfudian;
%�ж��ܹ��ж��ٸ������Ķ�
nn=(m-90)/L;
N=ceil(nn); 
count=zeros(1,N);
%���ڹ����ͳ��
%theshΪһ���ޣ����ԣ�-thresh��thresh��֮��ĵ㾭�й����ͳ��
thresh=0.000010;
for n=1:N-2
    for k=L*n : (L*n+250)
        if  a(k)>thresh&a(k+1)<-thresh | a(k)<-thresh&a(k+1)>thresh       
            count(n)=count(n)+1;
        end 
    end
end
%���һ�����ͳ��
for j=k:m-1
        if  a(j)>thresh&a(j+1)<-thresh  | a(j)<-thresh&a(j+1)>thresh       
            count(N)=count(N)+1;
        end 
end
%�����ͳ��ͼ
subplot(3,1,2)
plot(count);
title('��������ͳ��ͼ');
%�����źŵķֶ���ȡ
%ѡȡ���ʵ���ֵ
j=0;
for n1=1:N
    j=j+1;
    if count(n1)>0.0003
        x(j)=count(n1);
    else 
        x(j)=0;    
    end
end
subplot(3,1,3)
plot(x);
title('ѡȡ�ʵ���ֵ��ķָ�ͼ');
%��ȡ��������Ƭ��
pianduan=0;									%ȷ���ڼ���Ƭ��
qidian=0;										%�ֶ�ʱȷ��ÿһ��Ƭ�ε�����־
for n2=1:N
    if x(n2)>0
        for i=1:L
            a2((n2-1-qidian)*L+i)=a((n2-1)*L+i);  
        end
        if x(n2)>0 &x(n2+1)==0 & x(n2+2)==0		%ÿһƬ�ν������ж�
                pianduan=pianduan+1;
                a2=0;
                qidian=n2-1;
        end
        switch pianduan						%��ÿһƬ��ת����MP3
            case 0							%��ʽ������
                 wavwrite(a2,fs, nbit ,'ODD0.mp3')
             case 1  
                 wavwrite(a2,fs, nbit ,'ODD1.mp3')
             case 2  
                 wavwrite(a2,fs, nbit ,'ODD2.mp3')
             case 3  
                 wavwrite(a2,fs, nbit ,'ODD3.mp3')
             case 4  
                 wavwrite(a2,fs, nbit ,'ODD4.mp3') 
             case 5  
                 wavwrite(a2,fs, nbit ,'ODD5.mp3') 
             case 6  
                 wavwrite(a2,fs, nbit ,'ODD6.mp3') 
             case 7  
                 wavwrite(a2,fs, nbit ,'ODD7.mp3')
             case 8  
                 wavwrite(a2,fs, nbit ,'ODD8.mp3')
             case 9 
                 wavwrite(a2,fs, nbit ,'ODD9.mp3')
            otherwise 
                 disp('error')  
       end      
    end
end
%�����ÿ�������Ĳ������
figure;
[a0,fs,nbit]=wavread('ODD0.mp3');
subplot(2,2,1)
plot(a0);
[a1,fs,nbit]=wavread('ODD1.mp3');
subplot(2,2,2)
plot(a1);
[a2,fs,nbit]=wavread('ODD2.mp3');
subplot(2,2,3)
plot(a2);
[a3,fs,nbit]=wavread('ODD3.mp3');
subplot(2,2,4)
plot(a3);

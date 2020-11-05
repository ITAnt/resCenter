clear all;
n=0:0.02:4;  %Ƶ�ʵ�
for i=1:4   %ȡ4���˲���
    switch i
        case 1, N=1;
        case 2; N=3;
        case 3; N=5;
        case 4; N=7;
    end
    Rs=20; 
    [z,p,k]=cheb2ap(N,Rs);  %���Chebyshev II��ģ��ԭ���˲���
    [b,a]=zp2tf(z,p,k); %����㼫��������ʽת��Ϊ���ݺ�����ʽ
    [H,w]=freqs(b,a,n); %��nָ����Ƶ�ʵ����Ƶ����Ӧ
    magH2=(abs(H)).^2;  %�������ݺ�������ƽ��
    posplot=['2,2',num2str(i)];  %������iת��Ϊ�ַ���,��'2,2'�ϲ�������posplot
    subplot(posplot);
    plot(w,magH2);
   title(['N=' num2str(N)]);  %������Nת��Ϊ�ַ���'N='�ϲ���Ϊ����
   xlabel('w/wc');  %��ʾ������
   ylabel('�б�ѩ��II�� |H(jw)|^2');  % ��ʾ������
   grid on;
end

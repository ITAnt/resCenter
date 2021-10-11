clear all;
randn('seed',234343285);        %��������źŵ�״̬
s =4 + kron(ones(1,8),[1 -1]) + ((1:16).^2)/24 + 0.3*randn(1,16);
% ��С������db2���źŽ��е��߶�һάС���ֽ�
[ca1,cd1] = dwt(s,'db2'); 
subplot(221); plot(ca1); 
title('�ع���ͨ'); 
subplot(222); plot(cd1); 
title('�ع���ͨ');
ss = idwt(ca1,cd1,'db2'); 
err = norm(s-ss);    
subplot(212); plot([s;ss]'); 
title('ԭʼ���ع�����źŵ����'); 
xlabel(['�ع���� ',num2str(err)])
[Lo_R,Hi_R] = wfilters('db2','r'); 
ss = idwt(ca1,cd1,Lo_R,Hi_R);

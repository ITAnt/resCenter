n=input('input  n=');	%��������
while n~=1			
      r=rem(n,2);	%��n/2������
      if r ==0
         n=n/2	%��һ�ֲ���
      else
         n=3*n+1	%�ڶ��ֲ���
      end
end

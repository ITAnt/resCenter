price=input('��������Ʒ�۸�');
switch fix(price/100) 
   case {0,1}             %�۸�С��200
      rate=0;
   case {2,3,4}            %�۸���ڵ���200��С��500
      rate=0.1/100;
   case num2cell(5:9)       %�۸���ڵ���500��С��1000
      rate=0.2/100;
   case num2cell(10:24)     %�۸���ڵ���1000��С��2500
      rate=0.3/100;
 
end
price=price*(1-rate)              %�����Ʒʵ�����ۼ۸�

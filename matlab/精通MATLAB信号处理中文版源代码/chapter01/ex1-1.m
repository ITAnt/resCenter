x=linspace(0,3*pi,20);
y=cos(x)+sin(x);
e=std(y)*ones(size(x))    %��׼��
errorbar(x,y,e)

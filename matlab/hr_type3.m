% III型滤波器的幅度响应如下
function[Hr,w,c,L] = hr_type3(h)
% 计算所设计的III型滤波器的振幅响应
% Hr = 振幅响应
% b  = 3 型滤波器的系数
% L = Hr的阶次
% h = 3型滤波器的单位冲激响应
M = length(h);
L  = (M-1)/2;
c = [2*h(L+1:-1:1)];
n = [0:1:L];
w = [0:1:500]'*2*pi/500;
Hr = sin(w*n)*c';
function [x,y] = Lab2Pos(lab,m,n)
%---------------------------------------
%Name:  [x,y] = Lab2Pos(lab,n)
%Desc:  由标号获得元素在矩阵中的行列数
%Para:  lab  元素标号，列优先的顺序编号
%       m,n  矩阵的维  
%Return:x,y  元素在矩阵中的行列数
%---------------------------------------
l = lab-1;
x = floor(l/m)+1;
y = mod(l,m)+1;
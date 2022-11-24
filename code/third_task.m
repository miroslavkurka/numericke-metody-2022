#Released under MIT License 
#Copyright (c) 2022 Miroslav Kurka
pkg load symbolic

i=1;
x_current=1;
syms f(t)
f(t)= cos(2*t)-3*sin(t)+4*t-2
df(t)= diff(f(t))
x_next=x_current - f(x_current)/df(x_current)

while abs(x_next-x_current) > 10^-6
  x_current=x_next;
  x_next=x_current - double(f(x_current))/double(df(x_current));
  i++;
end
format long
my_result=double(x_next)
matlab_calculation_result= fsolve(matlabFunction(f(t)),t=1)
i

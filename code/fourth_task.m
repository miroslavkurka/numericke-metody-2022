#Released under MIT License
#Copyright (c) 2022 Miroslav Kurka
pkg load symbolic

syms f(x);
f(x)= x/(4+x^2);
my_func=matlabFunction(f(x)); # cast symbolic to matlab func 
upper_int=5;
lower_int=0;
epsilon=10^-6;
number_of_intervals=20; # must be 2*n due to simpson method 

h=(upper_int-lower_int)/number_of_intervals;
intervals= lower_int:h:upper_int; # divide by equally measured bins
f_i=arrayfun(my_func,intervals); # map function to array


I_simpson = (h/3)*(f_i(1)+2*sum(f_i(3:2:end-2))+4*sum(f_i(2:2:end-1))+f_i(end));
I_trapezoid = (h/2)*(f_i(1)+2*sum(f_i(2:end-1))+f_i(end));
I_simpson_previous=0;
I_trapezoid_previous=0;


while abs(I_trapezoid-I_trapezoid_previous) > epsilon && abs(I_simpson-I_simpson_previous) > epsilon
  I_simpson_previous=I_simpson;
  I_trapezoid_previous=I_trapezoid;
  number_of_intervals=number_of_intervals*2;
  h=(upper_int-lower_int)/number_of_intervals;
  intervals= lower_int:h:upper_int;
  f_i=arrayfun(my_func,intervals);
  I_simpson = (h/3)*(f_i(1)+2*sum(f_i(3:2:end-2))+4*sum(f_i(2:2:end-1))+f_i(end));
  I_trapezoid = (h/2)*(f_i(1)+2*sum(f_i(2:end-1))+f_i(end));
endwhile

format long
I_simpson
I_trapezoid
number_of_intervals
matlab_trapezoid=trapz(intervals,f_i)
matlab_simpson=quadv(my_func,0,5)
analytical_solution=(1/2 * log(4+5**2))-(1/2 * log(4))
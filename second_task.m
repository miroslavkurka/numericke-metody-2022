#Released under MIT License 
#Copyright (c) 2022 Miroslav Kurka
pkg load symbolic
t_i = [2 2.5 3 3.5 4 4.5 5];
y_i = [7.14 6.56 5.98 5.55 5.71 6.01 6.53];

n=length(t_i);

# fill the matrix of "forward difference" or delta matrix
for_diff=zeros(n,n);
for i=1:n
  for_diff(i,1)=y_i(i);
endfor


for j=2:n
    for i=1:n-j+1
        
        for_diff(i,j)=for_diff(i+1,j-1)-for_diff(i,j-1);
    endfor
endfor
for_diff;
# get coefficents
coefficients=zeros(1,length(y_i));
facts=factorial(1:n);
h=0.5 # equidistal difference t_i(n)-t_i(n-1) which is 0.5

coefficients(1)=y_i(1)
for i=2:n
    coefficients(i)=for_diff(1,i)./(facts(i-1)*h^(i-1));
endfor
coefficients

# define my polynomial of 
syms N(x)
N(x)=coefficients(1)+coefficients(2)*(x-t_i(1))+coefficients(3)*((x-t_i(1))*(x-t_i(2)))+coefficients(4)*((x-t_i(1))*(x-t_i(2))*(x-t_i(3)))+coefficients(5)*((x-t_i(1))*(x-t_i(2))*(x-t_i(3))*(x-t_i(4)))+coefficients(6)*((x-t_i(1))*(x-t_i(2))*(x-t_i(3))*(x-t_i(4))*(x-t_i(5)))+coefficients(7)*((x-t_i(1))*(x-t_i(2))*(x-t_i(3))*(x-t_i(4))*(x-t_i(5))*(x-t_i(6)))
#syms test
#test=#coefficients(7)*((x-t_i(1))*(x-t_i(2))*(x-t_i(3))*(x-t_i(4))*(x-t_i(5))*(x-t_i(6)))

my_function=simplify(N(x))

syms L(x) # polynomial from the first hw
L(x) = 5*x+1 # this is just template, because my polynomial from hw1 isnt precise enough:

#p_eval=polyval(my,t_i);
h=ezplot(my_function,[0, 10]);
X = get(h,'XData');
Y = get(h,'YData');
hold on
plot(X,Y)
set(gca, 'XLim', [0 10], 'YLim', [4 15]);
plot(t_i,y_i,'x')
xlabel("t_i")
ylabel("y_i")
hold off


# part b Horner vs normal
eval_func=matlabFunction(my_function); # cast symbolic expression to function handle else the feval wont work
n_dimension=1000
rand_val=rand(n_dimension,n_dimension);
tic
for i=1:n_dimension
    for j=1:n_dimension
      
        feval(eval_func,rand_val(i,j));
    endfor
endfor
toc

horner_polynomial=matlabFunction(horner(my_function))  # convert to horner form and cast symbolic expression to function handle else the feval wont work
tic
for i=1:n
    for j=1:n
    
        feval(horner_polynomial,rand_val(i,j));
    endfor
endfor
toc

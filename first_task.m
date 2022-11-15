#Released under MIT License 
#Copyright (c) 2022 Miroslav Kurka
__mfile_encoding__ ("utf-8")
t_i = [2 2.5 3 3.5 4 4.5 5]; # t_i is our x_i value
y_i = [7.14 6.56 5.98 5.55 5.71 6.01 6.53];
residues=[];
#n= length(t_i) 
n=columns(t_i);
k= n-1; # degree of the polynomial
# init matrices
V=zeros(n,n);
Y=zeros(n,1);


    
# fill Y matrix

for i=1:n
   Y(i)=sum(y_i.*(t_i.^(i-1))); # i-1 so we can get t_i^0 = 1, hence the n not k in the for loop range
endfor

# fill the V matrix

 
V(1,1)=n;

for i=1:n
  for j=1:n
      V(i,j)=sum(t_i.^(i+j-2));
    endfor
endfor
    

st=7;
# get each degree polynomial by slicing the V 
for pos=1:st
    a_coefficients=0;
    if st-pos==0, break; end # end for loop since 0x0 doesnt exist, and indexing is nightmare in matlab
    V=V(1:st-pos+1,1:st-pos+1) # reverse slicing, we reduce matrix from to 6x6 to 5x5 ...
    Y=Y(1:st-pos+1)
    a_coefficients=V\Y
    lst_func=polyval(flip(a_coefficients),t_i);
    residues(pos)= sum((y_i-lst_func).^2);
endfor

residues=flip(residues)
poly_degrees=(1:st-1);
plot(poly_degrees,residues)
grid on
hold on


# task b) compare with polyfit 
# The graph is not good comparison since values are almost the same
matlab_residues=[];

for i=1:6 
    a_matlab_coefficients=polyfit(t_i,y_i,i);
    mat_func=polyval(a_matlab_coefficients,t_i);
    matlab_residues(i)=sum((y_i-mat_func).^2);
endfor

# I put the differences here 
result= abs(residues-matlab_residues)

plot(poly_degrees, matlab_residues)
legend("Our Method","MATLAB polyfit")
xlabel("Degrees of polynomial")
ylabel("Residue")
hold off


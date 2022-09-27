mat1=randn(4,5)
mat2=randn(4,5)
result=zeros(4,5)

for i=1:4
	for k=1:5
    if ((mat1(i,k)>=0) || (mat2(i,k)>=0))
		  result(i,k)=0
		else
      result(i,k)= mat1(i,k)+mat2(i,k)
    endif
  endfor
endfor

function ejemplo_riangular()
  clc; clear;
  A=[1 1 -1 3;0 -1 -1 -5;0 0 3 13;0 0 0 -13];
  b=[4 -7 13 -13].';
  x=sust_atras(A,b)
  %Si queremos calcular el error
  r=b-A*x;
  err=norm(r)
end

function x=sust_atras(A,b)
  n=size(A,1);
  x=zeros(n,1);

  for i=n:-1:1
    aux=0;
    for j=i+1:n
      aux=aux+A(i,j)*x(j);
    endfor
    x(i)=(1/A(i,i))*(b(i)-aux);
  endfor

end

function [At,bt]=eliminacion_gaussiana(A,b)
  n=size(A,1);
  At=A;
  bt=b;
  for k=1:n-1
    for i=k+1:n
      m= At(i,k)/At(k,k);
      for j=k:n
        At(i,j)=At(i,j)-m*At(k,j);
      endfor
    endfor
    bt(i)=bt(i)-m*bt(k);
  endfor
end

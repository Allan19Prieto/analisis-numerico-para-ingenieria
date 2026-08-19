function ejemploNewton()

  clc; clear;

  f='exp(x)-2*x-10';
  fp='exp(x)-2';
  x0=1;
  tol=1e-10;
  iterMax=1000;

  disp('---Usando Symbolic---')
  tic
  [xk,k,erk,conv]=nr(f,x0,tol,iterMax)
  t1=toc

  disp('---Sin usar Symbolic---')
  tic
  [xk,k,erk,conv]=nrD(f,fp,x0,tol,iterMax)
  t2=toc
end

function [xk,k,erk,conv]=nr(f,x0,tol,iterMax)

  pkg load symbolic

   % Funcion numerica
  fn=str2func(['@(x)' f]); %f(x) numerico

  % Funcion simbolica
  fs=sym(f);

  % Derivada simbolica
  fsD=diff(fs);


  fnD=function_handle(fsD); %f'(x) numerico

  xk=x0;
  k=0;
  erk=abs(fn(xk));

  while (k<iterMax && erk>tol)
    k=k+1;
    xk=xk-fn(xk)/fnD(xk);
    erk=abs(fn(xk));
  endwhile

  if k==iterMax
    conv='No converge';
  else
    conv='Si converge';
  endif

end

function [xk,k,erk,conv]=nrD(f,fp,x0,tol,iterMax)

  fn=str2func(['@(x)' f]); %f(x) numerico
  fnD=str2func(['@(x)' fp]); %f'(x) numerico

  xk=x0;
  k=0;
  erk=abs(fn(xk));
  while and(k<iterMax,erk>tol)
    k=k+1;
    xk=xk-fn(xk)/fnD(xk);
    erk=abs(fn(xk));
  endwhile

  if k==iterMax
    conv='No converge';
  else
    conv='Si converge';
  endif

end



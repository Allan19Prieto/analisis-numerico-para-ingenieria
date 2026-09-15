function steffensen ()
    clc; clear;

    f = 'exp(x)-2*x-10';
    x0=2;
    tol = 1e-10;
    iterMax = 1000;

    disp('---- Steffenen ----')
    tic
    [xk,k,erk,conv]=stff(f,x0,tol,iterMax)
    t1=toc
end

function [xk,k,erk,conv]=stff(f,x0,tol,iterMax)
  fn = str2func(['@(x)' f]);
  k = 0;
  erk = abs(fn(x0));
  while (k<iterMax && erk>tol)
    k = k + 1;
    xk = x0 - (fn(x0)^2)/(fn(x0+fn(x0))-fn(x0));
    x0 = xk;
    erk = abs(fn(xk));
  endwhile

  if k==iterMax
    conv = 'NO converge';
  else
    conv = 'Converge';
  endif
end

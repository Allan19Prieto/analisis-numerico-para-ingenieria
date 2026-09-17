function secante ()
    clc; clear;

    f = 'exp(x)-2*x-10';
    x0=2;
    x1=4;
    tol = 1e-10;
    iterMax = 1000;

    disp('---- Secante ----')
    tic
    [xk,k,erk,conv]=sec(f,x0,x1,tol,iterMax)
    t1=toc
end

function [xk,k,erk,conv]=sec(f,x0,x1,tol,iterMax)
  fn = str2func(['@(x)' f]);
  k = 0;
  erk = abs(fn(x1));
  while (k<iterMax && erk>tol)
    k = k + 1;
    xk = x1 - fn(x1)*(x1-x0)/(fn(x1)-fn(x0));
    x0 = x1;
    x1 = xk;
    erk = abs(fn(xk));
  endwhile

  if k==iterMax
    conv = 'NO converge';
  else
    conv = 'Si Converge';
  endif
end

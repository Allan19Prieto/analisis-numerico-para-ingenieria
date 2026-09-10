function newtonRaphson ()
    clc; clear;

    f = 'exp(x)-2*x-10';
    x0 = 1;
    tol = 1e-10;
    iterMax = 1000;

    disp('----- Utilizando simbolic---')
    tic
    [xk,k,erk,conv] = nr(f,x0,tol,iterMax)
    t1=toc

  end

  function [xk,k,erk,conv] = nr(f,x0,tol,iterMax)

      pkg load symbolic

      fn = str2func(['@(x)', f]);
      fs = sym(fn);
      fsD = diff(fs);
      fnD = matlabFunction(fsD);

      xk = x0;
      k = 0;
      erk = abs(fn(xk));

      while (k<iterMax && erk>tol)
        k = k + 1;
        xk = xk - (fn(xk)/fnD(xk));
        erk = abs(fn(xk));
      endwhile

      if k == iterMax
        conv = 'No converge';
       else
        conv = 'Converge';
      endif
  end

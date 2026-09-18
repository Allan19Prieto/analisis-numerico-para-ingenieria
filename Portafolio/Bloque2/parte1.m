  1;

% =====================================================================
% PORTAFOLIO COMPUTACIONAL - BLOQUE 2
% PARTE I: IMPLEMENTACION DE METODOS PARA SISTEMAS LINEALES
%
% Para cargar las funciones desde parte2.m o parte3.m utilice:
%   source("parte1.m");
%
% El archivo implementa explicitamente los siguientes metodos:
%   1. Eliminacion Gaussiana
%   2. Factorizacion LU (Doolittle)
%   3. Factorizacion de Cholesky
%   4. Factorizacion QR (Gram-Schmidt modificado)
%   5. Metodo de Thomas
%   6. Metodo de Jacobi
%   7. Metodo de Gauss-Seidel
%   8. Metodo del Gradiente Conjugado
% =====================================================================


% ---------------------------------------------------------------------
% 1. ELIMINACION GAUSSIANA
% Resuelve Ax=b mediante eliminacion hacia adelante y sustitucion
% regresiva. Se supone que los pivotes son distintos de cero.
% ---------------------------------------------------------------------
function x = eliminacion_gaussiana(A,b)
  n = size(A,1);
  At = A;
  bt = b;

  % Eliminacion hacia adelante
  for k = 1:n-1
    for i = k+1:n
      m = At(i,k)/At(k,k);

      for j = k:n
        At(i,j) = At(i,j)-m*At(k,j);
      endfor

      bt(i) = bt(i)-m*bt(k);
    endfor
  endfor

  % Sustitucion regresiva
  x = zeros(n,1);
  x(n) = bt(n)/At(n,n);

  for i = n-1:-1:1
    suma = 0;

    for j = i+1:n
      suma = suma+At(i,j)*x(j);
    endfor

    x(i) = (bt(i)-suma)/At(i,i);
  endfor
endfunction


% ---------------------------------------------------------------------
% 2. FACTORIZACION LU - METODO DE DOOLITTLE
% Construye A=LU, donde L tiene diagonal unitaria. Luego resuelve
% Ly=b mediante sustitucion progresiva y Ux=y mediante sustitucion
% regresiva.
% ---------------------------------------------------------------------
function x = factorizacion_LU(A,b)
  n = size(A,1);
  L = eye(n);
  U = zeros(n,n);

  % Construccion explicita de L y U
  for k = 1:n

    % Fila k de U
    for j = k:n
      suma = 0;

      for s = 1:k-1
        suma = suma+L(k,s)*U(s,j);
      endfor

      U(k,j) = A(k,j)-suma;
    endfor

    % Columna k de L debajo de la diagonal
    for i = k+1:n
      suma = 0;

      for s = 1:k-1
        suma = suma+L(i,s)*U(s,k);
      endfor

      L(i,k) = (A(i,k)-suma)/U(k,k);
    endfor
  endfor

  % Sustitucion progresiva: Ly=b
  y = zeros(n,1);

  for i = 1:n
    suma = 0;

    for j = 1:i-1
      suma = suma+L(i,j)*y(j);
    endfor

    y(i) = (b(i)-suma)/L(i,i);
  endfor

  % Sustitucion regresiva: Ux=y
  x = zeros(n,1);

  for i = n:-1:1
    suma = 0;

    for j = i+1:n
      suma = suma+U(i,j)*x(j);
    endfor

    x(i) = (y(i)-suma)/U(i,i);
  endfor
endfunction


% ---------------------------------------------------------------------
% 3. FACTORIZACION DE CHOLESKY
% Construye A=L*L' y resuelve Ly=b y L'x=y. Se supone que A es
% simetrica y positiva definida.
% ---------------------------------------------------------------------
function x = metodo_cholesky(A,b)
  n = size(A,1);
  L = zeros(n,n);

  % Construccion de la matriz triangular inferior L
  for i = 1:n
    suma = 0;

    for k = 1:i-1
      suma = suma+(L(i,k))^2;
    endfor

    L(i,i) = sqrt(A(i,i)-suma);

    for j = i+1:n
      suma = 0;

      for k = 1:i-1
        suma = suma+L(j,k)*L(i,k);
      endfor

      L(j,i) = (A(j,i)-suma)/L(i,i);
    endfor
  endfor

  % Sustitucion progresiva: Ly=b
  y = zeros(n,1);

  for i = 1:n
    suma = 0;

    for j = 1:i-1
      suma = suma+L(i,j)*y(j);
    endfor

    y(i) = (b(i)-suma)/L(i,i);
  endfor

  % Sustitucion regresiva: L'x=y
  x = zeros(n,1);

  for i = n:-1:1
    suma = 0;

    for j = i+1:n
      suma = suma+L(j,i)*x(j);
    endfor

    x(i) = (y(i)-suma)/L(i,i);
  endfor
endfunction


% ---------------------------------------------------------------------
% 4. FACTORIZACION QR - GRAM-SCHMIDT MODIFICADO
% Construye A=QR, donde las columnas de Q son ortonormales y R es
% triangular superior. Luego resuelve Rx=Q'b.
% ---------------------------------------------------------------------
function x = metodo_QR(A,b)
  n = size(A,1);
  Q = zeros(n,n);
  R = zeros(n,n);

  % Gram-Schmidt modificado
  for j = 1:n
    v = A(:,j);

    for i = 1:j-1
      R(i,j) = Q(:,i)'*v;
      v = v-R(i,j)*Q(:,i);
    endfor

    R(j,j) = norm(v,2);
    Q(:,j) = v/R(j,j);
  endfor

  % Calculo de y=Q'b
  y = Q'*b;

  % Sustitucion regresiva: Rx=y
  x = zeros(n,1);

  for i = n:-1:1
    suma = 0;

    for j = i+1:n
      suma = suma+R(i,j)*x(j);
    endfor

    x(i) = (y(i)-suma)/R(i,i);
  endfor
endfunction


% ---------------------------------------------------------------------
% 5. METODO DE THOMAS
% Resuelve un sistema tridiagonal Ax=d mediante los vectores p y q.
% Se supone que A es tridiagonal y que los denominadores son no nulos.
% ---------------------------------------------------------------------
function x = metodo_thomas(A,d)
  n = size(A,1);
  b = diag(A);
  c = diag(A,1);
  a = [0; diag(A,-1)];

  p = zeros(n-1,1);
  q = zeros(n,1);

  p(1) = c(1)/b(1);
  q(1) = d(1)/b(1);

  for i = 2:n-1
    aux = b(i)-p(i-1)*a(i);
    p(i) = c(i)/aux;
    q(i) = (d(i)-q(i-1)*a(i))/aux;
  endfor

  q(n) = (d(n)-q(n-1)*a(n))/(b(n)-p(n-1)*a(n));

  % Sustitucion regresiva
  x = zeros(n,1);
  x(n) = q(n);

  for i = n-1:-1:1
    x(i) = q(i)-p(i)*x(i+1);
  endfor
endfunction


% ---------------------------------------------------------------------
% 6. METODO DE JACOBI
% Retorna:
%   xk   aproximacion obtenida
%   erk  residuo ||A*xk-b||_2
%   k    numero de iteraciones ejecutadas
%   conv 1 si alcanza la tolerancia; 0 en caso contrario
% ---------------------------------------------------------------------
function [xk,erk,k,conv] = metodo_Jacobi(A,b,x0,tol,iterMax)
  d = diag(A);
  Dinv = diag(1./d);
  R = A-diag(d);
  Tj = -Dinv*R;
  cj = Dinv*b;

  xk = x0;
  erk = norm(A*xk-b,2);
  k = 0;
  conv = 0;

  if erk < tol
    conv = 1;
    return;
  endif

  for k = 1:iterMax
    xk = Tj*xk+cj;
    erk = norm(A*xk-b,2);

    if erk < tol
      conv = 1;
      return;
    endif
  endfor
endfunction


% ---------------------------------------------------------------------
% 7. METODO DE GAUSS-SEIDEL
% En cada componente utiliza inmediatamente los valores actualizados de
% la iteracion actual y conserva los restantes de la iteracion anterior.
% ---------------------------------------------------------------------
function [xk,erk,k,conv] = metodo_Gauss_Seidel(A,b,x0,tol,iterMax)
  n = size(A,1);
  xk = x0;
  erk = norm(A*xk-b,2);
  k = 0;
  conv = 0;

  if erk < tol
    conv = 1;
    return;
  endif

  for k = 1:iterMax
    xAnterior = xk;

    for i = 1:n
      suma1 = 0;
      suma2 = 0;

      for j = 1:i-1
        suma1 = suma1+A(i,j)*xk(j);
      endfor

      for j = i+1:n
        suma2 = suma2+A(i,j)*xAnterior(j);
      endfor

      xk(i) = (b(i)-suma1-suma2)/A(i,i);
    endfor

    erk = norm(A*xk-b,2);

    if erk < tol
      conv = 1;
      return;
    endif
  endfor
endfunction


% ---------------------------------------------------------------------
% 8. METODO DEL GRADIENTE CONJUGADO
% Se supone que A es real, simetrica y positiva definida.
% ---------------------------------------------------------------------
function [xk,erk,k,conv] = gradiente_conjugado(A,b,x0,tol,iterMax)
  xk = x0;
  r = b-A*xk;
  p = r;

  erk = norm(A*xk-b,2);
  k = 0;
  conv = 0;

  if erk < tol
    conv = 1;
    return;
  endif

  for k = 1:iterMax
    Ap = A*p;
    alpha = (r'*r)/(p'*Ap);

    xk = xk+alpha*p;
    rNuevo = r-alpha*Ap;
    erk = norm(A*xk-b,2);

    if erk < tol
      conv = 1;
      return;
    endif

    beta = (rNuevo'*rNuevo)/(r'*r);
    p = rNuevo+beta*p;
    r = rNuevo;
  endfor
endfunction
